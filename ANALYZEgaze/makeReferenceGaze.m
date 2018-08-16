

function refGazeTable = makeReferenceGaze

%  Legend
%     ADI:          1
%     ALT:          2
%     BA:           3
%     HDG:          4
%     PWR:          5
%     SPEED:        6
%     VS:           7

%     ADIfocus:     10
%     HDGfocus:     40

% Defining Each Gaze Pattern

% STABLE FLIGHT Scan Pattern --------------------------
% Recurrent .T. Scan
% ADI Cp -> ALT -> VS -> ADI Cp 
% ADI Cp -> SPEED(skippable) -> PWR -> ADI Cp
% ADI Cp -> BA(skippable) -> HDG -> ADI Cp

slfScan = [10;2;7;10;6;5;10;3;40;10];

% CLIMB / DESCENT Scan Pattern ------------------------
% PREP: mental preparation (response time)
% DO:  focus fully on ADI Cp
% FIX: ADI Cp
% PWR: PWR-> ADI Cp ->
% PERFO: ADI Cp -> VS -> ALT -> ADI Cp
% TRIM: --

vertScanA = 10;
vertScanB = 10;
vertScanC = [10;5;10];
vertScanD = [10;7;2;10];

vertScan = [vertScanA;vertScanB;vertScanC;vertScanD];

% CURVE Scan Pattern ----------------------------------
% PREP: mental preparation (response time)
% DO:  focus fully on ADI Cp
% FIX: BA
% PWR: PWR-> ADI Cp ->
% PERFO: ADI Cp -> BA -> HDG -> ADI Cp
% TRIM: --

turnScanA = 10;
turnScanB = 3;
turnScanC = [10;5;10];
turnScanD = [10;3;40;10];

turnScan = [turnScanA;turnScanB;turnScanC;turnScanD];

% COMBINATION Scan Pattern ----------------------------
% PREP: -- (mental preparation / response tPilotsime / job card)
% DO:  focus fully on ADI Cp
% FIX: BA
% PWR: PWR-> ADI Cp ->
% PERFO: ADI Cp -> VS -> ALT -> BA -> HDG -> ADI Cp
% TRIM: --

combScanA = 10;
combScanB = 3;
combScanC = [10;5;10];
combScanD = [10;7;2;3;40;10];

combScan = [combScanA;combScanB;combScanC;combScanD];

% LEVEL-OFF Scan Pattern ------------------------------
% PREP: CP -> ALT

loScan = [10;2];

% ROLL-OUT Scan Pattern -------------------------------
% PREP: CP -> HDG

roScan = [10;40];

%% Creating Full Flight Task (Simulated Flight)

% o Standard Flight Simulation Session
% 
% 1. Straight Level Flight (SLF) 3000 ft. ~20/25sec.
% 2. Left Turn - 20º bank ~50/55sec.
% -> Roll Out to Heading 045º ~4/5sec.
% 3. SLF - ~20/25sec.
% 4. Right Turn - 20º bank ~50/55sec.
% -> Roll Out to Heading 225º ~4/5sec.
% 5. SLF 3000 ft. ~20/25sec.
% 
% 6. Descent 1000 ft. ~ 2min.
% -> Level off ~ 2sec.
% 7. Straight 1000 ft. ~ 20-25sec.
% 8. Climb ~ 2min.
% 9. SLF ~ 20/25sec.
% 
% 10. Descent 1000 ft. ~ 2min.
% -> Level off ~ 2sec.
% 11. Straight 1000 ft. ~ 20-25sec.
% 12. Climb ~ 2min.
% 13. SFL ~ 20/25sec.
% 
% 14. Descent + Right Turn ~ 2min.
% -> Level off + Roll Out ~ 4-5sec.
% 15. Straight 1000 ft. ~ 20-25sec.
% 16. Climb ~ 2min.
% 17. SFL ~ 20/25sec.
% 
% 18. Descent (1000 ft. Vs: 1000 ft/min) + Right Turn (20º bank) ~ 2min.
% -> Level off + Roll Out ~ 4-5sec.
% 19. Straight 1000 ft. ~ 20-25sec.
% 20. Climb (3000 ft. Vs: 1000 ft/min) ~ 2min.
% 21. SFL 3000 ft. ~ 20/25sec.
% 
% 22. Left Turn - 45º bank ~ 9 sec.
% -> Roll Out to Heading 225º ~5/6sec.
% 23. SLF 3000 ft ~ 20/25sec.

flightTasks = {"SLF";'TURN';'RO';'SLF';'TURN';'RO';'SLF';'VERT';'LO';'SLF';'VERT';'SLF';'VERT';'LO';'SLF';'VERT';'SLF';'COMBO';'LO+RO';'SLF';'VERT';'SLF';'COMBO';'LO+RO';'SLF';'VERT';'SLF';'TURN';'RO';'SLF'};

times = {20;50;4;20;50;4;20;120;2;20;120;20;120;2;20;120;20;120;4;20;120;20;120;4;20;120;20;9;5;20};

flightTasks = [flightTasks times];

flightTasks = cell2table(flightTasks);

flightTasks.Properties.VariableNames{1} = 'Task';
flightTasks.Properties.VariableNames{2} = 'ExecutionTime_s';

% How many fixations per second: Average Fixation time

avgFixationTime = 0.4; % in seconds. Taken from Tobii Pro Lab

timesArray = [20;50;4;20;50;4;20;120;2;20;120;20;120;2;20;120;20;120;4;20;120;20;120;4;20;120;20;9;5;20];

fixations = round(timesArray/avgFixationTime);

flightTasks.Fixations = fixations;

% Repeating Patterns

patternsCell = cell(size(flightTasks,1),1);

fixationSequence = zeros(sum(flightTasks.Fixations),1);
fixationsSoFar = 1;

for i=1:size(flightTasks,1)
    
    thisTask = convertStringsToChars(flightTasks.Task(i));
    thisFixationNum = flightTasks.Fixations(i);
    
    switch thisTask
        case 'SLF'
            thisPattern = repmat(slfScan,round(thisFixationNum/length(slfScan)),1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'VERT'
            thisPattern = repmat(vertScan,round(thisFixationNum/length(vertScan)),1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'TURN'
            thisPattern = repmat(turnScan,round(thisFixationNum/length(turnScan)),1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'COMBO'
            thisPattern = repmat(combScan,round(thisFixationNum/length(combScan)),1);
            patternsCell{i} = thisPattern;            
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'LO'
            thisPattern = repmat(loScan,round(thisFixationNum/length(loScan)),1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'RO'
            thisPattern = repmat(roScan,round(thisFixationNum/length(roScan)),1);
            patternsCell{i} = thisPattern;                 
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'LO+RO'    % ISSUE! Any special pattern??
            thisPattern = repmat(roScan,round(thisFixationNum/length(roScan)),1); % ISSUE Check if makes sense
            patternsCell{i} = thisPattern;                 
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;            
    end
    
    fixationsSoFar = fixationsSoFar + size(thisPattern,1);
    
end

flightTasks = [flightTasks patternsCell];
flightTasks.Properties.VariableNames{4} = 'VisualPatterns';

refGazeTable = fixationSequence;

% Transform Fixation in X and Y Coordinate

refGazeX = zeros(size(refGazeTable,1),1);
refGazeY = zeros(size(refGazeTable,1),1);

for j=1:size(refGazeTable,1)
    
    thisFixation = refGazeTable(j);
    
    % Values Below are in PIXELS. Taken from Photoshop Masks!
    
    switch thisFixation
        
        case 1
            refGazeX(j) = 626;
            refGazeY(j) = 269;
        case 2
            refGazeX(j) = 911;
            refGazeY(j) = 284;
        case 3
            refGazeX(j) = 614;
            refGazeY(j) = 87;
        case 4
            refGazeX(j) = 615;
            refGazeY(j) = 561;
        case 5
            refGazeX(j) = 1270;
            refGazeY(j) = 94;
        case 6
            refGazeX(j) = 352;
            refGazeY(j) = 299;
        case 7
            refGazeX(j) = 987;
            refGazeY(j) = 283;
        case 10
            refGazeX(j) = 614;
            refGazeY(j) = 303;
        case 40
            refGazeX(j) = 616;
            refGazeY(j) = 418;
    end
end

refGazeTable = [refGazeTable refGazeX refGazeY];

refTimestamps = 0:0.4:sum(timesArray);
refTimestamps = (refTimestamps')*1000;  % in ms

refGazeTable = [refTimestamps refGazeTable];

refGazeTable = array2table(refGazeTable);

refGazeTable.Properties.VariableNames{1} = 'Timestamps';
refGazeTable.Properties.VariableNames{2} = 'GazeAOI';
refGazeTable.Properties.VariableNames{3} = 'GazeX';
refGazeTable.Properties.VariableNames{4} = 'GazeY';

% plot(refTimestamps,refGazeX);
% plot(refTimestamps,refGazeY);
% scatter(refGazeX,refGazeY);

%% Playing with Satistics

smallX = refGazeX(1:10);
smallY = refGazeY(1:10);
smallTime = refTimestamps(1:10);

[fittedX, ~] = createFitInterpolatingCubic(smallTime, smallX);
[fittedY, ~] = createFitInterpolatingCubic(smallTime, smallY);

instants = 100:1000:3500;

figure;
hold on;

for i = 1:length(instants)
    instant = instants(i);
    mu = [fittedX(instant) fittedY(instant)];
    Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
    x1 = 0:10:1216; x2 = 0:10:764;
    [X1,X2] = meshgrid(x1,x2);
    F = mvnpdf([X1(:) X2(:)],mu,Sigma);
    F = reshape(F,length(x2),length(x1));
    surf(x1,x2,F);
    caxis('auto');
    % set(h,'LineStyle','none');
    % caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
    % axis([-3 3 -3 3 0 .4])
    xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
end

plot3(fittedX(1:3600),fittedY(1:3600),1e-04*ones(3600),'Color','red','LineWidth', 3);

%% Distribution for Each Instrument

% ADI
ADIx = 626;
ADIy = 269;

mu = [ADIx ADIy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_adi = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_adi = reshape(F_adi,length(x2),length(x1));

%ALT
ALTx = 911;
ALTy = 284;

mu = [ALTx ALTy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_alt = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_alt = reshape(F_alt,length(x2),length(x1));

%BA
BAx = 614;
BAy = 87;

mu = [BAx BAy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_ba = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_ba = reshape(F_ba,length(x2),length(x1));

%HDG
HDGx = 615;
HDGy = 561;

mu = [HDGx HDGy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_hdg = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_hdg = reshape(F_hdg,length(x2),length(x1));

%PWR
PWRx = 1270;
PWRy = 94;

mu = [PWRx PWRy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_pwr = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_pwr = reshape(F_pwr,length(x2),length(x1));

%SPEED

SPEEDx = 352;
SPEEDy = 299;

mu = [SPEEDx SPEEDy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_speed = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_speed = reshape(F_speed,length(x2),length(x1));

% VS

VSx = 987;
VSy = 283;

mu = [VSx VSy];
Sigma = [2500 300; 300 1000]; % ISSUE - how to define variance and covariance??
x1 = 0:10:1216; x2 = 0:10:764;
[X1,X2] = meshgrid(x1,x2);
F_vs = mvnpdf([X1(:) X2(:)],mu,Sigma);
F_vs = reshape(F_vs,length(x2),length(x1));

%% Obtain resultant Cloud from Interaction of K-Pattern Prediction and Instrument Gradient Map

Cloud = F*F_adi;
% .... for the others


    
% p1 = -46.98;
% p2 = -24.95;
% p3 = 258.5;
% p4 = 121.8;
% p5 = -459.9;
% p6 = -190.6;
% p7 = 306.2;
% p8 = 92.87;
% p9 = -68.03;
% p10 = 742;
% 
% f(x) = p1*x^9 + p2*x^8 + p3*x^7 + p4*x^6 + p5*x^5 + p6*x^4 + p7*x^3 + p8*x^2 + p9*x + p10;


end
