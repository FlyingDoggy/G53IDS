function wVector = getWVector( inputlambda, allVector, lengthOfVector, Score)
lambda = inputlambda ;
S = Score;
 wVector = (allVector.' * allVector+lambda*eye(lengthOfVector,lengthOfVector))^(-1)*allVector.'*S;
 
end

