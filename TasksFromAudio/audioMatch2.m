
%% Audio Match
% Looks for match of the command audio with the recording Audio. Returns
% the Timestamp where the match was found.

function [match, matchTSbegin, matchTSend] = audioMatch2(resInstrSignal,resRecSignal,resFreq, plotRes)

%% Later Implement Flexible Input Function
% The following parameters are exluding options:     o               x               x       |         p                 q                q         boolean       
% Provide either 'o' or 'x'; 'p' or 'q'
% Providing (o,~,~,~,q,q,0) is a good option for performance!

%% NYC Test
% instrAudioFile = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Coding/MATLAB V2/Sound Filtering Module/doubleNYC.wav';
% fullRecAudioFile = instrAudioFile;

%% One Instr. Test
% instrAudioFile = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Coding/MATLAB V2/CAE Reference Recordings/rolloutleveloff1000ft.wav';
% fullRecAudioFile = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Coding/MATLAB V2/CAE Audio Recordings/test4.mp3';

%% Matching Audio by Correlation

fSampling = resFreq;

[C,lags] = xcorr(resRecSignal,resInstrSignal(:,1));

lags = lags';

correlationScore = var(maxk(C,100));

if correlationScore > 0.5
    match = 1;
    [~,I] = max(abs(C));
    maxLag = lags(I);
    samplesDiff = abs(maxLag);
    commandSize = size(resInstrSignal,1);
    matchTimeStamp = samples2ms(samplesDiff,fSampling); %in MilliSeconds!
    
    %% Plotting for Visual Verification
    if plotRes
        Trial = NaN(size(resRecSignal,1),1);
        Trial(samplesDiff:(samplesDiff+commandSize-1)) = resInstrSignal(:,1);
        Time = (0:1/fSampling:(size(resRecSignal,1)-1)/fSampling)';
        figure;
        hold on;
        plot(Time,resRecSignal);
        plot(Time, Trial);
        xlabel('Time (s)');
        ylabel('Clean');
        axis tight;
    end
else
    match = 0;
    matchTimeStamp = -1;
    commandSize = 0;
end

%% Output

matchTSbegin = matchTimeStamp;
matchTSend = matchTimeStamp + samples2ms(commandSize,fSampling); 

end

