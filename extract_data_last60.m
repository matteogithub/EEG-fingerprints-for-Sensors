n_exp=18;
n_sbjs=23;
n_ch=14;
time_w=60;
fs=128;
my_data=zeros(n_sbjs,n_exp,n_ch,time_w*fs);
my_base=zeros(n_sbjs,n_exp,n_ch,time_w*fs);

for i=1:n_sbjs
    i
    tic
    sbj_data=DREAMER.Data{i}.EEG;
    for j=1:n_exp
        tmp_data=DREAMER.Data{i}.EEG.stimuli{j}(1:time_w*fs,:);
        my_data(i,j,:,:)=tmp_data';
        tmp_data=DREAMER.Data{i}.EEG.baseline{j}(1:time_w*fs,:);
        my_base(i,j,:,:)=tmp_data'; 
    end
    toc
end