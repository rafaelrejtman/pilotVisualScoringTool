
% This function essentially looks at each Gaze Point and each of the
% Instrument AOI masks and looks for matches. Whenever a gazer point is
% within a certain region, there is a match and that match is saved for
% each Timestamp in the matchedGaze Table.

% For future implementation: the Stats data, and especially the Gaze time
% percentage may be an interesting complementary way to Score participants!

function matchedGazeTable = matchGaze(thisMGT,AOImasks,bolStats)

matchedGaze = zeros(size(thisMGT,1),2);

%% Gaze Matching

for p=1:size(thisMGT,1)
    
%     disp(p);
    
    currentGazePointX = thisMGT.AutoMapX(p);
    currentGazePointY = thisMGT.AutoMapY(p);
    currentTimestamp = thisMGT.Timestamp(p);
    
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

% Coordenada X é a coluna! Coordenada Y é a linha!

    matchedGaze(p,1) = currentTimestamp;

    if AOImasks.ADI(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 1;
    elseif AOImasks.ALT(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 2;
    elseif AOImasks.BA(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 3;
    elseif AOImasks.HDG(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 4;
    elseif AOImasks.PWR(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 5;
    elseif AOImasks.SPEED(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 6;
    elseif AOImasks.VS(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 7;
    end
        
    if AOImasks.ADIfocus(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 10;
    end
    
    if AOImasks.HDGfocus(currentGazePointY,currentGazePointX) > 0
        matchedGaze(p,2) = 40;
    end    

end

%% Formatting Results

matchedGazeTable = array2table(matchedGaze);
matchedGazeTable.Properties.VariableNames{1} = 'Timestamp';
matchedGazeTable.Properties.VariableNames{2} = 'AOI_hit';

%% Match Statistics

if bolStats
    
    total = size(matchedGaze,1);
    
    ADIperc = (100*sum((matchedGaze(:,2) == 1))/total);
    ALTperc = 100*sum((matchedGaze(:,2) == 2))/total;
    BAperc = 100*sum((matchedGaze(:,2) == 3))/total;
    HDGperc = (100*sum((matchedGaze(:,2) == 4))/total);
    PWRperc = 100*sum((matchedGaze(:,2) == 5))/total;
    SPEEDperc = 100*sum((matchedGaze(:,2) == 6))/total;
    VSperc = 100*sum((matchedGaze(:,2) == 7))/total;
    
    ADIfocus_perc = 100*sum((matchedGaze(:,2) == 10))/total;
    HDGfocus_perc = 100*sum((matchedGaze(:,2) == 40))/total;
    
    alphasum = ADIperc+ALTperc+BAperc+HDGperc+PWRperc+SPEEDperc+VSperc+ADIfocus_perc+HDGfocus_perc;
    
    Stats{1,1} = 'ADI not on CP';
    Stats{1,2} = ADIperc;
    
    Stats{2,1} = 'ALT';
    Stats{2,2} = ALTperc;
    
    Stats{3,1} = 'BA';
    Stats{3,2} = BAperc;
    
    Stats{4,1} = 'HDG not on FocusPoint';
    Stats{4,2} = HDGperc;
    
    Stats{5,1} = 'PWR';
    Stats{5,2} = PWRperc;
    
    Stats{6,1} = 'SPEED';
    Stats{6,2} = SPEEDperc;
    
    Stats{7,1} = 'VS';
    Stats{7,2} = VSperc;
    
    Stats{8,1} = 'ADI Focus';
    Stats{8,2} = ADIfocus_perc;
    
    Stats{9,1} = 'HDG Focus';
    Stats{9,2} = HDGfocus_perc;
    
    Stats{10,1} = 'Non Interest Regions';
    Stats{10,2} = 100-alphasum;
    
    matchStats = cell2table(Stats);
    matchStats.Properties.VariableNames{1} = 'Instruments';
    matchStats.Properties.VariableNames{2} = 'Gaze_Time_percentage';
    
    disp(matchStats);
    
    % Printing Graph
    
    labels = table2array(matchStats(:,1));
    data = table2array(matchStats(:,2));
    
    pie(data);
    legend(labels,'Location','westoutside','Orientation','vertical');
    title('Gaze Time by Instrument');
    
end

end

