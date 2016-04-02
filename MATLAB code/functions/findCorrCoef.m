function [ corrCoef,score,name ] = findCorrCoef( trainScore,trainName,allVector,testingData )

numberOfFile = length(trainScore);
allCorrCoef = zeros(numberOfFile,1); 
%% get all 
for i = 1:numberOfFile
    
    mTemp = allVector(i,:);
    mTemp = mTemp';
    allCorrCoef(i,:) = getCorrCoef(mTemp,testingData); 
     
end

[corrCoef,index] = max(allCorrCoef);
score = trainScore(index,:);

name = char(trainName(index,:));
end




