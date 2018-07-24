
%This is a MODULE Main
function offsetMappedGazeTable = mainOMG(thisMGT,recName,printGraphsBOL)

[heatPoint] = getHeatP(thisMGT,recName,printGraphsBOL);

[offsetMappedGazeTable,deltaOffset] = autoOffset(heatPoint,thisMGT);

if printGraphsBOL
    testOffset(thisMGT, offsetMappedGazeTable, heatPoint, deltaOffset);
end

end

