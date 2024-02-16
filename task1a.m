% Close all open figures, clear variables from the workspace, and clear the command window
close all; clear all; clc;

% Read the image and convert it to double precision for processing
im = im2double(imread('images\trui.tif'));

% Determine the size of the image in pixels
[rows, cols] = size(im);

% Initialize the first working copy of the image
im1 = im;

% Set the number of iterations for the filtering process
N = 15000; % number of iterations
K = 0.01; % Constant for weight calculation

% Begin the iterative filtering process
for k = 1:N % Iterates N times
  
  % Initialize a matrix to hold the filtered image for each iteration
  im2 = zeros(rows, cols);

  % Loop over the image pixels, excluding the border pixels
  for x = 2 : rows - 1
    for y = 2 : cols - 1 % For each inner pixel

      % Calculate the weighted sum and the sum of weights
      weighted_sum = 0;
      sum_of_weights = 0;

      % Loop over the 3x3 neighborhood of the current pixel
      for i = -1 : 1  
        for j = -1 : 1
          % Calculate the weight for the current neighbor pixel
          weight = exp(-abs(im1(x, y) - im1(x + i, y + j)) / K);

          % Accumulate the weighted sum of the current pixel and its neighbors
          weighted_sum = weighted_sum + weight * im1(x + i, y + j);

          % Accumulate the sum of weights
          sum_of_weights = sum_of_weights + weight;
        end 
      end
      
      % Calculate the new pixel value by dividing the weighted sum by the sum of weights
      im2(x, y) = weighted_sum / sum_of_weights;

    end
  end

  % Update the working image with the filtered result for the next iteration
  im1 = im2;

end

% Display the images in separate subplots to label them individually
figure;

% Display the original image
subplot(1,2,1); % Creates a 1x2 grid, and places the next image in the first position
imshow(im);
title('Original Image'); % Labels the first image as "Original Image"

% Display the smoothed image
subplot(1,2,2); % Places the next image in the second position of the 1x2 grid
imshow(im1);
title('Smoothed Image'); % Labels the second image as "Smoothed Image"

