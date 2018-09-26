img_db=[];

categories=csvread('categories.csv');
num_cat=2;%number of categories
%categories
%1 - kitty
%0 - nothing
imds = imageDatastore('/home/eric/Escritorio/tfm_practico/Comuter_Vision/raw/turtle','Labels',categorical(categories)');

% imds = imageDatastore(fullfile(rootFolder, categories), ...
%     'LabelSource', 'foldernames');

varSize = 32;
conv1 = convolution2dLayer(5,varSize,'Padding',2,'BiasLearnRateFactor',2);
conv1.Weights = gpuArray(single(randn([5 5 3 varSize])*0.0001));
fc1 = fullyConnectedLayer(32,'BiasLearnRateFactor',2);
fc1.Weights = gpuArray(single(randn([32,576])*0.1));
fc2 = fullyConnectedLayer(num_cat,'BiasLearnRateFactor',2);
fc2.Weights = gpuArray(single(randn([num_cat 32])*0.1));
%layer stacking
layers = [
    %imageInputLayer([varSize varSize 3]);%image size and RGB
    imageInputLayer([varSize varSize 3]);
    conv1;
    maxPooling2dLayer(3,'Stride',2);
    reluLayer();
    convolution2dLayer(5,varSize,'Padding',2,'BiasLearnRateFactor',2);
    reluLayer();
    averagePooling2dLayer(3,'Stride',2);
    convolution2dLayer(5,varSize*2,'Padding',2,'BiasLearnRateFactor',2);
    reluLayer();
    averagePooling2dLayer(3,'Stride',2);
    fc1;
    reluLayer();
    fc2;
    softmaxLayer()
    classificationLayer()];

opts = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'MaxEpochs', 200, ...
    'MiniBatchSize', 50, ...
    'Verbose', true);

[net, info] = trainNetwork(imds, layers, opts);

categories_test=csvread('categories_test.csv');
imds_test = imageDatastore('/home/eric/Escritorio/tfm_practico/Comuter_Vision/raw/test','Labels',categorical(categories_test)');
labels = classify(net, imds_test);
num_img_test=2;
 
 ii = randi(num_img_test);
 im = imread(imds_test.Files{ii});
 imshow(im);
 if labels(ii) == imds_test.Labels(ii)
    colorText = 'g'; 
 else
     colorText = 'r';
 end
 title(char(labels(ii)),'Color',colorText);
