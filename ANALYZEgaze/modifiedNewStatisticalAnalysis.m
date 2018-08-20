

function realPercDist = modifiedNewStatisticalAnalysis(realGaze)
% Analysis of Gaze Points by Simple Statiscal approach

defaultInstr = [0 1 2 3 4 5 6 7 10 40];

%% REAL GAZE

% Obtaining real gaze
realGaze = realGaze.AOI_hit;

% AOI Percentile

%       Legend
%   NON-AREA      0
%   ADI:          1
%   ALT:          2
%   BA:           3
%   HDG:          4
%   PWR:          5
%   SPEED:        6
%   VS:           7
%   ADIfocus:     10
%   HDGfocus:     40

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

end

