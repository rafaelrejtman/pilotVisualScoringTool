
function [refPointx,refPointy] = defineRefPoint

% Function Handle
uP = @updatePoly;

% Show Image and Initialize Polygon
imshow('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/G1000-Ken.png');

h = impoly(gca);

currentVertices = uP(h);

referencePoly = polyshape(currentVertices);

[refPointx,refPointy] = centroid(referencePoly);

%Rounding to be in pixels
refPointx = round(refPointx);
refPointy = round(refPointy);

% Obtain Updated Polygon

btnClose = uicontrol('Style', 'pushbutton', 'String', 'Done','Position', [140 20 50 20],'Callback','close; done = 1');

btnUpdatePoly = uicontrol('Style', 'pushbutton', 'String', 'Update Poly','Position', [20 20 100 20],'Callback','currentVertices = uP(h);referencePoly = polyshape(currentVertices);[refPointx,refPointy] = centroid(referencePoly);refPointx = round(refPointx);refPointy = round(refPointy);');

waitfor(h);

end

% addNewPositionCallback(h,@(p) assignin('base','currentVertices',p));


