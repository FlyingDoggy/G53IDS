function  HoG  = getHoG( filePath,fileName, faceSize,windowSize)

s1 = filePath;
s2 = '.pts';
s3 = '.jpg';
fname = fileName;
fpts = strcat(s1,fname,s2);
fimage = strcat(s1, fname, s3);
fid=fopen(fpts,'r');
fgetl(fid);
fgetl(fid); 
fgetl(fid);
formatSpec = '%f %f';
sizeA = [2 68];
HoGfeature = zeros(49,36);
A = fscanf(fid,formatSpec,sizeA);
fclose(fid);
A = A';
rows2remove=[1:17 61 65];
A(rows2remove,:)=[];
image = imread((fimage));

image = rgb2gray(image);
distanceAToB = [A(1,1),A(1,2);A(10,1),A(10,2)];
d = pdist(distanceAToB,'euclidean');
rescale = faceSize/d;
J = imresize(image, rescale);

B = A*rescale;
for i = 1:49


  [feature,~] = extractHOGFeatures(J,[B(i,1),B(i,2)],'CellSize',[windowSize,windowSize]);
  for j = 1:36
      HoGfeature(i,j)= feature(1,j);
 
  end
  
end

%hog feature of image
HoG = HoGfeature(:);
HoG = HoG';
normHoG = norm(HoG);
HoG = HoG/normHoG;
HoG = horzcat(HoG,1);
end
