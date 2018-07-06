
% Cleaning Participant Visual Data extracted from tsv
% Script for getting data from (getPVDtsv) and cleaning it

function [mappedGazeTable,tobiiAOIHit,recName,recDur] = getMGTfromRGT(a_rawGazeTable)

%% Obtaining Constant Parameters

recName = a_rawGazeTable.RecName(1);

recName = recName{1,1};

recDur = a_rawGazeTable.RecDur(1);

% rec_dur = rec_dur{1,1};

clean_table = a_rawGazeTable(:,3:end);

%% Saving Eye Movement Types as Integers

% EyeMT VECTOR (Eye Movement Type)

% EyesNotFound ==> -1
% Unclassified ==>  0
% Fixation     ==>  1
% Saccade      ==>  2

ems = string(a_rawGazeTable.EyeMoveType);

ENF = (ems == 'EyesNotFound');
U = (ems == 'Unclassified');
F = (ems == 'Fixation');
S = (ems == 'Saccade');

EyeMT(ENF) = -1; EyeMT(U) = 0; EyeMT(F) = 1; EyeMT(S) = 2;

EyeMT = EyeMT';

%% Removing ENF, U, S

clean_table = clean_table(~U&~ENF&~S,:);
clean_table(:,2) = [];

%% Creating Tobii AOI Hits Table

tobiiAOIHit = clean_table(:,[1,5:end]);

TobiiAOIA = table2array(tobiiAOIHit);

% rawTobiiAOIT = TobiiAOIT;

%% Creating Mapped Gaze Table

mappedGazeTable = clean_table(:,[1:4]);

%% Creating Condensed Participant Visual Pattern (CPVP)

% CPVP VECTOR (Condensed Participant Visual Pattern) 

% TIMESTAMP (1)
% ADI Hit   (2)
% ADIcP Hit (3)
% ALT Hit   (4)
% BA Hit    (5)
% HDG Hit   (6)
% HDGHe Hit (7)
% PWR Hit   (8)
% Speed Hit (9)
% V_S Hit   (10)

TEMP = zeros(size(TobiiAOIA,1),1);

for k = 2:size(TobiiAOIA,2)
     TEMP = TEMP + k*TobiiAOIA(:,k);
end

CPVP = zeros(size(TobiiAOIA,1),2);

CPVP(:,1) = TobiiAOIA(:,1);
CPVP(:,2) = TEMP;

%% Simplifying CPVP (SCPVP)

clearvars k;

SCPVP = CPVP;

FLAGGED = zeros(size(SCPVP,1),1);

for k = 1:(size(SCPVP,1)-1)
    int_CurrentInst = SCPVP(k,2);
    int_NextInst = SCPVP(k+1,2);
    
    if int_CurrentInst == int_NextInst
        FLAGGED(k+1) = 1;
    end
end

FLAGINDICES = find(FLAGGED);

% Pattern With Zeros

SCPVP(FLAGINDICES,:) = [];

clearvars FLAGGED FLAGINDICES;

%% Making Simplified Condensed Pattern Wihtout Zeros(NZSCPVP)

NZSCPVP = SCPVP;

FLAGGED = (SCPVP(:,2) == 0);

FLAGINDICES = find(FLAGGED);

NZSCPVP(FLAGINDICES,:) = []; 

%% Making Final and Useful Variable: Mapped Gaze Table

TobiiAOIA = NZSCPVP;

tobiiAOIHit = array2table(TobiiAOIA);

tobiiAOIHit.Properties.VariableNames{1} = 'Timestamp';

tobiiAOIHit.Properties.VariableNames{2} = 'AOI_Hit';

% Careful! 13 means overlapping data!!!! Resolve later ISSUE

end