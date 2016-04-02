function [mXY] = getmXY( filePath,fileName, faceSize )


s1 = filePath;
s2 = '.pts';
s3 = '.jpg';
fname = fileName;
fpts = strcat(s1,fname,s2);
fid=fopen(fpts,'r');
fgetl(fid);
fgetl(fid); 
fgetl(fid);
formatSpec = '%f %f';
sizeA = [2 68];
length = 49;
mX = zeros(length,1);
mY = zeros(length,1);

A = fscanf(fid,formatSpec,sizeA);
fclose(fid);
A = A';
rows2remove=[1:17 61 65];
A(rows2remove,:)=[];

distanceAToB = [A(1,1),A(1,2);A(10,1),A(10,2)];
d = pdist(distanceAToB,'euclidean');
rescale = faceSize/d;

XY = A*rescale;
for i = 1:length
    mX(i,1) = XY(i,1);
end
meanX = mean2(mX);
for i = 1:length
    mY(i,1) = XY(i,2);
end
meanY = mean2(mY);
for i = 1:length
    mX(i,1) = mX(i,1)-meanX;
end
for i = 1:length
    mY(i,1) = mY(i,1)-meanY;
end

    mXY = [mX;mY;1];

end