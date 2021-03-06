img_db=[];

%extract the list of permutations of categories to train
categories=csvread('categories.csv');

num_cat=2;%number of categories
%categories
%1 - kitty
%0 - nothing
imds = imageDatastore('./turtle32','Labels',categorical(categories)');

%%%%%%%%%%%%%design of the network%%%%%%%%%%%%%
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

%%%%%%%%%%%%%training options%%%%%%%%%%%%%%%%%%%%
opts = trainingOptions('sgdm', ...
    'InitialLearnRate', 0.01, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ... %amount that the learn rate drops
    'LearnRateDropPeriod', 8, ... %num of epochs to drop the learn rate
    'L2Regularization', 0.004, ...
    'MaxEpochs', 400, ...
    'MiniBatchSize', 16384, ...
    'Verbose', true);

[net, info] = trainNetwork(imds, layers, opts);

%%%%%%%%%%%read test data and classify%%%%%%%%%%%%%%%%
categories_test=csvread('categories_test.csv');
imds_test = imageDatastore('./test','Labels',categorical(categories_test)');
labels = classify(net, imds_test);

%%%%%%%%%%%%%%%%%%%%%%test all%%%%%%%%%%%%%%%%%%%%%%%% 
num_img_test=26;
good=0;
bad=0;

figure(2)
for img=1:num_img_test
    im = imread(imds_test.Files{img});
    subplot(13,2,img)
    imshow(im);
    if labels(img) == imds_test.Labels(img)
        colorText = 'g'; 
        good=good+1;
    else
        colorText = 'r';
        bad=bad+1;
    end
    title(char(labels(img)),'Color',colorText);
end
figure(3);
per_good=round(good/(good+bad)*10000)/100;%percentage of robot
per_bad=round(bad/(good+bad)*10000)/100;%percentage of nothing
c = categorical({['Good: ' num2str(per_good) ' %'],['Bad: ' num2str(per_bad) ' %']});
bar(c,[good,bad])%draw graph
title('Results of the test data');
xlabel('Guessings');
ylabel('Amount (u)');
grid('on');

%%%%%%%%random test%%%%%%%%%%%%%%%%%%%
% num_img_test=2;
% 
% ii = randi(num_img_test);
% im = imread(imds_test.Files{ii});
% figure(3)
% imshow(im);
% if labels(ii) == imds_test.Labels(ii)
% colorText = 'g'; 
% else
%  colorText = 'r';
% end
% title(char(labels(ii)),'Color',colorText);
 
%%%%%%%%%%%%%%categories distribution graph%%%%%%%%%%%%%
robot=0;
nothing=0;
%collect the elements of each category
for cell=1:length(categories)
    if categories(cell)==1
        robot=robot+1;
    elseif categories(cell)==0
        nothing=nothing+1;
    end
end
fig=figure(1);
per_robot=round(robot/(robot+nothing)*10000)/100;%percentage of robot
per_nothing=round(nothing/(robot+nothing)*10000)/100;%percentage of nothing

c = categorical({['Robot: ' num2str(per_robot) ' %'],['Nothing: ' num2str(per_nothing) ' %']});
bar(c,[robot,nothing])%draw graph
title('Categories distribution');
xlabel('categories');
ylabel('frequency (u)');
grid('on');

