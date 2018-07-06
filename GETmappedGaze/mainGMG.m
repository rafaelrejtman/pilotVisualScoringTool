
%This is a MODULE Main
function [mappedGazeTable,recDur,recName] = mainGMG

% GETmappedGaze MODULE
% Extracts a Table from a Tobii exported .tsv File

% Executes the methods in this local Module, to extract the Mapped Gaze
% Data from the Tobii .tsv files

this_rawGazeTable = getRGTfromTSV; %filename ISSUE (include later)

[this_mappedGazeTable,~,recName,recDur] = getMGTfromRGT(this_rawGazeTable);

mappedGazeTable = cleanMGT(this_mappedGazeTable);

end

