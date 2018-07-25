
% Show Image and Initialize Polygon
imshow('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/G1000-Ken.png');

i = 1;

btnCircle = uicontrol('Style', 'pushbutton', 'String', 'Circle','Position', [20 20 50 20],'Callback','i = i+1; e(i) = imellipse(gca)');

j = 1;

btnRect = uicontrol('Style', 'pushbutton', 'String', 'Rect','Position', [110 20 50 20],'Callback','j = j+1; r(i) = imrect(gca)');

k = 1;

btnPoly = uicontrol('Style', 'pushbutton', 'String', 'Poly','Position', [200 20 50 20],'Callback','k = k+1; p(i) = impoly(gca)');

btnGetPos = uicontrol('Style', 'pushbutton', 'String', 'GetPos','Position', [300 20 50 20],'Callback');