# Grasp-and-Lift EEG Detection
Team mates: 109080852 周紹傑, 111062661 林家銘, 111061650 張豐餘  
GitHub link: https://github.com/jeremylin168/2023BCI_Final  
Video link: https://youtu.be/6kmrrZDuir0  
## 1. Introduction:  
&emsp;The project attempts to identify the movement phases of a human hand during grasping and lifting by detecting brain waves. We want to detect six events: HandStart, FirstDigitTouch, BothStartLoadPhase, LiftOff, Replace and BothReleased. Then we used the 1-dimensonal convolutional neural network module to predict the results.  

## 2. Dataset:
&emsp;The data is downloaded from https://www.nature.com/articles/sdata201447  
&emsp;And the collected data from twelve participants in the new dataset WAY-EEG-GAL. The participant’s task in each trial was to reach for a small object, grasp it using their index finger and thumb, and lift it a few centimeters up in the air, hold it stably for a couple of seconds, and then replace and release the object. The beginning of the reach and the lowering of the object was cued by an LED, otherwise the pace of the task was up to the participant. During all trials, we recorded 32 channels of EEG, 5 channels of EMG from the shoulder, forearm, and hand muscles, the position of the arm, thumb and index finger and the object, and the forces applied to the object by the precision grip.  

ICLabel result:  
![](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/table.png)  

## 3. Model Framework:
&emsp;First, we preprocess the datasets using a bandpass filter provided by EEGlab. The bandpass filter will preserve the frequency 1-50HZ signals in the data. By doing this, we can get rid of data that is not brain signals.  
&emsp; We take the last two datasets as test data and the remaining datasets are used for training. Then we calculated the training data mean and standard deviation for 32 channels and used them to normalize the training data and the test data.  
&emsp; The signal data shape we feed into the module is 1024*32 tensor and the target data shape is a length 6 tensor. The 32 is the number of channels. The 1024 is the sampled data number, which is also the start of the target data/hand movement. It means we used the pass two second data to predict what happening now. The target data present 6 different event. If one of the events was happening, the relatively data point will set to 1, and 0 otherwise.  
&emsp; The CNN module we used just like following picture. Because the brain signal data is the one-dimensional data, the convolution method we used is 1-dimensional convolution. Doing so, we can extract the features in each channel separately.  
![](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/module.png)  
&emsp;When training the module, we used Binary Cross Entropy to calculate the loss and used Adam as the optimizer. The Adam learning rate is 0.001 and betas is (0.5, 0.99).  

![image](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/loss.png) 

## 4. Validation:
&emsp;We used ROC curve (Receiver operator characteristic curve) to validate our results. The ROC curve is a graphical plot that illustrates the diagnostic ability of the binary classifier system. The ROC curve is created by plotting the true positive rate (TPR) against the false positive rate (FPR) at various threshold settings. We also calculated the area under ROC Curve (between 0 to 1). Larger the area means better the result.  
## 5. Usage:
&emsp;First, you need to download the data from Kaggle.
	https://www.kaggle.com/c/grasp-and-lift-eeg-detection/data  
&emsp;	After unzip the data, you will find out there are two folder: ./train and ./test. We only need the train folder. Drag it to the same folder as final_1.m and final_cnn-eeg.ipynb.  
&emsp;	In order to do data preprocessing, you need to run EEGlab in Matlab first to load the bandpass filter function. Then you can run final_1.m to do the filtering automatedly. Be sure to create the empty ./newtrain folder first.  
&emsp;	After doing bandpass filter, you can open the final_cnn-eeg.ipynb and test our code.  

## 6. Result:
![image](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/r1.png)
![image](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/r2.png)  
Area Under ROC Curve:  0.9118277495429798  
![image](https://github.com/jeremylin168/2023BCI_Final/blob/main/pictures/r3.png)  

## 7. References:
Kaggle:  
https://www.kaggle.com/c/grasp-and-lift-eeg-detection/data  
https://www.kaggle.com/code/banggiangle/cnn-eeg-pytorch  
EEGlab:  
https://sccn.ucsd.edu/eeglab/index.php  
pytorch:  
https://pytorch.org/docs/stable/generated/torch.nn.Conv1d.html  
Others:  
https://en.wikipedia.org/wiki/Receiver_operating_characteristic  











