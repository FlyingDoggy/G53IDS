function [ distance,score,name ] = findFamiFace(trainScore,trainName,allVector,testingData )

numberOfFile = length(trainScore);
allDistance = zeros(numberOfFile,1); 
%% get all 
for i = 1:numberOfFile
   
    mTemp = allVector(i,:);
    mTemp = mTemp';
    allDistance(i,:) = getDistance(mTemp,testingData); 
     
end

[distance,index] = min(allDistance);
score = trainScore(index,:);
name = char(trainName(index,:));
end

