function   [AllVector, lengthOfVector, Score, numberOfFile] = getFeatures_GN(file_Path, file_Name, image_Path, face_Size, win_Size,numOfLandmarks,typeOfFeatures)
windowSize = win_Size;
wholePath = strcat(file_Path,file_Name);
imagePath = strcat(file_Path,image_Path);
[Score,name]=textread(wholePath,'%d%s','delimiter','\t');
numberOfFile = length(Score);
if isinteger(uint8(typeOfFeatures))
    if (0<typeOfFeatures)&&(typeOfFeatures<4)
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
        end
    else  error(message('please input the valid number;\n 1 for HoG features;\n 2 for LBP features;\n 3 for SIFT features\n'));
    end
elseif ~isinteger(typeOfFeatures)
    error(message('please input single integer\n'));
end
lengthOfVector = featureLength*numOfLandmarks + 1;
AllVector = zeros(numberOfFile,lengthOfVector);

for i = 1:numberOfFile
    fName = char(name(i,1));
    fimage = strcat(imagePath,fName,'.jpg');
    A = getLandmarks(fName,i);
   
     switch typeOfFeatures
        case 1
            %HoG features
    mTemp = getHoG_GN(A,fimage,face_Size,windowSize);
        case 2
            %LBP features
    mTemp = getLBP_GN(A, fimage, face_Size, windowSize );
        case 3
            %SIFT features
    mTemp = getSIFT_GN(A,fimage,face_Size,windowSize);
        end
  
    
    fprintf('%d %s\n',i, fName);

    AllVector(i,:) = mTemp(:);
    
    
   for j = 1:lengthOfVector
       AllVector(i,j) = mTemp(j);
   end
end
end
