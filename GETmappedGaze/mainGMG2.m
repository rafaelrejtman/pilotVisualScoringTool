
%This is an Alternative MODULE Main
function [thisMappedGaze,recDur,recName] = mainGMG2(filename)

S = load('/Users/RFRejtman/Documents/Education/KU LEUVEN Internship/Development/Coding - Pilot Visual Scoring Tool/visualScoringTool/MAINexecution/AllMappedGazes.mat');

AllMappedGazes = S.AllMappedGazes;

[recName,recDur,thisMappedGaze] = AllMappedGazes{strcmp(AllMappedGazes(:,1),filename),2:4};

end

