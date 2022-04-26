```matlab:Code
clc
clear all
```

**Dataset Parameters **

```matlab:Code
sampling_freq = 200; % in Hz
scoring_interval = 5; % in s
no_of_subjects = 20;
skipping_interval = 720;
N3_count = 0;
N2_count = 0 ;
N1_count = 0;
REM_count = 0;
Wake_count = 0;
UnknownStageCount = 0;
Datalocation = 'C:\courses\ML\project\data';
channel = "FP1_A1"; % channel we are using for classification
```

**Training data preperation**

The original dataset is continuous, so we segment them into different stages according to the scoring provided We adopted patient level splitting, since when we need to use such models, patient level splitting appears more realistic.

 So 70% of data is used for training the model. (We also skipped 720 intervals in the start and end of the dataset since during the start and end of recordings of EEG data, there might be some anomalities)

```matlab:Code
PatientEndTrain = 0.7*no_of_subjects;
PatientStartNo = 1;
PatientEndNo = PatientEndTrain;
[sleepstageN1Training, sleepstageN2Training, sleepstageN3Training, sleepstageREMTraining, sleepstageWakeTraining] = EEGpreprocess(PatientStartNo, PatientEndNo, Datalocation,scoring_interval,sampling_freq,channel,skipping_interval );
```

**Validation dataset **

 We used 10% of the dataset for validation

```matlab:Code
PatientEndVal = 0.8*no_of_subjects;
PatientStartNo = PatientEndTrain+1;
PatientEndNo = PatientEndVal;
[sleepstageN3Validation, sleepstageN2Validation, sleepstageN1Validation, sleepstageREMValidation, sleepstageWakeValidation] = EEGpreprocess(PatientStartNo, PatientEndNo, Datalocation,scoring_interval,sampling_freq , channel,skipping_interval);
SleepData_Validation = [sleepstageN1Validation';sleepstageN2Validation';sleepstageN3Validation';sleepstageREMValidation';sleepstageWakeValidation'];

```

**Testing Dataset**

We used 20% of the patients for testing

```matlab:Code

PatientStartNo = 17;
PatientEndNo = 20;
[sleepstageN3Testing, sleepstageN2Testing, sleepstageN1Testing, sleepstageREMTesting, sleepstageWakeTesting] = EEGpreprocess(PatientStartNo, PatientEndNo, Datalocation,scoring_interval,sampling_freq, channel ,skipping_interval);
SleepData_Testing = [sleepstageN1Testing';sleepstageN2Testing';sleepstageN3Testing';sleepstageREMTesting';sleepstageWakeTesting'];
```

**Dataset distribution accross classes**

```matlab:Code

X = categorical({'N1','N2','N3','REM','Wake'});
% X = reordercats(X,{'Small','Medium','Large','Extra Large'});
Y = [size(sleepstageN1Training,2),size(sleepstageN2Training,2),size(sleepstageN3Training,2),size(sleepstageREMTraining,2) ...
    size(sleepstageWakeTraining,2);size(sleepstageN1Validation,2),size(sleepstageN2Validation,2),size(sleepstageN3Validation,2) ...
    size(sleepstageREMValidation,2),size(sleepstageWakeValidation,2);size(sleepstageN1Testing,2),size(sleepstageN2Testing,2) ...
    size(sleepstageN3Testing,2),size(sleepstageREMTesting,2),size(sleepstageWakeTesting,2)];
h = bar(X,Y);
set(h, {'DisplayName'}, {'Training','Validation','Testing'}')
legend() 
title('Original data distribution')
```

![figure_0.png](Dataset_processing_images/figure_0.png)

**Creating Balanced dataset**

As we have seen, the original dataset is not balanced. So here we consider two different approaches for balancing the dataset: 1) SMOTE and 2) Random undersampling of majority class. Using these techniques, we create 1) 5 Class classification dataset 2) NREM vs Wake classification dataset and 3) REM vs Wake classification.** Note**: Testing dataset is not balanced.

```matlab:Code

SleepData_Training = [sleepstageN1Training';sleepstageN2Training';sleepstageN3Training';sleepstageREMTraining';sleepstageWakeTraining'];
Endlabel = size(sleepstageN1Training,2);
TrainingClass(1:Endlabel) = 1;
TrainingClass(Endlabel+1:Endlabel+size(sleepstageN2Training,2)) = 2;
Endlabel = Endlabel+size(sleepstageN2Training,2);
TrainingClass(Endlabel+1:Endlabel+size(sleepstageN3Training,2)) = 3;
Endlabel = Endlabel+size(sleepstageN3Training,2);
TrainingClass(Endlabel+1:Endlabel+size(sleepstageREMTraining,2)) = 4;
Endlabel = Endlabel+size(sleepstageREMTraining,2);
TrainingClass(Endlabel+1:Endlabel+size(sleepstageWakeTraining,2)) = 5;

Endlabel = size(sleepstageN1Validation,2);
ValidationClass(1:Endlabel) = 1;
ValidationClass(Endlabel+1:Endlabel+size(sleepstageN2Validation,2)) = 2;
Endlabel = Endlabel+size(sleepstageN2Validation,2);
ValidationClass(Endlabel+1:Endlabel+size(sleepstageN3Validation,2)) = 3;
Endlabel = Endlabel+size(sleepstageN3Validation,2);
ValidationClass(Endlabel+1:Endlabel+size(sleepstageREMValidation,2)) = 4;
Endlabel = Endlabel+size(sleepstageREMValidation,2);
ValidationClass(Endlabel+1:Endlabel+size(sleepstageWakeValidation,2)) = 5;

Endlabel = size(sleepstageN1Testing,2);
TestingClass(1:Endlabel) = 1;
TestingClass(Endlabel+1:Endlabel+size(sleepstageN2Testing,2)) = 2;
Endlabel = Endlabel+size(sleepstageN2Testing,2);
TestingClass(Endlabel+1:Endlabel+size(sleepstageN3Testing,2)) = 3;
Endlabel = Endlabel+size(sleepstageN3Testing,2);
TestingClass(Endlabel+1:Endlabel+size(sleepstageREMTesting,2)) = 4;
Endlabel = Endlabel+size(sleepstageREMTesting,2);
TestingClass(Endlabel+1:Endlabel+size(sleepstageWakeTesting,2)) = 5;
```

```matlab:Code
% 5 class Random majority undersampling
option = 'MajorityUndersample';
dataset = 'Training';
[BalancedsleepData, Class, counttrain] = BalanceDataset(SleepData_Training,TrainingClass,option,dataset);
Class_training = categorical(Class);
dataset = 'Validation';

[BalancedsleepDataValidation, Class, countvalidation] = BalanceDataset(SleepData_Validation,ValidationClass,option,dataset);

Class_Validation= categorical(Class);
dataset = 'Testing';

[BalancedsleepDataTesting, Class, counttest] = BalanceDataset(SleepData_Testing,TestingClass,option,dataset);

Class_Testing = categorical(Class);

BalancedsleepDataCell = num2cell(BalancedsleepData,2);
BalancedsleepDataValidationCell = num2cell(BalancedsleepDataValidation,2);
BalancedsleepDataTestingCell = num2cell(BalancedsleepDataTesting,2);
BalancedsleepDataCell = cellfun(@transpose,BalancedsleepDataCell,'un',0);
BalancedsleepDataTestingCell = cellfun(@transpose,BalancedsleepDataTestingCell,'un',0);
BalancedsleepDataValidationCell = cellfun(@transpose,BalancedsleepDataValidationCell,'un',0);
```

```matlab:Code
% Data distribution after Majority undersampling (5 Class)
X = categorical({'N1','N2','N3','REM','Wake'});
% X = reordercats(X,{'Small','Medium','Large','Extra Large'});
[GCTr,GnTr] = groupcounts(Class_training); 
[GCV,GnV] = groupcounts(Class_Validation); 
[GCT,GnT] = groupcounts(Class_Testing'); 

Y = [GCTr(1), GCTr(2),GCTr(3),GCTr(4),GCTr(5); GCV(1), GCV(2),GCV(3),GCV(4),GCV(5);GCT(1), GCT(2),GCT(3),GCT(4),GCT(5)];
h = bar(X,Y);
set(h, {'DisplayName'}, {'Training','Validation','Testing'}')
legend() 
title('Data distribution after Random Undersampling')
```

![figure_1.png](Dataset_processing_images/figure_1.png)

  

```matlab:Code
% 5 Class data balancing using SMOTE
option = 'SMOTE';
dataset = 'Training';
[BalancedsleepDataSMOTE, ClassSMOTE, counttrainSMOTE] = BalanceDataset(SleepData_Training,TrainingClass,option,dataset);
Class_trainingSMOTE = categorical(ClassSMOTE);
dataset = 'Validation';

[BalancedsleepDataValidationSMOTE, ClassSMOTE, countvalidationSMOTE] = BalanceDataset(SleepData_Validation,ValidationClass,option,dataset);

Class_ValidationSMOTE= categorical(ClassSMOTE);
dataset = 'Testing';

[BalancedsleepDataTestingSMOTE, ClassSMOTE, counttestSMOTE] = BalanceDataset(SleepData_Testing,TestingClass,option,dataset);

Class_TestingSMOTE = categorical(ClassSMOTE);

BalancedsleepDataSMOTECell = num2cell(BalancedsleepDataSMOTE,2);
BalancedsleepDataValidationSMOTECell = num2cell(BalancedsleepDataValidationSMOTE,2);
BalancedsleepDataTestingSMOTECell = num2cell(BalancedsleepDataTestingSMOTE,2);
BalancedsleepDataSMOTECell = cellfun(@transpose,BalancedsleepDataSMOTECell,'un',0);
BalancedsleepDataTestingSMOTECell = cellfun(@transpose,BalancedsleepDataTestingSMOTECell,'un',0);
BalancedsleepDataValidationSMOTECell = cellfun(@transpose,BalancedsleepDataValidationSMOTECell,'un',0);
```

```matlab:Code
% Data distribution after SMOTE (5 Class) 
X = categorical({'N1','N2','N3','REM','Wake'});
% X = reordercats(X,{'Small','Medium','Large','Extra Large'});
[GCTr,GnTr] = groupcounts(Class_trainingSMOTE'); 
[GCV,GnV] = groupcounts(Class_ValidationSMOTE'); 
[GCT,GnT] = groupcounts(Class_TestingSMOTE'); 

Y = [GCTr(1), GCTr(2),GCTr(3),GCTr(4),GCTr(5); GCV(1), GCV(2),GCV(3),GCV(4),GCV(5);GCT(1), GCT(2),GCT(3),GCT(4),GCT(5)];
h = bar(X,Y);
set(h, {'DisplayName'}, {'Training','Validation','Testing'}')
legend() 
title('Data distribution after SMOTE')
```

![figure_2.png](Dataset_processing_images/figure_2.png)

  

Here we create dataset for NREM vs Wake classification and REM vs Wake classification. 

For representation purpose : NoofClasses = 3 represents NREM sleep stage vs Wake and

NoofClasses = 3 represents REM sleep stage vs Wake

```matlab:Code
% Majority undersampling for class 3 
NoofClasses = 3;
dataset = 'Testing';
[Balancedsleep3ClasstestUS, ThreeClasstestUS] = DataPreprocess(BalancedsleepDataTesting,counttest,NoofClasses,dataset);
Balancedsleep3ClasstestUSCell = num2cell(Balancedsleep3ClasstestUS,2);
Balancedsleep3ClasstestUSCell = cellfun(@transpose,Balancedsleep3ClasstestUSCell,'un',0);
ThreeClassTest_US_Labels = categorical(ThreeClasstestUS);

dataset = 'Training';
[Balancedsleep3ClasstrainUS, ThreeClasstrainUS] = DataPreprocess(BalancedsleepData,counttrain,NoofClasses,dataset);
Balancedsleep3ClasstrainUSCell = num2cell(Balancedsleep3ClasstrainUS,2);
Balancedsleep3ClasstrainUSCell = cellfun(@transpose,Balancedsleep3ClasstrainUSCell,'un',0);
ThreeClassTrain_US_Labels = categorical(ThreeClasstrainUS);

dataset = 'validation';
[Balancedsleep3ClassvalidationUS, ThreeClassvalidationUS] = DataPreprocess(BalancedsleepDataValidation,countvalidation,NoofClasses,dataset);
Balancedsleep3ClassvalidationUSCell = num2cell(Balancedsleep3ClassvalidationUS,2);
Balancedsleep3ClassvalidationUSCell = cellfun(@transpose,Balancedsleep3ClassvalidationUSCell,'un',0);
ThreeClassValidation_US_Labels = categorical(ThreeClassvalidationUS);
```

```matlab:Code
% SMOTE for data balancing for 3 class
NoofClasses = 3;
dataset = 'Testing';
[Balancedsleep3ClasstestSMOTE, ThreeClasstestSMOTE] = DataPreprocess(BalancedsleepDataTestingSMOTE,counttestSMOTE,NoofClasses,dataset);
Balancedsleep3ClasstestSMOTECell = num2cell(Balancedsleep3ClasstestSMOTE,2);
Balancedsleep3ClasstestSMOTECell = cellfun(@transpose,Balancedsleep3ClasstestSMOTECell,'un',0);
ThreeClassTest_SMOTE_Labels = categorical(ThreeClasstestSMOTE);
dataset = 'Training';
[Balancedsleep3ClasstrainSMOTE, ThreeClasstrainSMOTE] = DataPreprocess(BalancedsleepDataSMOTE,counttrainSMOTE,NoofClasses,dataset);
Balancedsleep3ClasstrainSMOTECell = num2cell(Balancedsleep3ClasstrainSMOTE,2);
Balancedsleep3ClasstrainSMOTECell = cellfun(@transpose,Balancedsleep3ClasstrainSMOTECell,'un',0);
ThreeClassTrain_SMOTE_Labels = categorical(ThreeClasstrainSMOTE);
dataset = 'validation';
[Balancedsleep3ClassvalidationSMOTE, ThreeClassvalidationSMOTE] = DataPreprocess(BalancedsleepDataValidationSMOTE,countvalidationSMOTE,NoofClasses,dataset);
Balancedsleep3ClassvalidationSMOTECell = num2cell(Balancedsleep3ClassvalidationSMOTE,2);
Balancedsleep3ClassvalidationSMOTECell = cellfun(@transpose,Balancedsleep3ClassvalidationSMOTECell,'un',0);
ThreeClassValidation_SMOTE_Labels = categorical(ThreeClassvalidationSMOTE);
```

```matlab:Code
% Data balancing using Majority undersampling using 2 class
NoofClasses = 2;
dataset = 'Testing';
[Balancedsleep2ClasstestUS, TwoClasstestUS] = DataPreprocess(BalancedsleepDataTesting,counttest,NoofClasses,dataset);
Balancedsleep2ClasstestUSCell = num2cell(Balancedsleep2ClasstestUS,2);
Balancedsleep2ClasstestUSCell = cellfun(@transpose,Balancedsleep2ClasstestUSCell,'un',0);
TwoClassTest_US_Labels = categorical(TwoClasstestUS);

dataset = 'Training';
[Balancedsleep2ClasstrainUS, TwoClasstrainUS] = DataPreprocess(BalancedsleepData,counttrain,NoofClasses,dataset);
Balancedsleep2ClasstrainUSCell = num2cell(Balancedsleep2ClasstrainUS,2);
Balancedsleep2ClasstrainUSCell = cellfun(@transpose,Balancedsleep2ClasstrainUSCell,'un',0);
TwoClassTrain_US_Labels = categorical(TwoClasstrainUS);
dataset = 'validation';
[Balancedsleep2ClassvalidationUS, TwoClassvalidationUS] = DataPreprocess(BalancedsleepDataValidation,countvalidation,NoofClasses,dataset);
Balancedsleep2ClassvalidationUSCell = num2cell(Balancedsleep2ClassvalidationUS,2);
Balancedsleep2ClassvalidationUSCell = cellfun(@transpose,Balancedsleep2ClassvalidationUSCell,'un',0);
TwoClassValidation_US_Labels = categorical(TwoClassvalidationUS);
```

```matlab:Code
NoofClasses = 2;
dataset = 'Testing';
[Balancedsleep2ClasstestSMOTE, TwoClasstestSMOTE] = DataPreprocess(BalancedsleepDataTestingSMOTE,counttestSMOTE,NoofClasses,dataset);
Balancedsleep2ClasstestSMOTECell = num2cell(Balancedsleep2ClasstestSMOTE,2);
Balancedsleep2ClasstestSMOTECell = cellfun(@transpose,Balancedsleep2ClasstestSMOTECell,'un',0);
TwoClassTest_SMOTE_Labels = categorical(TwoClasstestSMOTE);

dataset = 'Training';
[Balancedsleep2ClasstrainSMOTE, TwoClasstrainSMOTE] = DataPreprocess(BalancedsleepDataSMOTE,counttrainSMOTE,NoofClasses,dataset);
Balancedsleep2ClasstrainSMOTECell = num2cell(Balancedsleep2ClasstrainSMOTE,2);
Balancedsleep2ClasstrainSMOTECell = cellfun(@transpose,Balancedsleep2ClasstrainSMOTECell,'un',0);
TwoClassTrain_SMOTE_Labels = categorical(TwoClasstrainSMOTE);
dataset = 'validation';
[Balancedsleep2ClassvalidationSMOTE, TwoClassvalidationSMOTE] = DataPreprocess(BalancedsleepDataValidationSMOTE,countvalidationSMOTE,NoofClasses,dataset);
Balancedsleep2ClassvalidationSMOTECell = num2cell(Balancedsleep2ClassvalidationSMOTE,2);
Balancedsleep2ClassvalidationSMOTECell = cellfun(@transpose,Balancedsleep2ClassvalidationSMOTECell,'un',0);
TwoClassValidation_SMOTE_Labels = categorical(TwoClassvalidationSMOTE);
```

**Save the processed dataset**

```matlab:Code
%Two Class

% Three class
% SMOTE
save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTestSMOTE.mat','Balancedsleep2ClasstestSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTestSMOTELabels.mat','TwoClassTest_SMOTE_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassValidationSMOTE.mat','Balancedsleep2ClassvalidationSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassValidationSMOTELabels.mat','TwoClassValidation_SMOTE_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTrainSMOTE.mat','Balancedsleep2ClasstrainSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTrainSMOTELabels.mat','TwoClassTrain_SMOTE_Labels');

 % Majority undersampling

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTestUS.mat','Balancedsleep2ClasstestUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTestUSLabels.mat','TwoClassTest_US_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassValidationUS.mat','Balancedsleep2ClassvalidationUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassValidationUSLabels.mat','TwoClassValidation_US_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTrainUS.mat','Balancedsleep2ClasstrainUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\TwoclassTrainUSLabels.mat','TwoClassTrain_US_Labels');

% Three class
% SMOTE
save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTestSMOTE.mat','Balancedsleep3ClasstestSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTestSMOTELabels.mat','ThreeClassTest_SMOTE_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassValidationSMOTE.mat','Balancedsleep3ClassvalidationSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassValidationSMOTELabels.mat','ThreeClassValidation_SMOTE_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTrainSMOTE.mat','Balancedsleep3ClasstrainSMOTECell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTrainSMOTELabels.mat','ThreeClassTrain_SMOTE_Labels');

 % Majority undersampling

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTestUS.mat','Balancedsleep3ClasstestUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTestUSLabels.mat','ThreeClassTest_US_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassValidationUS.mat','Balancedsleep3ClassvalidationUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassValidationUSLabels.mat','ThreeClassValidation_US_Labels');

 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTrainUS.mat','Balancedsleep3ClasstrainUSCell');
 save('C:\courses\ML\project\codes\TrainNetworkProject2\dataset_processed\ThreeclassTrainUSLabels.mat','ThreeClassTrain_US_Labels');

```
