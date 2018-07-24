
function testOffset(oldMappedGazeTable,offsetMappedGazeTable, heatPoint, deltaOffset) 

figure;

oldGazePoints = table2array(oldMappedGazeTable);
oGPx = oldGazePoints(:,3);
oGPy = oldGazePoints(:,4);

scatter(oGPx,oGPy);
hold on;

newGazePoints = table2array(offsetMappedGazeTable);
nGPx = newGazePoints(:,3);
nGPy = newGazePoints(:,4);

scatter(nGPx,nGPy);

oHP = heatPoint;
nHP = oHP+deltaOffset;

scatter(oHP(1),oHP(2),'g+');
scatter(nHP(1),nHP(2),'g+');

q = quiver(oHP(1),oHP(2),(nHP(1)-oHP(1)),(nHP(2)-oHP(2)));

q.Color = 'green';
q.LineWidth = 1;
