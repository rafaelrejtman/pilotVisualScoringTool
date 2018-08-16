
% Statistical Distribution Analysis of Gaze Points

%% By Using Matched Gaze

gazeDist = matchedGazeTable.AOI_hit;

[h,p,stats] = runstest(gazeDist); %if h = 1, it is not random

%% By Using Gaze Coordinates

gazeDistX = mappedGazeTable.AutoMapX;
gazeDistY = mappedGazeTable.AutoMapY;

figure;

[trueGazeX,trueGazeY] = createNormalFits(gazeDistX,gazeDistY);

clearvars -except mappedGazeTable matchedGazeTable offsetMappedGazeTable trueGazeX trueGazeY recDur recName

% distributionFitter

%% Compare to Ideal Distributuion / Reference Distributuion

refGazeTable = makeReferenceGaze;

gazeDistX = refGazeTable.GazeX;
gazeDistY = refGazeTable.GazeY;

figure;

[idealGazeX,idealGazeY] = createNormalFits(gazeDistX,gazeDistY);
