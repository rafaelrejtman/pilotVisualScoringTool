

% Statistical Distribution Analysis of Gaze Points

%% REAL GAZE

gazeDist = matchedGazeTable.AOI_hit;

%% AOI Percentile

%  Legend
%     ADI:          1
%     ALT:          2
%     BA:           3
%     HDG:          4
%     PWR:          5
%     SPEED:        6
%     VS:           7

%     ADIfocus:     10
%     HDGfocus:     40

percDist = tabulate(gazeDist);

percDistT = array2table(percDist);

percDistT.Properties.VariableNames{1} = 'Instrument';
percDistT.Properties.VariableNames{2} = 'Dwells';
percDistT.Properties.VariableNames{3} = 'Percentage_in_time';
percDistT = sortrows(percDistT,'Percentage_in_time','descend');

% percDistC = num2cell(percDist);
% 
% instrumentsStrs = {'Non-Area';'ADI';'ALT';'BA';'HDG';'PWR';'SPEED';'VS';'ADIfoucs';'HDGfocus'};
% 
% percDistC(:,1) = instrumentsStrs;
% 
% percDistT = cell2table(percDistC);

clearvars percDist percDistC;

%% Gaze Coordinates Distribution

mappedGazeTable = offsetMappedGazeTable;

gazeDistX = mappedGazeTable.AutoMapX;
gazeDistY = mappedGazeTable.AutoMapY;

figure;

[trueGazeX,trueGazeY] = createNormalFits(gazeDistX,gazeDistY);

clearvars -except mappedGazeTable matchedGazeTable offsetMappedGazeTable trueGazeX trueGazeY recDur recName

% distributionFitter

%% REFERENCE GAZE

% 1.IDEAL REFERENCE GAZE (Based on K Deterministic Model)

idealGazeTable = makeReferenceGaze;

% AOI Percentile 

idealAOI = idealGazeTable.GazeAOI;

idealPercDist = tabulate(idealAOI);

idealPercDist(end+1,:) = [0 0 0];

idealPercDist(~ismember(idealPercDist(:,1),[0 1 2 3 4 5 6 7 10 40]),:) = [];

idealPercDistT = array2table(idealPercDist);

idealPercDistT.Properties.VariableNames{1} = 'Instrument';
idealPercDistT.Properties.VariableNames{2} = 'Dwells';
idealPercDistT.Properties.VariableNames{3} = 'Percentage_in_time';
idealPercDistT = sortrows(idealPercDistT,'Percentage_in_time','descend');


% idealPercDistC = num2cell(idealPercDist);
% idealPercDistC(:,1) = instrumentsStrs;

% XY Distribution

idealGazeDistX = idealGazeTable.GazeX;
idealGazeDistY = idealGazeTable.GazeY;

% figure;

% [idealGazeX,idealGazeY] = createNormalFits(gazeDistX,gazeDistY);
