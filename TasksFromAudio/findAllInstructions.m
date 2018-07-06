
% Look for all Instructions on Audio File
% Script for Batch Searching all Instructions on a CAE Audio Recording

function tableT = findAllInstructions(fullRecAudioFile)

%% Reading Recording Audio

fullRecAudioFile = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/CAE Reference Data/CAE Audio Recordings/test4.mp3';

[fullRecAudioSignal, fullRecAudioFreq] = audioread(fullRecAudioFile);

% Making Signals MONO

if size(fullRecAudioSignal,2)>1
    fullRecAudioSignal = fullRecAudioSignal(:,1);
end

%% Reading Reference Audio

FileListing = dir('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/CAE Reference Data/CAE Instruction Recordings/*.wav');

n = size(FileListing,1); % number of instructions in folder

instrSignals = cell(n,3);

for k = 1:n % Look for each instruction
        
        instrName = FileListing(k).name;
        
        instrAudioFile = strcat('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/CAE Reference Data/CAE Instruction Recordings/',instrName);

        [tempSig,instrSignals{k,2}]= audioread(instrAudioFile);
        
        % Making Signals MONO
        if size(tempSig,2)>1
            tempSig = tempSig(:,1);
        end        
        
        % Assignments
        instrSignals{k,1} = tempSig;
        instrSignals{k,3} = instrName;
end

%% Determining ReSampling Frequencies

maxVoiceFreq = 3000; % in Hz
fnyquist = (2*maxVoiceFreq)+10;

%% Resampling Full Recording

[p,q] = rat(fnyquist/fullRecAudioFreq);

resFullRecSignal = resample(fullRecAudioSignal,p,q);
resFsFullRec = fullRecAudioFreq*(p/q);

%% Resampling Instructions

resInstrSignals = instrSignals;

for o = 1:n
   
    currentSig = instrSignals{o,1};
    currentFreq = instrSignals{o,2};
    
    [p2,q2] = rat(fnyquist/currentFreq);
    resInstrSignal = resample(currentSig,p2,q2);
    
    resInstrSignals{o,1} = resInstrSignal;
    resInstrSignals{o,2} = currentFreq*(p2/q2);
    
end
%% Moving Window Audio Searching Task

tempRec = resFullRecSignal;
tempFreq = resFsFullRec;

% Moving  Window
% winBegin is the changing variable
winBegin = 0; % in Milliseconds
winSize = 10000; % 10s window
winEnd = winBegin + winSize;

lastTimeStamp = (size(tempRec,1)/tempFreq)*1000;
j = 1;

T = cell(50,3);

while winEnd < lastTimeStamp
    
    recClip = tempRec(round(ms2samples(winBegin,tempFreq)):round(ms2samples(winEnd,tempFreq)));
    
    for i = 1:n % Look for each instruction
        
        currentInstr = resInstrSignals{i,1};
        
        instrName = resInstrSignals{i,3};
        
        [match,matchTSbegin,matchTSend] = audioMatch2(currentInstr,recClip,tempFreq,0);
        
        if match
            T{j,1} = (matchTSbegin+winBegin)/1000;
            T{j,2} = (matchTSend+winBegin)/1000;
            T{j,3} = instrName;
            winBegin = winBegin+matchTSend; % we advance through the recording
            j = j+1;
            break;
        end
        
    end
    
    % If we ever circle all instructions and find none, this means we are at
    % the ending of the Recording
    if i == n
        winBegin = winEnd;
    end
    
    % Slicing the Recording

    winEnd = winBegin + winSize;     
        
end

%% Formatting T

af = cellfun('isempty',T);
af = af(:,1);
ff = find(af);
firstline = ff(1);
T(firstline:end,:) = [];

v = size(T,1);
for c = 1:v
    T{c,3} = T{c,3}(1:end-4);
end

tableT = cell2table(T);
tableT.Properties.VariableNames{1} = 'TSBegin';
tableT.Properties.VariableNames{2} = 'TSEnd';
tableT.Properties.VariableNames{3} = 'Instruction';

end
