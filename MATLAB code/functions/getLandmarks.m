function [ fitted_shape ] = getLandmarks( file,index )


%% load model

load('./model/cGN_DPM.mat');

%% load male Boundingboxes
load('.\model\new_boundingboxes_male.mat');
%% load female Boundingboxes
%load('Z:\G53IDS\MATLAB code\model\new_boundingboxes_female.mat')
%% Select image
gg = index;
names1 = strcat('Z:\G53IDS\Dataset\helen\testset\',file,'.jpg');
input_image = imread(names1);


%% initialization
% Our algorithm assumes as input a bounding box which contains the face. 
% The face region that this bounding box is supposed to cover is shown in "face_region.png". 
% If your face detector was trained on a different face region, it's your
% responsibility to make the necessary adjustment so that it covers the same region, if you
% want to obtain the best possible fitting performance.
% Each bounding box is represented by 4 numbers. bb(1) and bb(2) are the row and column
% coordinates of its top left corner. bb(3) is the height and bb(4) is the width. 
bb = bounding_boxes_with_name_score(gg, :);
% To plot the image along with the 4 corners of the bb


%% fit with Gauss-Newton DPM
iter = 5; % using more iterations for badly initialised images might help!
fitted_shape = GN_DPM_fit(input_image, bb, cGN_DPM, iter);






end

