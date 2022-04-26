function [sleepstageN3, sleepstageN2, sleepstageN1, sleepstageREM, sleepstageWake] = EEGpreprocess(PatientStartNo, PatientEndNo, Datalocation,scoring_interval,sampling_freq,EEGchannel,skipping_interval)

N3_count = 0;
N2_count = 0 ;
N1_count = 0;
REM_count = 0;
Wake_count = 0;
UnknownStageCount = 0;
for i = PatientStartNo:PatientEndNo
    EDFFilename = sprintf('subject%d.edf',i);
    ScoringFilename = sprintf('HypnogramAASM_subject%d.txt',i);
    k  = edfread(fullfile(Datalocation,EDFFilename));
    A = readmatrix(fullfile(Datalocation, ScoringFilename));
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

if EEGchannel == "CZ_A1" 
sleepstageN3 =  sleepstageN3CZ_A1;
sleepstageN2 =  sleepstageN2CZ_A1;
sleepstageN1 =  sleepstageN1CZ_A1;
sleepstageREM =  sleepstageREMCZ_A1;
sleepstageWake =  sleepstageWakeCZ_A1;
elseif EEGchannel == "FP1_A1"

sleepstageN3 =  sleepstageN3FP1_A1;
sleepstageN2 =  sleepstageN2FP1_A1;
sleepstageN1 =  sleepstageN1FP1_A1;
sleepstageREM =  sleepstageREMFP1_A1;
sleepstageWake =  sleepstageWakeFP1_A1;

elseif EEGchannel == "O1_A1"

sleepstageN3 =  sleepstageN3O1_A1;
sleepstageN2 =  sleepstageN2O1_A1;
sleepstageN1 =  sleepstageN1O1_A1;
sleepstageREM =  sleepstageREMO1_A1;
sleepstageWake =  sleepstageWakeO1_A1;

elseif EEGchannel == "Multichannel"
    sleepstageN3 =  [sleepstageN3CZ_A1; sleepstageN3FP1_A1;sleepstageN3O1_A1];
    sleepstageN2 =  [sleepstageN2CZ_A1; sleepstageN2FP1_A1;sleepstageN2O1_A1];
    sleepstageN1 =  [sleepstageN1CZ_A1; sleepstageN1FP1_A1;sleepstageN1O1_A1];
    sleepstageREM =  [sleepstageREMCZ_A1; sleepstageREMFP1_A1;sleepstageREMO1_A1];
    sleepstageWake =  [sleepstageWakeCZ_A1; sleepstageWakeFP1_A1;sleepstageWakeO1_A1];
else
    fprintf('Invalid channel selection');
end

end


