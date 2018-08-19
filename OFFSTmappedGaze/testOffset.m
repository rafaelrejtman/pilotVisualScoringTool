
function testOffset(oldMappedGazeTable,offsetMappedGazeTable, heatPoint, deltaOffset) 

figure;

imshow('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/G1000-Ken.png');

hold on;

oldGazePoints = table2array(oldMappedGazeTable);
oGPx = oldGazePoints(:,3);
oGPy = oldGazePoints(:,4);

s1 = scatter(oGPx,oGPy,'MarkerEdgeColor','green','MarkerFaceColor','green');
hold on;

newGazePoints = table2array(offsetMappedGazeTable);
nGPx = newGazePoints(:,3);
nGPy = newGazePoints(:,4);

s2 = scatter(nGPx,nGPy);

oHP = heatPoint;
nHP = oHP+deltaOffset;

s3 = scatter(oHP(1),oHP(2),'b+');
s4 = scatter(nHP(1),nHP(2),'b+');

q = quiver(oHP(1),oHP(2),(nHP(1)-oHP(1)),(nHP(2)-oHP(2)));

q.Color = 'blue';
q.LineWidth = 1;

% Old
s1.MarkerFaceAlpha = 0.05;
s3.MarkerFaceAlpha = 0.05;

% New
s2.MarkerFaceAlpha = 0.1;
s4.MarkerFaceAlpha = 0.1;

% Old
s1.MarkerEdgeAlpha = 0.05;
s3.MarkerEdgeAlpha = 0.05;

% New
s2.MarkerEdgeAlpha = 0.05;
s4.MarkerEdgeAlpha = 0.05;

set(gca,'Ydir','reverse');

end
