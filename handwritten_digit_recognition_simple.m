close all;
clear all;
clc;

% Load Image Data
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos', ...
    'nndatasets','DigitDataset');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

% Display some of the images in the datastore	
figure;
perm = randperm(10000,20);
for i = 1:20
    subplot(4,5,i);
    imshow(imds.Files{perm(i)});
end

% Calculate the number of images in each category
labelCount = countEachLabel(imds)

% Each image is 28-by-28-by-1 pixels.
img = readimage(imds,1);
size(img)

% Specify Training and Validation Sets
% Divide the data into training and validation data sets, 
% so that each category in the training set contains 750 images, 
% and the validation set contains the remaining images from each label. 
% splitEachLabel splits the datastore digitData into two new datastores, 
% trainDigitData and valDigitData.
numTrainFiles = 750;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,'randomize');

% Define the convolutional neural network architecture
layers = [
    imageInputLayer([28 28 1])
 
% hidden layers

% 1st hidden layer
fullyConnectedLayer(50)
batchNormalizationLayer
reluLayer  

% 2nd hiden layer
fullyConnectedLayer(30)
batchNormalizationLayer
reluLayer  

% 3rd hiden layer
fullyConnectedLayer(20)
batchNormalizationLayer
reluLayer 

% softmax layer 
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Specify Training Options
options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',30, ...
    'Verbose',false, ...
    'Plots','training-progress');

% Train Network Using Training Data
net = trainNetwork(imdsTrain,layers,options);

% Classify Validation Images and Compute Accuracy
YPred = classify(net,imdsValidation);
YValidation = imdsValidation.Labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)
