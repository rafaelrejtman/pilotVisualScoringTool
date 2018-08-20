
% Statistical Distribution Analysis of Gaze Points

function totalMode = coordinatesStatisticalAnalysis(mappedGazeTable,boolPrintGraphs)

% Gaze Coordinates Distribution

%% X Distribution

gazeDistX = mappedGazeTable.AutoMapX;

pdf_normmixtureX = @(gazeDistX,p,mu1,mu2,sigma1,sigma2) p*normpdf(gazeDistX,mu1,sigma1) + (1-p)*normpdf(gazeDistX,mu2,sigma2);

pStartX = .5;
muStartX = quantile(gazeDistX,[.25 .75]);
sigmaStartX = sqrt(var(gazeDistX) - .25*diff(muStartX).^2);
startX = [pStartX muStartX sigmaStartX sigmaStartX];

lbX = [0 -Inf -Inf 0 0];
ubX = [1 Inf Inf Inf Inf];
optionsX = statset('MaxIter',300, 'MaxFunEvals',600);
paramEstsX = mle(gazeDistX, 'pdf',pdf_normmixtureX, 'start',startX, 'lower',lbX, 'upper',ubX, 'options',optionsX);

xgrid = linspace(1.1*min(gazeDistX),1.1*max(gazeDistX),200);
pdfgridX = pdf_normmixtureX(xgrid,paramEstsX(1),paramEstsX(2),paramEstsX(3),paramEstsX(4),paramEstsX(5));

[pksX,locsX] = findpeaks(pdfgridX);
modeX = length(pksX);

%% Y Distribution

gazeDistY = mappedGazeTable.AutoMapY;

pdf_normmixtureY = @(gazeDistY,p,mu1,mu2,sigma1,sigma2) p*normpdf(gazeDistY,mu1,sigma1) + (1-p)*normpdf(gazeDistY,mu2,sigma2);

pStartY = .5;
muStartY = quantile(gazeDistY,[.15 .75]);
sigmaStartY = sqrt(var(gazeDistY) - .25*diff(muStartY).^2);
startY = [pStartY muStartY sigmaStartY sigmaStartY];

lbY = [0 -Inf -Inf 0 0];
ubY = [1 Inf Inf Inf Inf];
optionsY = statset('MaxIter',800, 'MaxFunEvals',1000);
paramEstsY = mle(gazeDistY, 'pdf',pdf_normmixtureY, 'start',startY, 'lower',lbY, 'upper',ubY, 'options',optionsY);

ygrid = linspace(1.1*min(gazeDistY),1.1*max(gazeDistY),200);
pdfgridY = pdf_normmixtureY(ygrid,paramEstsY(1),paramEstsY(2),paramEstsY(3),paramEstsY(4),paramEstsY(5));

[pksY,locsY] = findpeaks(pdfgridY);
modeY = length(pksY);

%% Summing Modes

totalMode = modeX + modeY;

%% Print Graphs

if boolPrintGraphs
    figure;
    findpeaks(pdfgridX);
    hold on;
    findpeaks(pdfgridY);
    legend('X Coordinates','X Peaks','Y Coordinates','Y Peaks');
end

end