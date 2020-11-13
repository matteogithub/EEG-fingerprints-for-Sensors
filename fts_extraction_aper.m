addpath('C:\Users\matteo\Downloads\fooof_mat\fooof_mat-master\fooof_mat');
addpath('C:\Users\matteo\Downloads\eeglab_current\eeglab2019_1');
n_sbjs=size(my_data,1);
n_conds=size(my_data,2);
n_chans=size(my_data,3);
n_smpls=size(my_data,4);
fs=128; %sample frequency in Hz
ep_l=15; %epoch length in seconds
n_eps=(n_smpls/fs)/ep_l;
fooof_aper01=zeros(n_sbjs,n_conds,n_chans,n_eps);
fooof_aper02=zeros(n_sbjs,n_conds,n_chans,n_eps);
for i=1:n_sbjs
    i
    for j=1:n_conds
        [smoothdata] = eegfilt(squeeze(my_data(i,j,:,:)),fs,1,50,0,0,0,'fir1');
        smoothdata=reref(smoothdata);
        for w=1:n_eps
            ene=w*ep_l*fs;
            ine=ene-ep_l*fs+1;
            curr_data=squeeze(smoothdata(:,ine:ene));
            [psds, freqs] = pwelch(curr_data', [], [], [], fs);
            freqs = freqs';
            settings = struct();
            f_range = [1, 30];
            fooof_results = fooof_group(freqs, psds, f_range, settings);
            for k=1:n_chans
                fooof_aper01(i,j,k,w)=fooof_results(k).aperiodic_params(1);
                fooof_aper02(i,j,k,w)=fooof_results(k).aperiodic_params(2);                
            end           
        end
    end
end