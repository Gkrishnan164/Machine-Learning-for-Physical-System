clc

clear all

%%

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




%% Training
for i = 1:14
    EDFFilename = sprintf('subject%d.edf',i);
    ScoringFilename = sprintf('HypnogramAASM_subject%d.txt',i);
    k  = edfread(fullfile('C:\courses\ML\project\data',EDFFilename));
    A = readmatrix(fullfile('C:\courses\ML\project\data', ScoringFilename));
    k1 = cell2mat(k.CZ_A1);
    k2 = cell2mat(k.FP1_A2);
    k3 = cell2mat(k.O1_A2);
    for j = skipping_interval: numel(A)-skipping_interval+1

        if A(j) == 1
            N3_count = N3_count + 1;
            sleepstageN3CZ_A1(:,N3_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3FP1_A1(:,N3_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3O1_A1(:,N3_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 2
            N2_count = N2_count+1;
            sleepstageN2CZ_A1(:,N2_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageN2FP1_A1(:,N2_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN2O1_A1(:,N2_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);


        elseif A(j) == 3
            N1_count = N1_count+1;
            sleepstageN1CZ_A1(:,N1_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageN1FP1_A1(:,N1_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN1O1_A1(:,N1_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 4
            REM_count = REM_count +1;
            sleepstageREMCZ_A1(:,REM_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageREMFP1_A1(:,REM_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageREMO1_A1(:,REM_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);


        elseif A(j) == 5
            Wake_count = Wake_count + 1;
            sleepstageWakeCZ_A1(:,Wake_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
                        sleepstageWakeFP1_A1(:,Wake_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageWakeO1_A1(:,Wake_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1) ;

        else
            UnknownStageCount = UnknownStageCount + 1;
        end
    end
end








%% Validation
N3_count = 0;
N2_count = 0 ;
N1_count = 0;
REM_count = 0;
Wake_count = 0;
UnknownStageCount = 0;
for i = 15:16
    EDFFilename = sprintf('subject%d.edf',i);
    ScoringFilename = sprintf('HypnogramAASM_subject%d.txt',i);
    k  = edfread(fullfile('C:\courses\ML\project\data',EDFFilename));
    A = readmatrix(fullfile('C:\courses\ML\project\data', ScoringFilename));
    k1 = cell2mat(k.CZ_A1);
    k2 = cell2mat(k.FP1_A2);
    k3 = cell2mat(k.O1_A2);
    for j = skipping_interval: numel(A)-skipping_interval+1

        if A(j) == 1
            N3_count = N3_count + 1;
            sleepstageN3CZ_A1_validation(:,N3_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3FP1_A1_validation(:,N3_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3O1_A1_validation(:,N3_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 2
            N2_count = N2_count+1;
            sleepstageN2CZ_A1_validation(:,N2_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN2FP1_A1_validation(:,N2_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN2O1_A1_validation(:,N2_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);


        elseif A(j) == 3
            N1_count = N1_count+1;
            sleepstageN1CZ_A1_validation(:,N1_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN1FP1_A1_validation(:,N1_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN1O1_A1_validation(:,N1_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 4
            REM_count = REM_count +1;
            sleepstageREMCZ_A1_validation(:,REM_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageREMFP1_A1_validation(:,REM_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageREMO1_A1_validation(:,REM_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);


        elseif A(j) == 5
            Wake_count = Wake_count + 1;
            sleepstageWakeCZ_A1_validation(:,Wake_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageWakeFP1_A1_validation(:,Wake_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageWakeO1_A1_validation(:,Wake_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1) ;

        else
            UnknownStageCount = UnknownStageCount + 1;
        end
    end
end


% Testing


N3_count = 0;
N2_count = 0 ;
N1_count = 0;
REM_count = 0;
Wake_count = 0;
UnknownStageCount = 0;


for i = 17:20
    EDFFilename = sprintf('subject%d.edf',i);
    ScoringFilename = sprintf('HypnogramAASM_subject%d.txt',i);
    k  = edfread(fullfile('C:\courses\ML\project\data',EDFFilename));
    A = readmatrix(fullfile('C:\courses\ML\project\data', ScoringFilename));
    k1 = cell2mat(k.CZ_A1);
    k2 = cell2mat(k.FP1_A2);
    k3 = cell2mat(k.O1_A2);
    for j = skipping_interval: numel(A)-skipping_interval+1

        if A(j) == 1
            N3_count = N3_count + 1;
            sleepstageN3CZ_A1_testing(:,N3_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3FP1_A1_testing(:,N3_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageN3O1_A1_testing(:,N3_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 2
            N2_count = N2_count+1;
            sleepstageN2CZ_A1_testing(:,N2_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageN2FP1_A1_testing(:,N2_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN2O1_A1_testing(:,N2_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);


        elseif A(j) == 3
            N1_count = N1_count+1;
            sleepstageN1CZ_A1_testing(:,N1_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageN1FP1_A1_testing(:,N1_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
            sleepstageN1O1_A1_testing(:,N1_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);

        elseif A(j) == 4
            REM_count = REM_count +1;
            sleepstageREMCZ_A1_testing(:,REM_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1);
                        sleepstageREMFP1_A1_testing(:,REM_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageREMO1_A1_testing(:,REM_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);


        elseif A(j) == 5
            Wake_count = Wake_count + 1;
            sleepstageWakeCZ_A1_testing(:,Wake_count) = k1(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
                        sleepstageWakeFP1_A1_testing(:,Wake_count) = k2(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq - 1);
            sleepstageWakeO1_A1_testing(:,Wake_count) = k3(j*scoring_interval*sampling_freq:(j+1)*scoring_interval*sampling_freq -1) ;

        else
            UnknownStageCount = UnknownStageCount + 1;
        end
    end
end




%% Training, Validation and Test data split

% % random shuffling
% sleepstageN3CZ_A1 = sleepstageN3CZ_A1(:,randperm(size(sleepstageN3CZ_A1,2)));
% sleepstageN3FP1_A1 = sleepstageN3FP1_A1(:,randperm(size(sleepstageN3FP1_A1,2)));
% sleepstageN3O1_A1 = sleepstageN3O1_A1(:,randperm(size(sleepstageN3O1_A1,2)));
% 
% sleepstageN1CZ_A1 = sleepstageN1CZ_A1(:,randperm(size(sleepstageN1CZ_A1,2)));
% sleepstageN1FP1_A1 = sleepstageN1FP1_A1(:,randperm(size(sleepstageN1FP1_A1,2)));
% sleepstageN1O1_A1 = sleepstageN1O1_A1(:,randperm(size(sleepstageN1O1_A1,2)));
% 
% sleepstageN2CZ_A1 = sleepstageN2CZ_A1(:,randperm(size(sleepstageN2CZ_A1,2)));
% sleepstageN2FP1_A1 = sleepstageN2FP1_A1(:,randperm(size(sleepstageN2FP1_A1,2)));
% sleepstageN2O1_A1 = sleepstageN2O1_A1(:,randperm(size(sleepstageN2O1_A1,2)));
% 
% sleepstageREMCZ_A1 = sleepstageREMCZ_A1(:,randperm(size(sleepstageREMCZ_A1,2)));
% sleepstageREMFP1_A1 = sleepstageREMFP1_A1(:,randperm(size(sleepstageREMFP1_A1,2)));
% sleepstageREMO1_A1 = sleepstageREMO1_A1(:,randperm(size(sleepstageREMO1_A1,2)));
% 
% sleepstageWakeCZ_A1 = sleepstageWakeCZ_A1(:,randperm(size(sleepstageWakeCZ_A1,2)));
% sleepstageWakeFP1_A1 = sleepstageWakeFP1_A1(:,randperm(size(sleepstageWakeFP1_A1,2)));
% sleepstageWakeO1_A1 = sleepstageWakeO1_A1(:,randperm(size(sleepstageWakeO1_A1,2)));
% 
% train_countN3 = ceil(0.7*size(sleepstageN3CZ_A1,2));
% validation_countN3 = ceil(0.8*size(sleepstageN3CZ_A1,2));
% sleepstageN3CZ_A1_Training = sleepstageN3CZ_A1(1:train_countN3);
% sleepstageN3FP1_A1_Training = sleepstageN3FP1_A1(1:train_countN3);
% sleepstageN3O1_A1_Training = sleepstageN3O1_A1(1:train_countN3);
% sleepstageN3CZ_A1_validation = sleepstageN3CZ_A1(train_countN3+1:validation_countN3);
% sleepstageN3FP1_A1_validation = sleepstageN3FP1_A1(train_countN3+1:validation_countN3);
% sleepstageN3O1_A1_validation = sleepstageN3O1_A1(train_countN3+1:validation_countN3);
% 
% 
% train_countN2 = ceil(0.7*size(sleepstageN2CZ_A1,2));
% validation_countN2 = ceil(0.8*size(sleepstageN2CZ_A1,2));
% sleepstageN2CZ_A1_Training = sleepstageN2CZ_A1(1:train_countN2);
% sleepstageN2FP1_A1_Training = sleepstageN2FP1_A1(1:train_countN2);
% sleepstageN2O1_A1_Training = sleepstageN2O1_A1(1:train_countN2);
% sleepstageN2CZ_A1_validation = sleepstageN2CZ_A1(train_countN2+1:validation_countN2);
% sleepstageN2FP1_A1_validation = sleepstageN2FP1_A1(train_countN2+1:validation_countN2);
% sleepstageN2O1_A1_validation = sleepstageN2O1_A1(train_countN2+1:validation_countN2);
% 
% 
% train_countN1 = ceil(0.7*size(sleepstageN1CZ_A1,2));
% validation_countN1 = ceil(0.8*size(sleepstageN1CZ_A1,2));
% sleepstageN1CZ_A1_Training = sleepstageN1CZ_A1(1:train_countN1);
% sleepstageN1FP1_A1_Training = sleepstageN1FP1_A1(1:train_countN1);
% sleepstageN1O1_A1_Training = sleepstageN1O1_A1(1:train_countN1);
% sleepstageN1CZ_A1_validation = sleepstageN1CZ_A1(train_countN1+1:validation_countN1);
% sleepstageN1FP1_A1_validation = sleepstageN1FP1_A1(train_countN1+1:validation_countN1);
% sleepstageN1O1_A1_validation = sleepstageN1O1_A1(train_countN1+1:validation_countN1);
% 
% train_countWake = ceil(0.7*size(sleepstageWakeCZ_A1,2));
% validation_countWake = ceil(0.8*size(sleepstageWakeCZ_A1,2));
% sleepstageWakeCZ_A1_Training = sleepstageWakeCZ_A1(1:train_countWake);
% sleepstageWakeFP1_A1_Training = sleepstageWakeFP1_A1(1:train_countWake);
% sleepstageWakeO1_A1_Training = sleepstageWakeO1_A1(1:train_countWake);
% sleepstageWakeCZ_A1_validation = sleepstageWakeCZ_A1(train_countWake+1:validation_countWake);
% sleepstageWakeFP1_A1_validation = sleepstageWakeFP1_A1(train_countWake+1:validation_countWake);
% sleepstageWakeO1_A1_validation = sleepstageWakeO1_A1(train_countWake+1:validation_countWake);
% 
% train_countREM = ceil(0.7*size(sleepstageREMCZ_A1,2));
% validation_countREM = ceil(0.8*size(sleepstageREMCZ_A1,2));
% sleepstageREMCZ_A1_Training = sleepstageREMCZ_A1(1:train_countREM);
% sleepstageREMFP1_A1_Training = sleepstageREMFP1_A1(1:train_countREM);
% sleepstageREMO1_A1_Training = sleepstageREMO1_A1(1:train_countREM);
% sleepstageREMCZ_A1_validation = sleepstageREMCZ_A1(train_countREM+1:validation_countREM);
% sleepstageREMFP1_A1_validation = sleepstageREMFP1_A1(train_countREM+1:validation_countREM);
% sleepstageREMO1_A1_validation = sleepstageREMO1_A1(train_countREM+1:validation_countREM);
% 


%% using  SMOTE to create balanced TRAINING dataset 

% BalancedsleepstageN1CZ_A1_Trainingbalanced = smote(sleepstageN1CZ_A1', 5, 6);
% BalancedsleepstageN1FP1_A1_Trainingbalanced = smote(sleepstageN1FP1_A1', 5, 6);
% BalancedsleepstageN1O1_A1_Trainingbalanced = smote(sleepstageN1O1_A1', 5, 6);
% 
% BalancedsleepstageN1CZ_A1_Trainingbalanced = BalancedsleepstageN1CZ_A1_Trainingbalanced';
% BalancedsleepstageN1FP1_A1_Trainingbalanced = BalancedsleepstageN1FP1_A1_Trainingbalanced';
% BalancedsleepstageN1O1_A1_Trainingbalanced = BalancedsleepstageN1O1_A1_Trainingbalanced';
% 
% 
% % BalancedsleepstageN1CZ_A1_Trainingbalanced = sleepstageN1CZ_A1_training;
% % BalancedsleepstageN1FP1_A1_Trainingbalanced = smote(sleepstageN1FP1_A1_training', 5.9395, 10);
% % BalancedsleepstageN1O1_A1_Trainingbalanced = smote(sleepstageN1O1_A1_training', 5.9395, 10);
% 
% 
% 
% BalancedsleepstageN3CZ_A1_Trainingbalanced = smote(sleepstageN3CZ_A1', 1, 6);
% BalancedsleepstageN3FP1_A1_Trainingbalanced = smote(sleepstageN3FP1_A1', 1, 6);
% BalancedsleepstageN3O1_A1_Trainingbalanced = smote(sleepstageN3O1_A1', 1, 6);
% 
% BalancedsleepstageN3CZ_A1_Trainingbalanced = BalancedsleepstageN3CZ_A1_Trainingbalanced';
% BalancedsleepstageN3FP1_A1_Trainingbalanced = BalancedsleepstageN3FP1_A1_Trainingbalanced';
% BalancedsleepstageN3O1_A1_Trainingbalanced = BalancedsleepstageN3O1_A1_Trainingbalanced';
% 
% % BalancedsleepstageN2CZ_A1_Trainingbalanced = smote(sleepstageN2CZ_A1_training', 0, 10);
% % BalancedsleepstageN2FP1_A1_Trainingbalanced = smote(sleepstageN2FP1_A1_training', 0, 10);
% % BalancedsleepstageN2O1_A1_Trainingbalanced = smote(sleepstageN2O1_A1_training', 0, 10);
% BalancedsleepstageN2CZ_A1_Trainingbalanced = sleepstageN2CZ_A1;
% BalancedsleepstageN2FP1_A1_Trainingbalanced = sleepstageN2FP1_A1;
% BalancedsleepstageN2O1_A1_Trainingbalanced = sleepstageN2O1_A1;
% 
% 
% BalancedsleepstageREMCZ_A1_Trainingbalanced = smote(sleepstageREMCZ_A1', 1.75, 6);
% BalancedsleepstageREMFP1_A1_Trainingbalanced = smote(sleepstageREMFP1_A1', 1.75, 6);
% BalancedsleepstageREMO1_A1_Trainingbalanced = smote(sleepstageREMO1_A1', 1.75, 6);
% 
% BalancedsleepstageREMCZ_A1_Trainingbalanced = BalancedsleepstageREMCZ_A1_Trainingbalanced';
% BalancedsleepstageREMFP1_A1_Trainingbalanced = BalancedsleepstageREMFP1_A1_Trainingbalanced';
% BalancedsleepstageREMO1_A1_Trainingbalanced = BalancedsleepstageREMO1_A1_Trainingbalanced';
% 
% 
% 
% BalancedsleepstageWakeCZ_A1_Trainingbalanced = smote(sleepstageWakeCZ_A1', 1.6, 6);
% BalancedsleepstageWakeFP1_A1_Trainingbalanced = smote(sleepstageWakeFP1_A1', 1.6, 6);
% BalancedsleepstageWakeO1_A1_Trainingbalanced = smote(sleepstageWakeO1_A1', 1.6, 6);
% 
% BalancedsleepstageWakeCZ_A1_Trainingbalanced = BalancedsleepstageWakeCZ_A1_Trainingbalanced';
% BalancedsleepstageWakeFP1_A1_Trainingbalanced = BalancedsleepstageWakeFP1_A1_Trainingbalanced';
% BalancedsleepstageWakeO1_A1_Trainingbalanced = BalancedsleepstageWakeO1_A1_Trainingbalanced';


X_rand = randi(size(sleepstageN1CZ_A1),1,7189);
BalancedsleepstageN1CZ_A1_Trainingbalanced = sleepstageN1CZ_A1(:,X_rand);
BalancedsleepstageN1FP1_A1_Trainingbalanced = sleepstageN1FP1_A1(:,X_rand);
BalancedsleepstageN1O1_A1_Trainingbalanced = sleepstageN1O1_A1(:,X_rand);

X_rand = randi(size(sleepstageN2CZ_A1),1,7189);
BalancedsleepstageN2CZ_A1_Trainingbalanced = sleepstageN2CZ_A1(:,X_rand);
BalancedsleepstageN2FP1_A1_Trainingbalanced = sleepstageN2FP1_A1(:,X_rand);
BalancedsleepstageN2O1_A1_Trainingbalanced = sleepstageN2O1_A1(:,X_rand);

X_rand = randi(size(sleepstageN3CZ_A1),1,7189);
BalancedsleepstageN3CZ_A1_Trainingbalanced = sleepstageN3CZ_A1(:,X_rand);
BalancedsleepstageN3FP1_A1_Trainingbalanced = sleepstageN3FP1_A1(:,X_rand);
BalancedsleepstageN3O1_A1_Trainingbalanced = sleepstageN3O1_A1(:,X_rand);

X_rand = randi(size(sleepstageREMCZ_A1),1,7189);
BalancedsleepstageREMCZ_A1_Trainingbalanced = sleepstageREMCZ_A1(:,X_rand);
BalancedsleepstageREMFP1_A1_Trainingbalanced = sleepstageREMFP1_A1(:,X_rand);
BalancedsleepstageREMO1_A1_Trainingbalanced = sleepstageREMO1_A1(:,X_rand);

X_rand = randi(size(sleepstageWakeCZ_A1),1,7189);
BalancedsleepstageWakeCZ_A1_Trainingbalanced = sleepstageWakeCZ_A1(:,X_rand);
BalancedsleepstageWakeFP1_A1_Trainingbalanced = sleepstageWakeFP1_A1(:,X_rand);
BalancedsleepstageWakeO1_A1_Trainingbalanced = sleepstageWakeO1_A1(:,X_rand);

%%  Multichannel 

%train
% for i = 1:size(BalancedsleepstageN1CZ_A1_Trainingbalanced,2)
% 
%     sequences_train_N1{i,1} = [BalancedsleepstageN1CZ_A1_Trainingbalanced(:,i),BalancedsleepstageN1FP1_A1_Trainingbalanced(:,i),BalancedsleepstageN1O1_A1_Trainingbalanced(:,i)];
% 
%     LabelsN1(i) = categorical({'N1'});     
% end
% 
% for i = 1:size(BalancedsleepstageN2CZ_A1_Trainingbalanced,2)
% 
%     sequences_train_N2{i,1} = [BalancedsleepstageN2CZ_A1_Trainingbalanced(:,i),BalancedsleepstageN2FP1_A1_Trainingbalanced(:,i),BalancedsleepstageN2O1_A1_Trainingbalanced(:,i)];
% 
%     LabelsN2(i) = categorical({'N2'});     
% end
% for i = 1:size(BalancedsleepstageN3CZ_A1_Trainingbalanced,2)
% 
%     sequences_train_N3{i,1} = [BalancedsleepstageN3CZ_A1_Trainingbalanced(:,i),BalancedsleepstageN3FP1_A1_Trainingbalanced(:,i),BalancedsleepstageN3O1_A1_Trainingbalanced(:,i)];
% 
%     LabelsN3(i) = categorical({'N3'});     
% end
% 
% for i = 1:size(BalancedsleepstageREMCZ_A1_Trainingbalanced,2)
% 
%     sequences_train_REM{i,1} = [BalancedsleepstageREMCZ_A1_Trainingbalanced(:,i),BalancedsleepstageREMFP1_A1_Trainingbalanced(:,i),BalancedsleepstageREMO1_A1_Trainingbalanced(:,i)];
% 
%     LabelsREM(i) = categorical({'REM'});     
% end
% 
% for i = 1:size(BalancedsleepstageWakeCZ_A1_Trainingbalanced,2)
% 
%     sequences_train_Wake{i,1} = [BalancedsleepstageWakeCZ_A1_Trainingbalanced(:,i),BalancedsleepstageWakeFP1_A1_Trainingbalanced(:,i),BalancedsleepstageWakeO1_A1_Trainingbalanced(:,i)];
% 
%     LabelsWake(i) = categorical({'Wake'});     
% end

% single channel
for i = 1:ceil(size(BalancedsleepstageN1CZ_A1_Trainingbalanced,2)/3)

    sequences_train_N1(i,:) = BalancedsleepstageN1CZ_A1_Trainingbalanced(:,i);

    LabelsN1(i) = categorical({'N1'});     
end

for i = 1:ceil(size(BalancedsleepstageN2CZ_A1_Trainingbalanced,2)/3)

    sequences_train_N2(i,:) = BalancedsleepstageN2CZ_A1_Trainingbalanced(:,i);

    LabelsN2(i) = categorical({'N1'});     
end
for i = 1:ceil(size(BalancedsleepstageN3CZ_A1_Trainingbalanced,2)/3)

    sequences_train_N3(i,:) = BalancedsleepstageN3CZ_A1_Trainingbalanced(:,i);

    LabelsN3(i) = categorical({'N1'});     
end

for i = 1:size(BalancedsleepstageREMCZ_A1_Trainingbalanced,2)

    sequences_train_REM(i,:) = BalancedsleepstageREMCZ_A1_Trainingbalanced(:,i);

    LabelsREM(i) = categorical({'REM'});     
end

for i = 1:size(BalancedsleepstageWakeCZ_A1_Trainingbalanced,2)

    sequences_train_Wake(i,:) = BalancedsleepstageWakeCZ_A1_Trainingbalanced(:,i);

    LabelsWake(i) = categorical({'Wake'});     
end








sequences_train = [sequences_train_N1; sequences_train_N2;sequences_train_N3;sequences_train_REM ;sequences_train_Wake];
LabelsTrain = [LabelsN1';LabelsN2';LabelsN3';LabelsREM';LabelsWake'];








%validation
% for i = 1:size(sleepstageN1CZ_A1_validation,2)
% 
%     sequences_validation_N1{i,1} = [sleepstageN1CZ_A1_validation(:,i),sleepstageN1FP1_A1_validation(:,i),sleepstageN1O1_A1_validation(:,i)];
% 
%     VLabelsN1(i) = categorical({'N1'});     
% end
% 
% for i = 1:size(sleepstageN2CZ_A1_validation,2)
% 
%     sequences_validation_N2{i,1} = [sleepstageN2CZ_A1_validation(:,i),sleepstageN2FP1_A1_validation(:,i),sleepstageN2O1_A1_validation(:,i)];
% 
%     VLabelsN2(i) = categorical({'N2'});     
% end
% for i = 1:size(sleepstageN3CZ_A1_validation,2)
% 
%     sequences_validation_N3{i,1} = [sleepstageN3CZ_A1_validation(:,i),sleepstageN3FP1_A1_validation(:,i),sleepstageN3O1_A1_validation(:,i)];
% 
%     VLabelsN3(i) = categorical({'N3'});     
% end
% 
% for i = 1:size(sleepstageREMCZ_A1_validation,2)
% 
%     sequences_validation_REM{i,1} = [sleepstageREMCZ_A1_validation(:,i),sleepstageREMFP1_A1_validation(:,i),sleepstageREMO1_A1_validation(:,i)];
% 
%     VLabelsREM(i) = categorical({'REM'});     
% end
% 
% for i = 1:size(sleepstageWakeCZ_A1_validation,2)
% 
%     sequences_validation_Wake{i,1} = [sleepstageWakeCZ_A1_validation(:,i),sleepstageWakeFP1_A1_validation(:,i),sleepstageWakeO1_A1_validation(:,i)];
% 
%     VLabelsWake(i) = categorical({'Wake'});     
% end


% single channel

for i = 1:ceil(size(sleepstageN1CZ_A1_validation,2)/3)

    sequences_validation_N1(i,:) = sleepstageN1CZ_A1_validation(:,i);

    VLabelsN1(i) = categorical({'N1'});     
end

for i = 1:ceil(size(sleepstageN2CZ_A1_validation,2)/3)

    sequences_validation_N2(i,:) = sleepstageN2CZ_A1_validation(:,i);

    VLabelsN2(i) = categorical({'N1'});     
end
for i = 1:ceil(size(sleepstageN3CZ_A1_validation,2)/3)

    sequences_validation_N3(i,:) = sleepstageN3CZ_A1_validation(:,i);

    VLabelsN3(i) = categorical({'N1'});     
end

for i = 1:size(sleepstageREMCZ_A1_validation,2)

    sequences_validation_REM(i,:) = sleepstageREMCZ_A1_validation(:,i);

    VLabelsREM(i) = categorical({'REM'});     
end

for i = 1:size(sleepstageWakeCZ_A1_validation,2)

    sequences_validation_Wake(i,:) = sleepstageWakeCZ_A1_validation(:,i);

    VLabelsWake(i) = categorical({'Wake'});     
end




sequences_validation = [sequences_validation_N1; sequences_validation_N2;sequences_validation_N3;sequences_validation_REM ;sequences_validation_Wake];
LabelsValidation = [VLabelsN1';VLabelsN2';VLabelsN3';VLabelsREM';VLabelsWake'];



% save('C:\courses\ML\project\sequences_validation.mat','sequences_validation')
% save('C:\courses\ML\project\sequences_train.mat','sequences_train')
% save('C:\courses\ML\project\LabelsTrain.mat','LabelsTrain')
% save('C:\courses\ML\project\LabelsValidation.mat','LabelsValidation')



%% 



numFeatures = size(sequences_train,1);
numClasses = numel(categories(LabelsTrain));
% 
% layers = [
%     sequenceInputLayer(numFeatures,'Name','sequence')
%     bilstmLayer(2000,'OutputMode','last','Name','bilstm')
%     dropoutLayer(0.5,'Name','drop')
%     fullyConnectedLayer(numClasses,'Name','fc')
%     softmaxLayer('Name','softmax')
%     classificationLayer('Name','classification')];
% miniBatchSize = 64;
% numObservations = numel(sequences_train);
% numIterationsPerEpoch = floor(numObservations / miniBatchSize);
% 
% options = trainingOptions('adam', ...
%     'MiniBatchSize',miniBatchSize, ...
%     'InitialLearnRate',1e-5, ...
%     'GradientThreshold',2, ...
%     'Shuffle','every-epoch', ...
%         'ValidationData',{sequences_validation,LabelsValidation}, ...
%     'ValidationFrequency',numIterationsPerEpoch, ...
%     'Plots','training-progress', ...
%     'Verbose',false);
% 
% [netLSTM,info] = trainNetwork(sequences_train,LabelsTrain,layers,options);


numFilters = 64;
filterSize = 5;
dropoutFactor = 0.005;
numBlocks = 4;

layer = sequenceInputLayer(numFeatures,Normalization="rescale-symmetric",Name="input");
lgraph = layerGraph(layer);

outputName = layer.Name;

for i = 1:numBlocks
    dilationFactor = 2^(i-1);
    
    layers = [
        convolution1dLayer(filterSize,numFilters,DilationFactor=dilationFactor,Padding="causal",Name="conv1_"+i)
        layerNormalizationLayer
        spatialDropoutLayer(dropoutFactor)
        convolution1dLayer(filterSize,numFilters,DilationFactor=dilationFactor,Padding="causal")
        layerNormalizationLayer
        reluLayer
        spatialDropoutLayer(dropoutFactor)
        additionLayer(2,Name="add_"+i)];

    % Add and connect layers.
    lgraph = addLayers(lgraph,layers);
    lgraph = connectLayers(lgraph,outputName,"conv1_"+i);

    % Skip connection.
    if i == 1
        % Include convolution in first skip connection.
        layer = convolution1dLayer(1,numFilters,Name="convSkip");

        lgraph = addLayers(lgraph,layer);
        lgraph = connectLayers(lgraph,outputName,"convSkip");
        lgraph = connectLayers(lgraph,"convSkip","add_" + i + "/in2");
    else
        lgraph = connectLayers(lgraph,outputName,"add_" + i + "/in2");
    end
    
    % Update layer output name.
    outputName = "add_" + i;
end

layers = [
    fullyConnectedLayer(numClasses,Name="fc")
    softmaxLayer
    classificationLayer];
lgraph = addLayers(lgraph,layers);
lgraph = connectLayers(lgraph,outputName,"fc");

options = trainingOptions('adam', ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',1e-5, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
        'ValidationData',{sequences_validation,LabelsValidation}, ...
    'ValidationFrequency',numIterationsPerEpoch, ...
    'Plots','training-progress', ...
    'Verbose',false);

[netLSTM,info] = trainNetwork(sequences_train,LabelsTrain,lgraph,options);



