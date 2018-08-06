
% Executes All Sub-mains from Individual Modules

function main

global mappedGazeTable offsetMappedGazeTable matchedGazeTable recDur recName;

[mappedGazeTable,recDur,recName] = mainGMG;

offsetMappedGazeTable = mainOMG(mappedGazeTable,recName,1);

matchedGazeTable = mainMG2A(offsetMappedGazeTable);

end