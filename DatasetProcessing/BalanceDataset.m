function [BalancedsleepData, Class, count] = BalanceDataset(SleepData_Training,TrainingClass,option,dataset)

if strcmp('Testing',dataset)
         uC = unique(TrainingClass); % Class list
     [GC,GR] = groupcounts(TrainingClass') ; % Number of observations of each class
         Class(1:GC(1)) = "N1";
Class(1+GC(1):GC(1)+GC(2)) = "N2";
Class(GC(1)+GC(2)+1:GC(1)+GC(2)+GC(3)) = "N3";
Class(GC(1)+GC(2)+GC(3)+1:GC(1)+GC(2)+GC(3)+GC(4)) = "REM";
Class(GC(1)+GC(2)+GC(3)+GC(4)+1:GC(1)+GC(2)+GC(3)+GC(4)+GC(5)) = "Wake";
BalancedsleepData = SleepData_Training;
count = GC;
else
     uC = unique(TrainingClass); % Class list
[GC,GR] = groupcounts(TrainingClass') ; % Number of observations of each class
% SleepData_Training = SleepData_Training1';
if strcmp('SMOTE',option)

BalancedsleepDataN1 = smote(SleepData_Training(1:GC(1),:),(max(GC)/ GC(1))-1,10);
BalancedsleepDataN2 = smote(SleepData_Training(GC(1)+1:GC(1)+GC(2),:), (max(GC)/ GC(2))-1,10);
BalancedsleepDataN3 = smote(SleepData_Training(GC(1)+GC(2)+1:GC(3)+GC(2)+GC(1),:), (max(GC)/ GC(3))-1,10);
BalancedsleepDataREM = smote(SleepData_Training(GC(3)+GC(2)+GC(1)+1:GC(3)+GC(2)+GC(1)+GC(4),:), (max(GC)/ GC(4))-1,10);
BalancedsleepDataWake = smote(SleepData_Training(GC(3)+GC(2)+GC(1)+GC(4)+1:GC(3)+GC(2)+GC(1)+GC(4)+GC(5),:), (max(GC)/ GC(5))-1,10);
BalancedsleepData  = [BalancedsleepDataN1;BalancedsleepDataN2;BalancedsleepDataN3;BalancedsleepDataREM;BalancedsleepDataWake];
maxA = max(GC);
    Class(1:maxA) = "N1";
Class(1+maxA:2*maxA) = "N2";
Class(1+2*maxA:3*maxA) = "N3";
Class(1+3*maxA:4*maxA) = "REM";
Class(1+4*maxA:5*maxA) = "Wake";
count = maxA;

else
minA = min(GC);
    X_rand = randi(GC(1),1,minA);
BalancedsleepstageN3_Undersample = SleepData_Training(X_rand,:);
Class(1:minA,1) = "N1";
    X_rand = randi([GC(1)+1,GC(1)+GC(2)],1,minA);
BalancedsleepstageN2_Undersample = SleepData_Training(X_rand,:);
Class(1+minA:2*minA) = "N2";
    X_rand = randi([GC(1)+GC(2)+1,GC(3)+GC(2)+GC(1)],1,minA);
BalancedsleepstageN1_Undersample = SleepData_Training(X_rand,:);
Class(1+2*minA:3*minA) = "N3";
    X_rand = randi([GC(3)+GC(2)+GC(1)+1,GC(3)+GC(2)+GC(1)+GC(4)],1,minA);
BalancedsleepstageREM_Undersample = SleepData_Training(X_rand,:);
Class(1+3*minA:4*minA) = "REM";
    X_rand = randi([GC(3)+GC(2)+GC(1)+GC(4)+1,GC(3)+GC(2)+GC(1)+GC(4)+GC(5)],1,minA);
BalancedsleepstageWake_Undersample = SleepData_Training(X_rand,:);
Class(1+4*minA:5*minA) = "Wake";
BalancedsleepData = [BalancedsleepstageN1_Undersample;BalancedsleepstageN2_Undersample;BalancedsleepstageN3_Undersample;BalancedsleepstageREM_Undersample;...
    BalancedsleepstageWake_Undersample];
count = minA;
end
end