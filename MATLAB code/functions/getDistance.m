function [ totalDist ] = getDistance( trainsetLandmarks, testsetLandmarks )
%GETDISTANCE Summary of this function goes here
%   Detailed explanation goes here
%1.get image's landmarks getXY
%2.call getXY for entire training set
%3.store these landmarks in one matrix
%4.call getXY for every images in testing set
%5.calculate the distance between testing image and training image
%6.find out the minimun distance and set the testing image with that image
%from training set

dist = trainsetLandmarks - testsetLandmarks;
totalDist = dist'*dist;
