function  [AllVector, lengthOfVector,Score, numberOfFile]  = getFeatures(file_Path, file_Name, image_Path, face_Size, win_Size,numOfLandmarks,typeOfFeatures)
windowSize = win_Size;
faceSize = face_Size;
wholePath = strcat(file_Path,file_Name);
imagePath = strcat(file_Path,image_Path);
[Score,name]=textread(wholePath,'%d%s','delimiter','\t');
if isinteger(uint8(typeOfFeatures))
    if (0<typeOfFeatures)&&(typeOfFeatures<5)
        switch typeOfFeatures
        case 1
            %HoG features
           featureLength = 36;
        case 2
            %LBP features
           featureLength = 256;
        case 3
            %SIFT features
           featureLength = 128;
        case 4 
            %Landmarks
           featureLength = 2;
                
        end
    else  error(message('please input the valid number;\n 1 for HoG features;\n 2 for LBP features;\n 3 for SIFT features\n'));
    end
elseif ~isinteger(typeOfFeatures)
    error(message('please input single integer\n'));
end

numberOfFile = length(Score);
lengthOfVector = featureLength*numOfLandmarks+1;
AllVector = zeros(numberOfFile,lengthOfVector);
for i = 1:numberOfFile
    fName = char(name(i,1));
     switch typeOfFeatures
        case 1
            %HoG features
    mTemp = getHoG(imagePath,fName, faceSize,windowSize);
        case 2
            %LBP features
    mTemp = getLBP(imagePath,fName, faceSize, windowSize);
        case 3
            %SIFT features
    mTemp = getSIFT(imagePath,fName, faceSize, windowSize);
        case 4
            %SIFT features
    mTemp = getmXY(imagePath,fName, faceSize);
        end
  
    fprintf('%d %s\n',i, fName);

    AllVector(i,:) = mTemp(:);
    
    
%    for j = 1:lengthOfVector
%        AllVector(i,j) = mTemp(j);
%    end
end
end

