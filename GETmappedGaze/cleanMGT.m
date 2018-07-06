
% Clean Mapped Gaze Table
% Script for cleaning the MGT, removing NaN's, and other noise

function cleanMappedGazeTable = cleanMGT(a_mappedGazeTable)

%% Removing NaN Rows

MGA = table2array(a_mappedGazeTable);
MGA1 = table2array(a_mappedGazeTable(:,2));
range1 = isnan(MGA1);
MGA(range1,:) = [];

%% BELOW Correct but Unnecessary (whenever there's a NaN, all columns are NaN!!)
% 
% MGA2 = table2array(MGT(:,3));
% MGA3 = table2array(MGT(:,4));
% 
% range2 = isnan(MGA2);
% range3 = isnan(MGA3);
% 
% rangeT = or(range1,range2);
% rangeT = or(rangeT,range3);

%% Change Coordinate System (to standard 0-0 Matlab System)

% Get this from tsv!!! ISSUE!
snapHeight = 926; %careful! use to correct y measures
snapWidth = 1418; %use to correct x measures

% X coordinate stays the same

% Y coordinate is translated by (1418) and flipped (*-1)

MGAy = MGA(:,4);
MGAy = MGAy - snapHeight;
MGAy = (-1)*MGAy;

MGA(:,4) = MGAy;

%% Format and Return

cleanMappedGazeTable = array2table(MGA);

cleanMappedGazeTable.Properties.VariableNames{1} = 'Timestamp';
cleanMappedGazeTable.Properties.VariableNames{2} = 'AutoMapScore';
cleanMappedGazeTable.Properties.VariableNames{3} = 'AutoMapX';
cleanMappedGazeTable.Properties.VariableNames{4} = 'AutoMapY';

end