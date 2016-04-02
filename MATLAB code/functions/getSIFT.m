function [ allSIFT ] = getSIFT( filePath,fileName, faceSize, winSize )


s1 = filePath;
s2 = '.pts';
s3 = '.jpg';
fname = fileName;
fpts = strcat(s1,fname,s2);
fimage = strcat(s1, fname, s3);
windowSize = winSize;
fid=fopen(fpts,'r');
fgetl(fid);
fgetl(fid); 
fgetl(fid);
formatSpec = '%f %f';
sizeA = [2 68];
A = fscanf(fid,formatSpec,sizeA);
fclose(fid);
A = A';
rows2remove=[1:17 61 65];
A(rows2remove,:)=[];
%plot landmarks on face
image = imread((fimage));

image=double(image(:,:,1));
distanceAToB = [A(1,1),A(1,2);A(10,1),A(10,2)];
d = pdist(distanceAToB,'euclidean');
rescale = faceSize/d;
J = imresize(image, rescale);

B = A*rescale;


allSIFT = xx_sift(J,B,'winsize',windowSize);

allSIFT = allSIFT( : );
allSIFT = allSIFT';
normSIFT = norm(allSIFT);
allSIFT = allSIFT/normSIFT;
allSIFT = horzcat(allSIFT,1);
end



