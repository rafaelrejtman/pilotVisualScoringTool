
% Get all Gaze Maps At Once - Just Once

function AllMappedGazes = getAllGazeMaps

myFolder = '/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Data/Tobii TSV Files';

participantTSVFiles = dir(fullfile(myFolder,'*.tsv'));

AllMappedGazes = cell(size(participantTSVFiles,1),4);

for i=1:size(participantTSVFiles,1)
    thisFile = participantTSVFiles(i).name;
    fileName = fullfile(myFolder,thisFile);
    [mappedGazeTable,recDur,recName] = modifiedMain2(fileName);
    AllMappedGazes{i,1} = fileName;
    AllMappedGazes{i,2} = recName;
    AllMappedGazes{i,3} = recDur;
    AllMappedGazes{i,4} = mappedGazeTable;
end

end