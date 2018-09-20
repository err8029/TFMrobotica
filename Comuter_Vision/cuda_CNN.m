%% Predict Output Scores Using a Trained ConvNet
%

close all
clear 

%% 
% Load the sample data. 
[XTrain,TTrain] = digitTrain4DArrayData; 

%%
% |digitTrain4DArrayData| loads the digit training set as 4-D array data.
% |XTrain| is a 28-by-28-by-1-by-4940 array, where 28 is the height and
% 28 is the width of the images. 1 is the number of channels and 4940 is
% the number of synthetic images of handwritten digits. |TTrain| is a categorical
% vector containing the labels for each observation.  

%% 
% Construct the convolutional neural network architecture. 
layers = [imageInputLayer([28 28 1]);
          convolution2dLayer(5,20);
          reluLayer();
          maxPooling2dLayer(2,'Stride',2);
          fullyConnectedLayer(10);
          softmaxLayer();
          classificationLayer()];  

%% 
% Set the options to default settings for the stochastic gradient descent
% with momentum. 
options = trainingOptions('sgdm');  

%% 
% Train the network. 
rng(1)
net = trainNetwork(XTrain,TTrain,layers,options);  

%% 
% Run the trained network on a test set and predict the scores. 
[XTest,TTest]= digitTest4DArrayData;  
YTestPred = predict(net,XTest);  

%%
% |predict|, by default, uses a CUDA-enabled GPU with compute capability
% 3.0, when available. You can also choose to run |predict| on a CPU
% using the |'ExecutionEnvironment','cpu'| name-value pair argument.

%%
% Display the first 10 images in the test data and compare to the
% predictions from |predict|.
pic=1:1000;

for num=1:1:1000
    if TTest(pic(num),:)==1
        disp("detected")
    end
end


%%  
YTestPred(1:10,:) 

%%
% |TTest| contains the digits corresponding to the images in |XTest|. The
% columns of |YTestPred| contain |predict|&#8217;s estimation of a
% probability that an image contains a particular digit. That is, the first
% column contains the probability estimate that the given image is digit 0,
% the second column contains the probability estimate that the image is
% digit 1, the third column contains the probability estimate that the
% image is digit 2, and so on. You can see that |predict|&#8217;s
% estimation of probabilities for the correct digits are almost 1 and the
% probability for any other digit is almost 0. |predict| correctly estimates
% the first 10 observations as digit 0.