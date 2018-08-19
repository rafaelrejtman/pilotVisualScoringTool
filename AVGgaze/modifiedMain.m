
% Executes All Sub-mains from Individual Modules

function [realPercDist,recName] = modifiedMain(filename)

global offsetMappedGazeTable recDur matchedGazeTable;

[mappedGazeTable,recDur,recName] = mainGMG2(filename);

offsetMappedGazeTable = mainOMG(mappedGazeTable,recName,0);

clearvars mappedGazeTable;

matchedGazeTable = mainMG2A(offsetMappedGazeTable);

% idealGazeTable = makeReferenceGaze;

realPercDist = modifiedNewStatisticalAnalysis(matchedGazeTable);

end