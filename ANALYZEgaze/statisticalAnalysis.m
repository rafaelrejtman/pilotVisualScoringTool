
% Statistical Distribution Analysis of Gaze Points

gazeDist = matchedGazeTable.AOI_hit;

[h,p,stats] = runstest(gazeDist); %if h = 1, it is not random