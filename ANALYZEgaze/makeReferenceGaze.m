

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

%% Defining Each Gaze Pattern

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
            thisPattern = repmat(slfScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'VERT'
            thisPattern = repmat(vertScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'TURN'
            thisPattern = repmat(turnScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'COMBO'
            thisPattern = repmat(combScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;            
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'LO'
            thisPattern = repmat(loScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'RO'
            thisPattern = repmat(roScan,thisFixationNum,1);
            patternsCell{i} = thisPattern;                 
            fixationSequence(fixationsSoFar:fixationsSoFar+size(thisPattern,1)-1) = thisPattern;
        case 'LO+RO'
            thisPattern = repmat(roScan,thisFixationNum,1); % ISSUE Check if makes sense
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

refGazeTable = array2table(refGazeTable);

refGazeTable.Properties.VariableNames{1} = 'GazeAOI';
refGazeTable.Properties.VariableNames{2} = 'GazeX';
refGazeTable.Properties.VariableNames{3} = 'GazeY';

end
