close all; clear all; clc;

% Load the pretrained denoising convolutional neural network, 'DnCNN'.
net = denoisingNetwork('DnCNN');

% Load a grayscale image into the workspace, 
% then create a noisy version of the image.
I = imread('cameraman.tif');
noisyI = imnoise(I,'gaussian',0,0.01);
% noisyI = imnoise(I,'salt & pepper',0.05);
figure, imshow([I,noisyI]),
title('Original Image (Left) and Noisy Image (Right)')

% image denoising by pretrained DnCNN
cnnI = denoiseImage(noisyI,net);
figure, imshow(cnnI), title('Denoised by pretrained DnCNN')

% image denoising by non-local mean filter
nlmI = imnlmfilt(noisyI);
figure, imshow(nlmI), title('Denoised by NL-mean filter')

% for salt&pepper noise only
% medI = medfilt2(noisyI);
% figure, imshow(medI), title('Denoised by median filter')
