
% Identifying a main Heat point in the Mapped Gaze Data
% Attention to: can there be many contradicting heatpoints??

function [heatPoint] = getHeatP(thisMGT,rec_name,printGraphs)

%% Snapshot Parameters
% Get this from TOBii!!! ISSUE!
snapshotHeight = 926; %careful! use to correct y measures
snapshotWidth = 1418; %use to correct x measures

%% Gaze Data
AutoMapX = table2array(thisMGT(:,3));
AutoMapY = table2array(thisMGT(:,4));

AutoMapData = [AutoMapX,AutoMapY];

clearvars AutoMapX AutoMapY;


%% Building Histogram

% Scale factor for nbins

binFactor = gcd(snapshotHeight,snapshotWidth); % the scale factor is used to reduce processing load
%gcd: Greatest Common Denominator: biggest integer scale factor possible

nbins = [snapshotWidth/binFactor, snapshotHeight/binFactor];

% Histogram Matrix
gazeHistogram = hist3(AutoMapData,'CDataMode','auto','FaceColor','interp','Nbins',nbins);

clearvars nbins;

%% Determining Heat Point(s) / Areas

longHistogram = gazeHistogram(:);

% Percentage of Values of the Histogram which will be considered for heat
% Area (sampled)
pValues = 0.0001;

% Number of Sampled Values
nValues = round(pValues*size(longHistogram,1));

% HV: highest values
% HLI: Highest linear indexes
[HV,HLI] = maxk(longHistogram,nValues);

% Extracting the row and column indices of HLI

[HIrow, HIcol] = ind2sub(size(gazeHistogram,1),HLI);

HI = [HIrow HIcol];

clearvars longHistogram pValues nValues HLI HIrow HIcol;

centerROW = round(mean(HI(:,1)));
centerCOL = round(mean(HI(:,2)));

centerPixelX = binFactor*centerROW;
centerPixelY = binFactor*centerCOL;

centerPixel = [centerPixelX centerPixelY];

%% Return Values

heatPoint = centerPixel;

%% Plotting Histogram in 3D and 2D

if printGraphs
    
    % 3D Plot
    figure;
    visual_fact = binFactor*10; % only for visual purposes
    visualNbins = [round(snapshotWidth/visual_fact) round(snapshotHeight/visual_fact)];
    hist3(AutoMapData,'CDataMode','auto','FaceColor','interp','Nbins',visualNbins);
    xlabel('x Pixels');
    ylabel('y Pixels');
    title1 = strcat('3D Histogram - ',rec_name);
    title(title1);
    
    % 2D Plot
    figure;
    hist3(AutoMapData,'CDataMode','auto','FaceColor','interp','Nbins',visualNbins);
    xlabel('x Pixels');
    ylabel('y Pixels');
    view(2);
    title2 = strcat('2D Histogram - ',rec_name);
    title(title2);
    
end

end

%% Future Implementations

% distributionFitter(x);

%% Test 1 - Testing Heat Area Accuracy with simple over image Plotting

% img = imread('histog.png');
% image('CData',img,'XData',[0 1418],'YData',[0 926]);
% hold on;
% scatter(centerPixelX, centerPixelY, 'r.');
% hold off;




