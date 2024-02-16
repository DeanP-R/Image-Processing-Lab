% Close all open figures, clear variables from the workspace, and clear the command window
close all; clear all; clc;

% Read the image and convert it to double precision for processing
im = im2double(imread('images\trui.tif'));

% Determine the size of the image in pixels
[rows, cols] = size(im);

% Initialize the first working copy of the image
im1 = im;

% Initialize a matrix to hold the filtered image, starting with zeros
im2 = zeros(rows, cols);

% Set the number of iterations for the filtering process
N = 1; % number of iterations

% Begin the iterative filtering process
for k = 1 : N % Iterates N times

  % Loop over the image pixels, excluding the border pixels
  for x = 2 : rows - 1
    for y = 2 : cols - 1 % For each inner pixel
        
      % Initialize the sum for the current pixel
      % Loop over the 3x3 neighborhood of the current pixel
      for i = -1 : 1  
        for j = -1 : 1
         % Accumulate the sum of the current pixel and its neighbors
         im2(x,y) = im2(x,y) + im1(x+i,y+j); 
        end 
      end
      
      % After summing the neighbors, average by dividing by the number of elements (9 for a 3x3 kernel)
      im2(x,y) = im2(x,y)./9;
      
    end
  end

  % Update the working image with the filtered result for the next iteration
  im1 = im2;

  % Reset the im2 matrix to zeros for the next iteration
  im2 = zeros(rows, cols);

end

% Display the original and the filtered image side by side for comparison
figure, imshow([im,im1]);
