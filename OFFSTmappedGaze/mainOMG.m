
%This is a MODULE Main
function offsetMappedGazeTable = mainOMG(thisMGT,rec_name)

[heatPoint] = getHeatP(thisMGT,rec_name,printGraphs);

[offsetMappedGazeTable,deltaOffset] = autoOffset(heatPoint,thisMGT);

end

