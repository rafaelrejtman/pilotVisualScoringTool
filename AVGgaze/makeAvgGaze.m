
function avgGaze = makeAvgGaze(listOfBest)

myFolder = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Data/Tobii TSV Files';

participantTSVFiles = dir(fullfile(myFolder,'*.tsv'));

totalPerc = zeros(10,1);
K = 0;

for i=1:size(participantTSVFiles,1)
    thisFile = participantTSVFiles(i).name;
    if(any(strcmp(listOfBest,thisFile)))
        fileName = fullfile(myFolder,thisFile);
        [realPercDist,~] = modifiedMain(fileName);
        perc = realPercDist(:,3);
        totalPerc = totalPerc + perc;
        K = K+1;
    end
end

avgGaze = totalPerc/K;

end