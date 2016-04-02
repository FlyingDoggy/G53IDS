A = allTrainingVector;
maleTrainScore = trainingScore;
maleTestAllVectorLBP = allTestingVector;
lengthOfVector = lengthOfTrainingVector;
Stest = testingScore;
lambda = 25 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore25 = maleTestAllVectorLBP * w; 

 lambda = 20 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore20 = maleTestAllVectorLBP * w; 
 
lambda = 18 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore18 = maleTestAllVectorLBP * w; 
 
 lambda = 0.7 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore15 = maleTestAllVectorLBP * w; 
 
lambda = 0.5 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore12 = maleTestAllVectorLBP * w; 
 
 lambda = 0.3 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore10 = maleTestAllVectorLBP * w; 
 

 lambda = 5 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
 newScore5 = maleTestAllVectorLBP * w; 
 

 lambda = 1 ; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
newScore1 = maleTestAllVectorLBP * w; 

 lambda = 0.1; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
newScore01 = maleTestAllVectorLBP * w; 
   

lambda = 0.01; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
newScore001 = maleTestAllVectorLBP * w; 
   

lambda = 0.001; 
w = (A.' * A+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*A.'*maleTrainScore;
newScore0001 = maleTestAllVectorLBP * w; 

% plot(newScore01,'red');
% hold on; 
% plot(newScore001,'blue');
% plot(newScore0001,'yellow');
% hold off;
all_25 = 0;
all_20 = 0;
all_18 = 0; 
all_15 = 0;
all_12 = 0;
all_10 = 0;
all_5 = 0;
all_1 = 0;
all_01 = 0;
all_001 = 0;
all_0001 = 0;

n = 151;
for i = 1:n

    diff_25 = (newScore25(i,:)- Stest(i,:))^2;
all_25 = all_25+diff_25; 

    
    diff_20 = (newScore20(i,:)- Stest(i,:))^2;
all_20 = all_20+diff_20; 
   diff_18 = (newScore18(i,:)- Stest(i,:))^2;
all_18 = all_18+diff_18; 
diff_15 = (newScore15(i,:)- Stest(i,:))^2;
all_15 = all_15+diff_15; 
diff_12 = (newScore12(i,:)- Stest(i,:))^2;
all_12 = all_12+diff_12; 

diff_10 = (newScore10(i,:)- Stest(i,:))^2;
all_10 = all_10+diff_10; 

diff_5 = (newScore5(i,:)- Stest(i,:))^2;
all_5 = all_5+diff_5; 

diff_1 = (newScore1(i,:)- Stest(i,:))^2;
all_1 = all_1+diff_1; 

diff_01 = (newScore01(i,:)- Stest(i,:))^2;
all_01 = all_01+diff_01; 

diff_001 = (newScore001(i,:)- Stest(i,:))^2;
all_001 = all_001+diff_001;


diff_0001 = (newScore0001(i,:)- Stest(i,:))^2;
all_0001 = all_0001+diff_0001;
end
error_25 = sqrt(all_25/n)

error_20 = sqrt(all_20/n)

error_18 = sqrt(all_18/n)

error_07 = sqrt(all_15/n)

error_05 = sqrt(all_12/n)

error_03 = sqrt(all_10/n)

error_5 = sqrt(all_5/n)

error_1 = sqrt(all_1/n)

error_01 = sqrt(all_01/n)

error_001 = sqrt(all_001/n)

error_0001 = sqrt(all_0001/n)