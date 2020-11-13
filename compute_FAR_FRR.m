function [FAR,FRR]=compute_FAR_FRR(scoreG,scoreI)
count=1;
for thrs=0:.01:1
    n_G=0;
    n_I=0;
    for ind_scoreG=1:length(scoreG)
        if scoreG(ind_scoreG)<=thrs
            n_G=n_G+1;
        end
    end
    for ind_scoreI=1:length(scoreI)
        if scoreI(ind_scoreI)>thrs
            n_I=n_I+1;
        end
    end
    FRR(count)=(n_G/length(scoreG));
    FAR(count)=(n_I/length(scoreI));
    count=count+1;
end

