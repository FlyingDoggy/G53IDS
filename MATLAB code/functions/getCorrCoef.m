function [ corrCoef ] = getCorrCoef(  trainsetLandmarks, testingsetLandmarks )
trainsetLandmarks = trainsetLandmarks( : );
testingsetLandmarks = testingsetLandmarks(:);
corrCoef = (trainsetLandmarks'*testingsetLandmarks)/(norm(trainsetLandmarks)*norm(testingsetLandmarks));
end

