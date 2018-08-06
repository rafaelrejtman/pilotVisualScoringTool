
% This function imports Masks as alpha channels. The images have been
% created in Photoshop, by utiling vector shapes to define ROIs on top of
% the G1000 panel and according to advices given by Ken at CAE

function AOImasks = importMasks

%% Importing Images

strGeneralPath = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/Masks (with AntiAlias)/';

% ADI
ADI = importdata(strcat(strGeneralPath,'ADI_mask.png'));
maskADI = ADI.alpha;

% ADIfocus
ADIfocus = importdata(strcat(strGeneralPath,'ADIfocus_mask.png'));
maskADIfocus = ADIfocus.alpha;

% ALT
ALT = importdata(strcat(strGeneralPath,'ALT_mask.png'));
maskALT = ALT.alpha;

% BA
BA = importdata(strcat(strGeneralPath,'BA_mask.png'));
maskBA = BA.alpha;

% HDG
HDG = importdata(strcat(strGeneralPath,'HDG_mask.png'));
maskHDG = HDG.alpha;

% HDGfocus
HDGfocus = importdata(strcat(strGeneralPath,'HDGfocus_mask.png'));
maskHDGfocus = HDGfocus.alpha;

% PWR
PWR = importdata(strcat(strGeneralPath,'PWR_mask.png'));
maskPWR = PWR.alpha;

% SPEED
SPEED = importdata(strcat(strGeneralPath,'SPEED_mask.png'));
maskSPEED = SPEED.alpha;

% VS
VS = importdata(strcat(strGeneralPath,'VS_mask.png'));
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

