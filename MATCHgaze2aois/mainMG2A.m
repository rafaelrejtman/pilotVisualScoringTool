
%This is a MODULE Main
function matchedGazeTable = mainMG2A(thisMGT)

% Match Gaze to AOI MODULE
% Matches gaze points to AOI regions defined by masks. Returns a table
% containing which instrument is looked at at each Timestamp.

AOImasks = importMasks;

matchedGazeTable = matchGaze(thisMGT,AOImasks,0);

end

