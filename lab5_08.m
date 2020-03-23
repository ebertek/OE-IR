clear
happyImgs = dir('lab5_happy*.png');
happy_labels = categorical(repmat(0,numel(happyImgs),1));
sadImgs = dir('lab5_sad*.png');
sad_labels = categorical(repmat(1,numel(happyImgs),1));
labels = [happy_labels; sad_labels;];
imds = imageDatastore({'lab5_happy*.png','lab5_sad*.png'},'Labels',labels);
figure
numImages = length(imds.Files);
perm = randperm(numImages,length(imds.Files));
for i = 1:length(imds.Files)
subplot(2,length(imds.Files)/2,i);
imshow(imds.Files{perm(i)});
end
[imdsTrain,imdsTest] = splitEachLabel(imds,0.7,'randomize');

layers = [ imageInputLayer([256 256 3]) convolution2dLayer(5,20) reluLayer maxPooling2dLayer(2,'Stride',2) fullyConnectedLayer(2) softmaxLayer classificationLayer];
options = trainingOptions('sgdm', 'MaxEpochs',20, 'InitialLearnRate',1e-4, 'Verbose',0, 'Plots','training-progress');
net = trainNetwork(imdsTrain,layers,options);

YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;
accuracy = sum(YPred == YTest)/numel(YTest)