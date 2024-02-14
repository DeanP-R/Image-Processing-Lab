clear all; close all; clc;

% Read and display the original noisy image
im = im2double(imread('eye-hand.png'));

% Compute the 2D Fourier Transform of the image
imf = fftshift(fft2(im));

% Display the magnitude spectrum of the Fourier Transform
figure, imshow(log(abs(imf) + 1), []), colormap(), colorbar;
title('Fourier Transform of the Noisy Image');
impixelinfo;
figure, imshow(im), title('Original Image');

% Manually identified positions of the noise frequencies
x1 = 130; y1 = 160; % Top Left
x2 = 130; y2 = 410; % Bottom Left
x3 = 385; y3 = 102; % Top Right
x4 = 385; y4 = 357; % Bottom Right

% Create a notch filter that is 1 everywhere except for regions around identified frequencies
filter = ones(size(im));
filter(x1-50:x1+50, y1-50:y1+50) = 0;
filter(x2-50:x2+50, y2-50:y2+50) = 0;
filter(x3-50:x3+50, y3-50:y3+50) = 0;
filter(x4-50:x4+50, y4-50:y4+50) = 0;

% Apply the notch filter in the frequency domain
filteredImf = imf .* filter;
figure, imshow(log(abs(filteredImf) + 1), []), colormap(), colorbar,  title('Filtered Fourier');

% Inverse Fourier Transform to get back to spatial domain
filteredIm = real(ifft2(ifftshift(filteredImf)));

% Display the filtered image
figure, imshow(filteredIm, []), title('Filtered Image');
