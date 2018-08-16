
% Pattern Collecting

%% Defining K Reference Patterns

Kpatts = makeKpatterns;

%% Removing Gazes to Non-Areas (Zero Gaze)

matchedGazeTableBckp = matchedGazeTable;

matchedGazeTable(matchedGazeTable.AOI_hit==0,:) = [];

%% Clean Matched Gaze - Removing Repetitions

cleanMatchedGazeTable = nan(height(matchedGazeTable),2);

% Establishing First Element
% Element Count!
e = 1;
thisElement = matchedGazeTable.AOI_hit(1);
cleanMatchedGazeTable(e,1) = thisElement; %new element added
initialTimestamp = matchedGazeTable.Timestamp(1);
lastElement = thisElement;clc

for i=2:height(matchedGazeTable)
    
    thisElement = matchedGazeTable.AOI_hit(i);
    
    if thisElement ~= lastElement
        e = e+1;
        % Close precedent Element Loop
        finalTimestamp = matchedGazeTable.Timestamp(i-1);
        cleanMatchedGazeTable(e-1,2) = finalTimestamp-initialTimestamp;
        % Begin new Element Loop
        cleanMatchedGazeTable(e,1) = thisElement; %new element added
        initialTimestamp = matchedGazeTable.Timestamp(i);
    end
    
    lastElement = thisElement;
    
end

cleanMatchedGazeTable(isnan(cleanMatchedGazeTable(:,1)),:) = [];

%% Removing Gazes that are too Quick (Zero Duration)

instrumentGazeSequence = cleanMatchedGazeTable(cleanMatchedGazeTable(:,2)~=0,:);
instrumentGazeSequence = instrumentGazeSequence(1:end-1,:); %last line has duration NaN

%% Removing Repetitions Again

% e = 1;
% thisElement = instrumentGazeSequence(1);
% cleanMatchedGazeTable(e,1) = thisElement; %new element added
% initialTimestamp = matchedGazeTable.Timestamp(1);
% lastElement = thisElement;clc
% 
% for i=2:height(matchedGazeTable)
%     
%     thisElement = matchedGazeTable.AOI_hit(i);
%     
%     if thisElement ~= lastElement
%         e = e+1;
%         % Close precedent Element Loop
%         finalTimestamp = matchedGazeTable.Timestamp(i-1);
%         cleanMatchedGazeTable(e-1,2) = finalTimestamp-initialTimestamp;
%         % Begin new Element Loop
%         cleanMatchedGazeTable(e,1) = thisElement; %new element added
%         initialTimestamp = matchedGazeTable.Timestamp(i);
%     end
%     
%     lastElement = thisElement;
%     
% end

%% Putting in Table for organized view
% cleanMatchedGazeTable = table(cleanMatchedGazeTable(:,1),cleanMatchedGazeTable(:,2));
% cleanMatchedGazeTable.Properties.VariableNames{1} = 'Instrument';
% cleanMatchedGazeTable.Properties.VariableNames{2} = 'Duration_of_Gaze';

%% Looking For Patterns (7-12 Instruments)

% Changeable Variables

% Mininum Number of Instruments

MININ = 7;

% Maximum Number of Instruments

MAXIN = 12;

% Moving Window Size

WIN = 15;

% Size of foundPatterns Cell
% Biggest possible would be length(instrumentGazeSequence)

CELLSIZE = length(instrumentGazeSequence); %with 20% margin

foundPatterns = cell(CELLSIZE,3);
patternCount = 0;

for anchor = 1:(length(instrumentGazeSequence)-(WIN-1))

localSeq = instrumentGazeSequence(anchor:anchor+(WIN-1),1);
localDur = instrumentGazeSequence(anchor:anchor+(WIN-1),2);

thisPattern = nan(MAXIN,1);
thisPattern(1:MININ-1) = localSeq(1:MININ-1);
firstElement = thisPattern(1);
foundPatt = 0;

for localIndex = MININ:MAXIN
    
    thisElement = localSeq(localIndex);
    thisPattern(localIndex) = thisElement;
    
    if thisElement == firstElement
        foundPatt = 1;
        patternCount = patternCount+1;
        break
    end
           
end

if foundPatt
    thisPattern(isnan(thisPattern)) = [];
    duration = sum(localDur(1:length(thisPattern)));
    matchedK = match2K(thisPattern,Kpatts);
    foundPatterns{patternCount,1} = thisPattern;
    foundPatterns{patternCount,2} = duration;
    foundPatterns{patternCount,3} = matchedK;
end

end

foundPatterns(patternCount+1:end,:) = [];

function matchedK = match2K(pattern,Kpatts)

% Defining Reference Patterns

if isequal(pattern,Kpatts{1,1})
    matchedK = Kpatts{1,2};
elseif isequal(pattern,Kpatts{2,1})
    matchedK = Kpatts{2,2};
elseif isequal(pattern,Kpatts{3,1})
    matchedK = Kpatts{3,2};
elseif isequal(pattern,Kpatts{4,1})
    matchedK = Kpatts{4,2};
% Not considering just 3 instr for now    
% elseif isequal(pattern,Kpatts{5,1})
%     matchedK = Kpatts{4,2};
% elseif isequal(pattern,Kpatts{6,1})
%     matchedK = Kpatts{4,2};
else
    matchedK = nan;
end
 
end


