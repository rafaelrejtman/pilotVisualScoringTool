
% Pattern Collecting

%% Clean Matched Gaze - Removing Repetitions

cleanMatchedGazeTable = nan(height(matchedGazeTable),2);

% Establishing First Element
% Element Count!
e = 1;
thisElement = matchedGazeTable.AOI_hit(1);
cleanMatchedGazeTable(e,1) = thisElement; %new element added
initialTimestamp = matchedGazeTable.Timestamp(1);
lastElement = thisElement;

for i=2:height(matchedGazeTable)
    
    thisElement = matchedGazeTable.AOI_hit(i);
    
    if thisElement ~= lastElement
        e = e+1;
        % Close precedent Element Loop
        finalTimestamp = matchedGazeTable.Timestamp(i-1);
        cleanMatchedGazeTable(e-1,2) = finalTimestamp-initialTimestamp;
        % Begin new Element Loop
        cleanMatchedGazeTable(e,1) = thisElement; %new element added
        initialTimestamp = matchedGazeTable.Timestamp(i);
    end
    
    lastElement = thisElement;
    
end

cleanMatchedGazeTable(isnan(cleanMatchedGazeTable(:,1)),:) = [];

%% Putting in Table for organized view
% cleanMatchedGazeTable = table(cleanMatchedGazeTable(:,1),cleanMatchedGazeTable(:,2));
% cleanMatchedGazeTable.Properties.VariableNames{1} = 'Instrument';
% cleanMatchedGazeTable.Properties.VariableNames{2} = 'Duration_of_Gaze';

%% Removing Gazes that are too Quick (Zero Duration)

instrumentGazeSequence = cleanMatchedGazeTable(cleanMatchedGazeTable(:,2)~=0,:);
instrumentGazeSequence = instrumentGazeSequence(1:end-1,:); %last line has duration NaN

%% Looking For Most Recurring Patterns (7-12 Instruments)
% Pattern is defined as sequence which returns to same initial number
% (instrument)

lastElement = -1;
patternsFound = cell(length(cleanMatchedGazeTable),1);
thisPattern = nan(10,1);
nOfPatterns = 0;
nOfElements = 0;

for i=1:length(cleanMatchedGazeTable)
    
    firstElement = cleanMatchedGazeTable(i);
    
    thisPattern(1) = firstElement;
    nOfElements = 1;
    
    for k =i+1:i+6
        
        if k>length(cleanMatchedGazeTable)
            break
        end

        thisElement = cleanMatchedGazeTable(k);
        
        if thisElement == firstElement
            nOfPatterns = nOfPatterns+1;
            thisPattern(isnan(thisPattern)) = [];
            thisPattern(nOfElements+1) = firstElement;
            patternsFound{nOfPatterns} = thisPattern;
            thisPattern = nan(10,1);
            break;
        else
            nOfElements = nOfElements+1;
            thisPattern(nOfElements) = thisElement;
        end
        
        if k==i+6
            thisPattern = nan(10,1);
        end
        
    end
end

%% teste

% Changeable Variables

% Mininum Number of Instruments

MININ = 7;

% Maximum Number of Instruments

MAXIN = 12;

% Moving Window Size

WIN = 15;

% Size of foundPatterns Cell
% Biggest possible would be length(instrumentGazeSequence)

CELLSIZE = length(instrumentGazeSequence); %with 20% margin

foundPatterns = cell(CELLSIZE,2);
patternCount = 0;

for anchor = 1:(length(instrumentGazeSequence)-(WIN-1))

localSeq = instrumentGazeSequence(anchor:anchor+(WIN-1),1);
localDur = instrumentGazeSequence(anchor:anchor+(WIN-1),2);

thisPattern = nan(MAXIN,1);
thisPattern(1:MININ-1) = localSeq(1:MININ-1);
firstElement = thisPattern(1);
foundPatt = 0;

for localIndex = MININ:MAXIN
    
    thisElement = localSeq(localIndex);
    thisPattern(localIndex) = thisElement;
    
    if thisElement == firstElement
        foundPatt = 1;
        patternCount = patternCount+1;
        break
    end
           
end

if foundPatt
    thisPattern(isnan(thisPattern)) = [];
    duration = sum(localDur(1:length(thisPattern)));
    foundPatterns{patternCount,1} = thisPattern;
    foundPatterns{patternCount,2} = duration;
end

end

foundPatterns(patternCount+1:end,:) = [];
    
%% Pattern Drawing
% 
% % a = 
% % 
% % % Pattern-wise Analysis of Gaze Points
% % 
% % gazeAOIs = matchedGazeTable.AOI_hit;
% % gazeX = mappedGazeTable.AutoMapX;
% % gazeY = mappedGazeTable.AutoMapY;
% % 
% % Generates 300 linearly spaced points from 0 to 8*pi
% x = linspace(0, 8*pi, 300);
% 
% % Creates the formula to be plotted
% % (it's a multiplication between vector 'x' and vector 'cos(x)')
% y = 1000*cos(x);
% 
% % Plot it!
% comet(x, y, .6)
% 
% matchedGazeX = zeros(size(matchedGazeTable.AOI_hit,1),1);
% matchedGazeY = zeros(size(matchedGazeTable.AOI_hit,1),1);
% 
% for j=1:size(matchedGazeTable.AOI_hit,1)
%     
%     thisFixation = matchedGazeTable.AOI_hit(j);
%     
%     % Values Below are in PIXELS. Taken from Photoshop Masks!
%     
%     switch thisFixation
%         
%         case 1
%             matchedGazeX(j) = 626;
%             matchedGazeY(j) = 269;
%         case 2
%             matchedGazeX(j) = 911;
%             matchedGazeY(j) = 284;
%         case 3
%             matchedGazeX(j) = 614;
%             matchedGazeY(j) = 87;
%         case 4
%             matchedGazeX(j) = 615;
%             matchedGazeY(j) = 561;
%         case 5
%             matchedGazeX(j) = 1270;
%             matchedGazeY(j) = 94;
%         case 6
%             matchedGazeX(j) = 352;
%             matchedGazeY(j) = 299;
%         case 7
%             matchedGazeX(j) = 987;
%             matchedGazeY(j) = 283;
%         case 10
%             matchedGazeX(j) = 614;
%             matchedGazeY(j) = 303;
%         case 40
%             matchedGazeX(j) = 616;
%             matchedGazeY(j) = 418;
%     end
% end
% 
% matchedGazeTable.IdealX = matchedGazeX;
% matchedGazeTable.IdealY = matchedGazeY;
% 
% % imshow('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/G1000-Ken.png'); 
% 
% % hold on;
% 
% a = matchedGazeTable.IdealX(1:100);
% 
% n = 100;
% 
% bigA = zeros(size(a,1)*100,1);
% 
% k = 1;
% i = k;
% 
% while k < size(a,1)
%     
%     initialElement = a(k);
%     
%     secondElement = a(k+1);
%     
%     if(secondElement ~= initialElement)
%         
%         rest = a(k+1:end);
%         
%         interpolated = linspace(initialElement,secondElement,n)';
%         
%         e = [interpolated;rest];
%         
%         bigA(i:i+size(e,1)-1,1) = e;
%         
%         i = i+99;
%         
%     else
%         i = i+1;
%     
%     end
%     
%     k = k+1;   
%     
% end

% imshow('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Reference Images/G1000-Ken.png');
% 
% hold on;
% 
% comet(matchedGazeTable.IdealX(1:10000),matchedGazeTable.IdealY(1:10000));

