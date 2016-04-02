function  LBPforAll  = getLBP( filePath,fileName, faceSize, winSize )

s1 = filePath;
s2 = '.pts';
s3 = '.jpg';
fname = fileName;
fpts = strcat(s1,fname,s2);
fimage = strcat(s1, fname, s3);
windowSize = winSize;
hist = zeros(1,256);
LBPforAll = []; 
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

image = rgb2gray(image);
distanceAToB = [A(1,1),A(1,2);A(10,1),A(10,2)];
d = pdist(distanceAToB,'euclidean');
rescale = faceSize/d;
J = imresize(image, rescale);

B = A*rescale;


for count = 1:49
   % plot(B(i,1),B(i,2),'w.', 'MarkerSize', 20);
I2 = imcrop(J,[B(count,1)-windowSize/2,B(count,2)-windowSize/2,windowSize-1,windowSize-1]);
m=size(I2,1);
n=size(I2,2);
    for i = 2:(m - 1)
        for j = 2:(n - 1)      
        x = i - 1;
        y = j - 1;
        J0=I2(i,j);
        I3(i-1,j-1)=I2(i-1,j-1)>J0;
        I3(i-1,j)=I2(i-1,j)>J0;
        I3(i-1,j+1)=I2(i-1,j+1)>J0; 
        I3(i,j+1)=I2(i,j+1)>J0;
        I3(i+1,j+1)=I2(i+1,j+1)>J0; 
        I3(i+1,j)=I2(i+1,j)>J0; 
        I3(i+1,j-1)=I2(i+1,j-1)>J0; 
        I3(i,j-1)=I2(i,j-1)>J0;
        LBP(x,y)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)*2^1+I3(i,j-1)*2^0;
        hist(1,LBP(x,y)+1) = hist(1,LBP(x,y)+1) + 1;
       
        end
    end 
normHist = norm(hist);
hist = hist/normHist;
LBPforAll = horzcat(LBPforAll,hist);


end
LBPforAll = horzcat(LBPforAll,1);
end