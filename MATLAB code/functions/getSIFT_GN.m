function  allSIFT  = getSIFT_GN( A, fimage, faceSize,winSize )

%plot landmarks on face
image = imread((fimage));
image = rgb2gray(image);
image=double(image(:,:,1));
distanceAToB = [A(1,1),A(1,2);A(10,1),A(10,2)];
d = pdist(distanceAToB,'euclidean');
rescale = faceSize/d;
J = imresize(image, rescale);

B = A*rescale;
allSIFT = xx_sift(J,B,'winsize',winSize);
allSIFT = allSIFT( : );
allSIFT = allSIFT';
normSIFT = norm(allSIFT);
allSIFT = allSIFT/normSIFT;
allSIFT = horzcat(allSIFT,1);

end

