
% Iterating Over all Pilots

myFolder = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Data/Tobii TSV Files';

% listOfBest = {'CAE Data Export 26.tsv';'CAE Data Export 14.tsv';'CAE Data Export 8.tsv';'CAE Data Export 9.tsv';'CAE Data Export 45.tsv';'CAE Data Export 13.tsv';'CAE Data Export 38.tsv';'CAE Data Export 33.tsv';'CAE Data Export 28.tsv';'CAE Data Export 36.tsv';'CAE Data Export 24.tsv';'CAE Data Export 43.tsv';'CAE Data Export 25.tsv';'CAE Data Export 35.tsv';'CAE Data Export 21.tsv';'CAE Data Export 12.tsv';'CAE Data Export 30.tsv';'CAE Data Export 32.tsv';'CAE Data Export 15.tsv';'CAE Data Export 6.tsv';'CAE Data Export 5.tsv';'CAE Data Export 11.tsv';'CAE Data Export 37.tsv';'CAE_Jens_Post.tsv'};
listOfBest = {'CAE Data Export 14.tsv';'CAE Data Export 21.tsv';'CAE Data Export 9.tsv';'CAE Data Export 45.tsv';'CAE Data Export 33.tsv';'CAE Data Export 36.tsv';'CAE Data Export 12.tsv';'CAE Data Export 6.tsv';'CAE Data Export 15.tsv';'CAE Data Export 37.tsv';'CAE Data Export 25.tsv';'CAE Data Export 24.tsv';'CAE Data Export 30.tsv';'CAE Data Export 28.tsv';'CAE Data Export 11.tsv';'CAE_Jens_Post.tsv'};
avgGaze = makeAvgGaze(listOfBest);

participantTSVFiles = dir(fullfile(myFolder,'*.tsv'));
participantResults = cell(size(participantTSVFiles,1)+1,3);
participantResults{1,1} = 'Participant';
participantResults{1,2} = 'RecName';
participantResults{1,3} = 'Score';

for i=1:size(participantTSVFiles,1)
    thisFile = participantTSVFiles(i).name;
    fileName = fullfile(myFolder,thisFile);
    [score,recName] = main(fileName,avgGaze);
    participantResults{i+1,1} = thisFile;
    participantResults{i+1,2} = recName;
    participantResults{i+1,3} = score;
end

resultsT = cell2table(participantResults);
resultsT(1,:) = [];
resultsT.Properties.VariableNames{1} = 'Participant';
resultsT.Properties.VariableNames{2} = 'RecName';
resultsT.Properties.VariableNames{3} = 'Score';

scoreArray = cell2mat(resultsT.Score);
resultsT.Score = scoreArray;
resultsT = sortrows(resultsT,'Score','ascend');

labels = resultsT.RecName;
scoreArray = resultsT.Score;
plot(scoreArray);
% xticklabels(labels);


