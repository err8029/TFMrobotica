
%Load two image categories
categories=csvread('categories.csv');
imds = imageDatastore('./turtle32','Labels',categorical(categories)');

%Split the data set into a training and test data. Pick 30% of images from each set for the training data and the remainder 70% for the test data
[trainingSet,testSet] = splitEachLabel(imds,0.7,'randomize');

%Create bag of visual words
bag = bagOfFeatures(trainingSet,'VocabularySize',500,'StrongestFeatures',0.8,...
    'BlockWidth',[32 64 96 128],'GridStep',[8 8]);

%Train a classifier with the training sets
categoryClassifier = trainImageCategoryClassifier(trainingSet,bag);

%Evaluate the classifier using test images. Display the confusion matrix
confMatrix = evaluate(categoryClassifier,testSet);

%Find the average accuracy of the classification
mean(diag(confMatrix))

%Apply the newly trained classifier to categorize new images.
img = imread('test/1.png');
[labelIdx, score] = predict(categoryClassifier,img);

%Display the classification label
categoryClassifier.Labels(labelIdx)