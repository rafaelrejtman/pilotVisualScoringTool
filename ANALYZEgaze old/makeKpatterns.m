
function Kpatterns = makeKpatterns

Kpatterns = cell(6,2);

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

loScan = [10;2;10];

% ROLL-OUT Scan Pattern -------------------------------
% PREP: CP -> HDG

roScan = [10;40;10];

Kpatterns{1,1} = slfScan;
Kpatterns{1,2} = 'slfScan';
Kpatterns{2,1} = vertScan;
Kpatterns{2,2} = 'vertScan';
Kpatterns{3,1} = turnScan;
Kpatterns{3,2} = 'turnScan';
Kpatterns{4,1} = combScan;
Kpatterns{4,2} = 'combScan';
Kpatterns{5,1} = roScan;
Kpatterns{5,2} = 'roScan';
Kpatterns{6,1} = loScan;
Kpatterns{6,2} = 'loScan';

end