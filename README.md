# Machine-Learning-for-Physical-System : EEG Sleep signal classification using Machine learning

Here, I have uploaded the MATLAB live scripts: 
Procdure to use the code:
Download the EEG sleep (healthy) dataset from the link :https://zenodo.org/record/2650142#.YmgXStPMLRZ
1) From the above link download the DatabaseSubjects.rar file which contains 20 Healthy patient's EEG recordings.
2) Extract the dataset and store it in a suitable location.
3) In the folder DatasetProcessing, use the code Dataset_Processing.mlx for dataset preprocessing and saving the processed dataset. 
4) Provide correct input file location (of the extracted data) to Dataset_Processing.mlx and update the file location to which you need to save the
 processed data.
5) The dataset preprocessing utilizes two approaches 1) SMOTE and 2) Random undersampling. Specify in the code which option you like to choose. 
6) Once the dataset preprocessing is over, use the code HyperparameterTuningBiLSTM.mlx in the folder "TrainandParameterTuning" in this github page for 
   Training and Hyperparameter tuning (using Baysian optimization approach) of the Bidirectional Long Short Term Memory (BiLSTM) models. The input to these code 
   are the processed data (saved as .mat files using Dataset_Processing.mlx). For each dataset (For eg. NREM vs Wake using SMOTE,NREM vs Wake using undersampling)
   etc., we need to provide the suitable input to the code (which is the saved preprocessed data for eg. corresponding to NREM vs Wake using SMOTE) and all the models
   trained models will be saved (saved names corresponds to the validation loss) in the working directory. 
   
   For SVM based approach use the code, HyperparameterTuning_SVM.mlx in the folder TrainandParameterTuningSVM. As described above, input the preprocessed data, the 
   code computes the features, do feature selection, hyperparameter optimization and save the "best" model, original features and reduced features.
   Here also we need rerun the code for each set of dataset.
 7) Once the the above process are computed, use ResultsEvaluation.mlx in the Results folder for result evaluation. Load the "best" model (For SVM, the code
    will only save best model but for BiLSTM, the code saves all trained models, so in that case select the one with lowest validation loss (indicated in the
    names of saved .mat files)). For SVM, load the best models for each dataset and "reduced test features" (after feature selection which we already saved using
    HyperparameterTuning_SVM.mlx), for BiLSTM, load the trained models as well as the processed test data and labels (saved using Dataset_Processing.mlx) for computing
    the metrics.
    
 Note: There is no Bugs in the code but there are few problems with Figures and Tables when converting MATLAB live script to Markdown files.  
