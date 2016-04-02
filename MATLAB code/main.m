clc;clear;
addpath functions
%% get score files

filePath = 'Z:\G53IDS\Dataset\';
maleTrainScore = 'maleScores.txt';
femaleTrainScore = 'femaleScores.txt';
maleTestScore = 'maleTestScores.txt';
femaleTestScore = 'femaleTestScores.txt';
%% set dataset path
trainsetPath = 'helen\trainset\';
testsetPath = 'helen\testset\';



% figure
% title('all features');
%% calculate the samiliarity and correalation coef

wholeTrainPath = strcat(filePath,maleTrainScore);

wholeTestPath = strcat(filePath,maleTestScore);
imagePath = strcat(filePath,testsetPath);


[~,trainName]=textread(wholeTrainPath,'%d%s','delimiter','\t');
[~,testName]=textread(wholeTestPath,'%d%s','delimiter','\t');
[allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, maleTrainScore, trainsetPath, 500,8,49,1);
[allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,maleTestScore, testsetPath, 500, 8,49,1);
Score_D = zeros(numberOfTestingImage,1);
Score_C = zeros(numberOfTestingImage,1);



for i = 1:numberOfTestingImage
    fName = char(testName(i,1));
    mTemp = allTestingVector(i,:);
    mTemp = mTemp';
    [distance,scoreD,nameD] = findFamiFace(trainingScore,trainName,allTrainingVector,mTemp);
    [ corrCoef,scoreC,nameC ] = findCorrCoef( trainingScore,trainName,allTrainingVector,mTemp );
    Score_D(i,1) = scoreD;
     Score_C(i,1) = scoreC;

  fprintf('%d %s %d %s %d\n',i,nameD,scoreD,nameC, scoreC); 

end



countD = 0;
countC = 0;

n = 151;
for i = 1:n
   if Score_D(i,:)== testingScore(i,:);
       countD=countD+1;
   end
    diff_D(i,:) = (Score_D(i,:)-testingScore(i,:))^2;
    
end
for i = 1:n
   if Score_C(i,:)== testingScore(i,:);
       countC=countC+1;
   end
    diff_C(i,:) = (Score_C(i,:)-testingScore(i,:))^2;
    
end
accuracyD = countD/n;
accuracyC = countC/n;

mean_squared_error_D = sqrt(sum(diff_D)/n);
mean_squared_error_C = sqrt(sum(diff_C)/n);


 
%% LBP features 
%% get all training LBP vector for male
% [allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, maleTrainScore, trainsetPath, 500, 36,49,2);
% 
%% get all testing LBP vector for male(ground truth)
 %[allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,maleTestScore, testsetPath, 500, 36,49,2);
 
%  newW = getWVector(0.01, allTrainingVector,lengthOfTrainingVector, trainingScore); 
% [newScore, error] = evaluateW(newW, allTestingVector, numberOfTestingImage, testingScore );
% 
% 
% subplot(1,2,1);
% plot(newScore);
% title('LBP features, windowSize 36, faceSize 500, lambda = 0.01, groundtruth, linear regression');
% 
%% LBP GN 
% model1 = svmtrain(trainingScore,allTrainingVector, '-s 4 -t 0'); 
% [predicted_score] = svmpredict(testingScore, allTestingVector, model1, '-b 0');
% model2 = svmtrain(trainingScore,allTrainingVector, '-s 0 -t 0'); 
% [predicted_label] = svmpredict(testingScore, allTestingVector, model2, '-b 0');
% subplot(1,2,2);
% plot(predicted_score);
% title('LBP features, windowSize 36, faceSize 500, lambda = 0.01, groundtruth, SVR');

%% SIFT
% [allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, maleTrainScore, trainsetPath, 500, 36,49,3);
% 
% [allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,maleTestScore, testsetPath, 500, 36,49,3 ); 
% 
% newW = getWVector(0.01, allTrainingVector,lengthOfTrainingVector, trainingScore); 
% [newScore, error] = evaluateW(newW, allTestingVector, numberOfTestingImage, testingScore );
% subplot(2,2,3);
% plot(newScore);
%  title('SIFT features, windowSize 36, faceSize 500, lambda = 0.01');

% 
%% get all training LBP vector for female
% allTrainingVector = getFeatures(filePath,femaleTrainScore, trainsetPath, 500, 18);
% 
%% get all testing LBP vector for female(ground truth)
% allTestingVector = getFeatures(filePath,femaleTestScore, testsetPath, 500, 18);
 
%% get all training LBP vector for male(for gaussian newton)
% [allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, maleTrainScore, trainsetPath, 500, 10,49);
%% get all testing LBP vector for male(gaussian newton)
% [allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures_GN(filePath,maleTestScore, testsetPath, 500, 32,49,3);

%% HoG features
%% get all training HoG vector for male
 %[allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath,maleTrainScore, trainsetPath, 500,8,49,1);
% 
%% get all testing HoG vector for male
% [allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,femaleTestScore, testsetPath, 500,8,49,1);
% 
%% get all training HoG vector for female
% allTrainingVector = getFeatures(filePath,femaleTrainScore, trainsetPath, 500, 18);
% 
%% get all testing HoG vector for female
% allTestingVector = getFeatures(filePath,femaleTestScore, testsetPath, 500, 18);
%% get all training SIFT vector for male
% [allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, maleTrainScore, trainsetPath, 500, 32,49,3);
% 
%% get all testing SIFT vector for male(ground truth)
% [allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,maleTestScore, testsetPath, 500, 32,49,3);
% 

 %% calcualte the vevtor W with regularizaiotn
%  fprintf('-----------training-----------');
%  newW_with_lambda = getWVector(0.01, allTrainingVector,lengthOfTrainingVector, trainingScore); 
% 
%  
% %% evaluating W using testset
%  [newScore, error] = evaluateW(newW_with_lambda, allTestingVector, numberOfTestingImage, testingScore );
% 
% %% train and evaluate by libsvm
% model = svmtrain(trainingScore,allTrainingVector, '-s 4 -t 0'); 
% [predicted_label] = svmpredict(testingScore, allTestingVector, model, '-b 0');
% [allTrainingVector, lengthOfTrainingVector, trainingScore, numberOfTrainingImage] = getFeatures(filePath, femaleTrainScore, trainsetPath, 500,8,49,1);
% [allTestingVector, lengthOfTestingVector, testingScore, numberOfTestingImage] = getFeatures(filePath,femaleTestScore, testsetPath, 500, 8,49,1);

% bounding_boxes_with_name_score = zeros(126,4);
% [S,name]=textread(strcat(filePath,femaleTestScore),'%d%s','delimiter','\t');
% for i=1:330
%     for j=1:126
% tf = strcmp(bounding_boxes_with_name{i,1}, name(j));
% if tf == 1;
%     bounding_boxes_with_name_score(j,1) = bounding_boxes(i,1);
%     bounding_boxes_with_name_score(j,2) = bounding_boxes(i,2);
%     bounding_boxes_with_name_score(j,3) = bounding_boxes(i,3);
%     bounding_boxes_with_name_score(j,4) = bounding_boxes(i,4);
% 
% end
%     end
% 
% end

