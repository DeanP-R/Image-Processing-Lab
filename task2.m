im = im2double(imread('eye-hand.png')); % Replace 'eye-hand.png' with your image file path
imf = fftshift(fft2(im));
figure, fftshow(imf, 'log'), title('Fourier Transform of the Noisy Image');


% Example of creating a simple notch filter manually
% Assuming noise frequencies are identified at (x1, y1), (x2, y2), etc.
% Create a filter that is 1 everywhere except for regions around these frequencies
filter = ones(size(im));
filter(x1-3:x1+3, y1-3:y1+3) = 0; % Modify these ranges based on your needs
filter(x2-3:x2+3, y2-3:y2+3) = 0; % Repeat for other frequencies as needed
filteredImf = imf .* filter;
filteredIm = ifft2(ifftshift(filteredImf));
figure, imshow(filteredIm), title('Filtered Image');
