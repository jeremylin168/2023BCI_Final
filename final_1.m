
%mean(EEG.etc.ic_classification.ICLabel.classifications,1)
%%計算ICLabel的分類結果，下面記載使用function的順序

%    0.1225    0.0401    0.0522    0.0047    0.0152    0.0160    0.7494
%    ICA, IClabel

%    0.5406    0.2519    0.0922    0.0074    0.0054    0.0073    0.0953
%    0.5408    0.2518    0.0922    0.0073    0.0054    0.0072    0.0953
%    filter, ICA, IClabel

%    0.5421    0.2561    0.0893    0.0076    0.0047    0.0065    0.0936
%    0.5423    0.2562    0.0893    0.0076    0.0047    0.0064    0.0935
%    filter, ICA, ASR, IClabel

%    0.5685    0.2817    0.0719    0.0054    0.0053    0.0086    0.0586
%    filter, ASR, ICA, IClabel

%    0.2963    0.1933    0.0564    0.0135    0.0135    0.0035    0.4234
%    ICA, filter, IClabel

%    0.2853    0.2080    0.0516    0.0143    0.0137    0.0037    0.4234
%    ICA, filter, ASR, IClabel

% import的channal location file 為 sample_ced.ced
% 將training data先做過band pass filter之後再輸出，用在final_cnn-eeg.ipynb
for i = 1:10
    M = [];
    for j = 1:8
        N = readmatrix(sprintf('./train/subj%d_series%d_data.csv',i,j));
        N(:,1) = [];
        EEGOUT = pop_importdata(data=N', setname=sprintf('./train/subj%d_series%d_data.csv',i,j), chanlocs='./sample_ced.ced', srate=500);
        [EEGOUT, com, b] = pop_eegfiltnew(EEGOUT, 1, 50);
        writematrix(EEGOUT.data', sprintf('./newtrain/subj%d_series%d_data.csv',i,j));        
        N = readmatrix(sprintf('./train/subj%d_series%d_events.csv',i,j));
        writematrix(N, sprintf('./newtrain/subj%d_series%d_events.csv',i,j));
    end
    
end