

function SCORE = newStatisticalAnalysis(realGaze,avgGaze)
% Analysis of Gaze Points by Simple Statiscal approach

defaultInstr = [0 1 2 3 4 5 6 7 10 40];

%% REAL GAZE

% Obtaining real gaze
realGaze = realGaze.AOI_hit;

% AOI Percentile

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

realPercDist = tabulate(realGaze);

realInstr = realPercDist(:,1);

missingInstr = setdiff(defaultInstr,realInstr);
% missingInstr = setdiff(realInstr,realInstr);

realPercDist = [realPercDist;nan(length(missingInstr),3)];

k = 1;

for i=size(realPercDist,1)-length(missingInstr)+1:size(realPercDist,1)
    
    realPercDist(i,:) = [missingInstr(k) 0 0];
    k = k+1;
    
end

realPercDist = sortrows(realPercDist,1); % sorted by instrument

% Gaze Coordinates Distribution

% mappedGazeTable = offsetMappedGazeTable;
% 
% gazeDistX = mappedGazeTable.AutoMapX;
% gazeDistY = mappedGazeTable.AutoMapY;
% 
% figure;
% 
% [realGazeXnormal,realGazeYnormal] = createNormalFits(gazeDistX,gazeDistY);
% 
% clearvars gazeDist gazeDistX gazeDistY

%% REFERENCE GAZE

% % 1.IDEAL REFERENCE GAZE (Based on K Deterministic Model)
% 
% % Obtaining ideal gaze
% idealGazeTable = makeReferenceGaze;
% 
% % AOI Percentile 
% 
% idealAOI = idealGazeTable.GazeAOI;
% 
% idealPercDist = tabulate(idealAOI);
% 
% idealPercDist(end+1,:) = [0 0 0];
% 
% idealPercDist(~ismember(idealPercDist(:,1),[0 1 2 3 4 5 6 7 10 40]),:) = [];
% 
% idealPercDist = sortrows(idealPercDist); %sorted based on instruments
% 
% % Gaze Coordinates Distribution
% 
% idealGazeDistX = idealGazeTable.GazeX;
% idealGazeDistY = idealGazeTable.GazeY;
% 
% % figure;
% 
% % [idealGazeX,idealGazeY] = createNormalFits(gazeDistX,gazeDistY);
% 
% clearvars idealAOI idealGazeTable;

% 2. AVERAGE GAZE (Based on average of experienced POST pilots)



% avgPercDist = tabulate(avgGaze.realGaze);
% 
% % idealPercDist(end+1,:) = [0 0 0];
% % 
% % idealPercDist(~ismember(idealPercDist(:,1),[0 1 2 3 4 5 6 7 10 40]),:) = [];
% 
% avgPercDist = sortrows(avgPercDist); %sorted based on instruments


%% COMPARING RESULTS

% AOI Percentil

% By Norm

% idealPercentile = idealPercDist(:,3);
realPercentile = realPercDist(:,3);
avgPercentile = avgGaze;

N = norm(avgPercentile-realPercentile);

SCORE = 100-N;


end

