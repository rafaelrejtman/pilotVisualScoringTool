
% Obtaining an Automatic Offset value for the Gaze Data
% Getting an offset Value for X and Y based on the Obtained HeatPoint

function [ocMGT,deltaOffset] = autoOffset(heatPoint,thisMGT)

%% Determining the Reference Point Position - ADI CP
% The ADI CP is determined here in terms of true pixels in X and Y
% (based on Photoshop data)

[refPointx,refPointy] = defineRefPoint;

%% Determining Distance to heatPoint

deltaX = refPointx - heatPoint(1);
deltaY = refPointy - heatPoint(2);

deltaOffset = [deltaX deltaY];

%% Printing Visual Representation
% 
% hold on;
% 
% scatter(CPmiddle(1),CPmiddle(2),'g^')
% text(CPmiddle(1)-0.12, CPmiddle(2)+0.2, 'Ref: ADI CP');
% 
% scatter(heatPoint(1),heatPoint(2),'bo')
% text(heatPoint(1)-0.12, heatPoint(2)+0.2, 'Detected Heat Point');
% 
% quiver(heatPoint(1),heatPoint(2),deltaX,deltaY);

%% Actually Ofsetting Data Gaze Points

ocMGT = thisMGT;

A = thisMGT.AutoMapX;
B = thisMGT.AutoMapY;

newA = A + deltaOffset(1);
newB = B + deltaOffset(2);

ocMGT.AutoMapX = newA;
ocMGT.AutoMapY = newB;

end

