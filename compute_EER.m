function [EER,AUC]=compute_EER(FAR,FRR)

AUC=abs(trapz(FAR,FRR));

min_val=abs(FAR-FRR);

EER_FAR=FAR(find(min_val==min(min_val)));
EER_FRR=FRR(find(min_val==min(min_val)));

EER=(EER_FAR+EER_FRR)/2;