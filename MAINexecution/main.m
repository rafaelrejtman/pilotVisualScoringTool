
% Executes All Sub-mains from Individual Modules

function [score,recName] = main(filename,avgGaze)

global offsetMappedGazeTable recDur matchedGazeTable;

[mappedGazeTable,recDur,recName] = mainGMG2(filename);

offsetMappedGazeTable = mainOMG(mappedGazeTable,recName,0);

clearvars mappedGazeTable;

matchedGazeTable = mainMG2A(offsetMappedGazeTable);

% idealGazeTable = makeReferenceGaze;

score = newStatisticalAnalysis(matchedGazeTable,avgGaze);

end