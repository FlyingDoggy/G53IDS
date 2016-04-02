function [ newScore, error ] = evaluateW( W, allVector, numberOfImage, Score )
 
newScore = W' * allVector';
newScore = newScore'; 
temp = 0;

n = numberOfImage;
for i = 1:n
    
    diff = (newScore(i,:)- Score(i,:))^2;
    temp = temp+diff; 
    
end

error = sqrt(temp/n);

end

