close all; clear; clc;

length = 250;   % the length of the motion
theta = 45;     % angle of motion in degrees.


% Load the Original Image 'original_image'
original_image = imread('images/trui.tif');

% Blurring kernel 'blurring_kernal'
% Choose between 'motion' or 'gaussian' blur

% For motion blur, you need to specify the length and the angle
 blurring_kernal = fspecial('motion', length, theta);

% For gaussian blur, you need to specify the size and the standard deviation
% blurring_kernal = fspecial('gaussian', [50, 50], 25);

% Apply the blur to the Original Image 'original_image'
noisy_image= imfilter(double(original_image), blurring_kernal, 'conv', 'circular');

% Add noise 'n' to the original image to simulate the real degraded image
noise_std = 0.01;  
n = noise_std * randn(size(original_image));
noisy_image = noisy_image + n;

% Convert the degraded image to frequency domain
G = fft2(noisy_image);

% Compute the Fourier transform of the blurring kernel
H = psf2otf(blurring_kernal, size(noisy_image));

% Compute the Wiener filter restoration usinnoisy_imagethe provided equation
K = 0.00001;
F_hat = (conj(H) ./ (abs(H).^2 + K)) .* G;

% Convert the restored image back to the spatial domain
restored_image = real(ifft2(F_hat));

% Display the results
figure;
subplot(1,4,1), imshow(original_image, []), title('Original Image');
subplot(1,4,2), imshow(blurring_kernal, []), title('Blurring Kernel');
subplot(1,4,3), imshow(noisy_image, []), title('Degraded Image');
subplot(1,4,4), imshow(restored_image, []), title('Restored Image');
