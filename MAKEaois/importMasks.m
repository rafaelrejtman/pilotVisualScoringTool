
function AOImasks = importMasks

%% Importing Images

% ADI
ADI = importdata('ADI_mask.png');
maskADI = ADI.alpha;

% ADIfocus
ADIfocus = importdata('ADIfocus_mask.png');
maskADIfocus = ADIfocus.alpha;

% ALT
ALT = importdata('ALT_mask.png');
maskALT = ALT.alpha;

% BA
BA = importdata('BA_mask.png');
maskBA = BA.alpha;

% HDG
HDG = importdata('HDG_mask.png');
maskHDG = HDG.alpha;

% HDGfocus
HDGfocus = importdata('HDGfocus_mask.png');
maskHDGfocus = HDGfocus.alpha;

% PWR
PWR = importdata('PWR_mask.png');
maskPWR = PWR.alpha;

% SPEED
SPEED = importdata('SPEED_mask.png');
maskSPEED = SPEED.alpha;

% VS
VS = importdata('VS_mask.png');
maskVS = VS.alpha;

%% Clearing Variables
clearvars ADI ADIfocus ALT BA HDG HDGfocus PWR SPEED VS;

%% Agregating Masks in Struct

AOImasks.ADI = maskADI;
AOImasks.ADIfocus = maskADIfocus;
AOImasks.ALT = maskALT;
AOImasks.BA = maskBA;
AOImasks.HDG = maskHDG;
AOImasks.HDGfocus = maskHDGfocus;
AOImasks.PWR = maskPWR;
AOImasks.SPEED = maskSPEED;
AOImasks.VS = maskVS;

end

