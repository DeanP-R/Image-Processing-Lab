% Read the image and convert it to double precision for processing
im = im2double(imread('low_light\bear.bmp'));

% Check if the image is color (3 channels)
[rows, cols, channels] = size(im);
if channels ~= 3
    error('The image must be a color image with three channels.');
end

% Initialize the matrix to hold the filtered image and maximum intensity
T = zeros(rows, cols);
U = zeros(rows, cols);  % This will hold the filtered T, which is U in the task description

% Set the number of iterations for the filtering process
N = 1; % number of iterations (adjust as needed)
K = 10; % Sensitivity constant for weighting (adjust as needed)

% Compute T(x, y) - the maximum intensity across all color channels
for ch = 1:channels
    T = max(T, im(:, :, ch));
end

% Apply the non-linear filtering scheme to T to obtain U
for k = 1 : N % Iterates N times
    for x = 2 : (rows - 1)
        for y = 2 : (cols - 1) % For each inner pixel
            sumWeights = 0;
            weightedSum = 0;
            for i = -1 : 1
                for j = -1 : 1
                    % Calculate the weight based on the intensity difference
                    weight = exp(-abs(T(x, y) - T(x + i, y + j)) / K);
                    weightedSum = weightedSum + weight * T(x + i, y + j);
                    sumWeights = sumWeights + weight;
                end
            end
            % Compute the new intensity value for U(x,y)
            U(x, y) = weightedSum / sumWeights;
        end
    end
    % After each iteration, copy the filtered U back into T for the next iteration
    % If you wish to iterate more than once
    T = U;
end

% Enhance each color channel
epsilon = 0.1; % Small constant to avoid division by zero
im_enhanced = zeros(rows, cols, channels);
for ch = 1:channels
    % Use U in the enhancement formula instead of T
    im_enhanced(:, :, ch) = im(:, :, ch) ./ (U + epsilon);
end

% Clip values to the range [0, 1] in case of overflow
im_enhanced = max(min(im_enhanced, 1), 0);

% Display the original and the enhanced image side by side for comparison
figure, imshow([im, im_enhanced]);
