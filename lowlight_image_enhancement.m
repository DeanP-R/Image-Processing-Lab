% Close all open figures, clear variables from the workspace, and clear the command window
close all; clear all; clc;

% Read the image and convert it to double precision for processing
im = im2double(imread('low_light\bear.bmp'));

% Check if the image is color (3 channels)
[rows, cols, channels] = size(im);
if channels ~= 3
    error('The image must be a color image with three channels.');
end

% Initialize the matrix to hold the filtered image
im_filtered = zeros(rows, cols);

% Set the number of iterations for the filtering process
N = 1; % number of iterations (adjust as needed)
K = 10; % Sensitivity constant for weighting (adjust as needed)

% Compute T(x, y) - the maximum intensity across all color channels
T = max(im, [], 3);

% Apply the filtering scheme to T to obtain U (this needs to be filled in with the filtering process)
U = T; % Placeholder for the actual filtering of T

% Iterate over each pixel for the filtering (adapted from Task 1a)
% ... (your filtering code will go here, updating U)

% Enhance each color channel
epsilon = 0.1; % Small constant to avoid division by zero
im_enhanced = zeros(rows, cols, channels);
for ch = 1:channels
    im_enhanced(:, :, ch) = im(:, :, ch) ./ (U + epsilon);
end

% Clip values to the range [0, 1] in case of overflow
im_enhanced = max(min(im_enhanced, 1), 0);

% Display the original and the enhanced image side by side for comparison
figure, imshow([im, im_enhanced]);
