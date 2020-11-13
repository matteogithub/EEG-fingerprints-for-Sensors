function [EERs] = compute_perf(fts_data)
EERs=zeros(size(fts_data,2),1);
for i=1:size(fts_data,2)
    fts=squeeze(fts_data(:,i,:,:));
    fts=permute(fts,[3 1 2]);
    fts=reshape(fts,size(fts,1)*size(fts,2),size(fts,3));
    
    dist=zeros(size(fts,1),size(fts,1));
    scores=ones(size(fts,1),size(fts,1));
    
    for r=1:size(fts,1)
        for c=1:size(fts,1)
            if(r~=c)
                dist(r,c)=norm(squeeze(fts(r,:))-squeeze(fts(c,:)));
                scores(r,c)=1./(1+dist(r,c));
            end
        end
    end
    
    v_id=zeros(size(scores,1),1);
    n_eps=size(fts_data,4);
    
    for k=1:size(scores,1)/n_eps
        iend=k*n_eps;
        v_id(iend-(n_eps-1):iend,1)=k;
    end
    
    scoreG=zeros(size(scores,1)/n_eps*((n_eps*n_eps-n_eps)/2),1);
    scoreI=zeros(size(scores,1)/n_eps*(size(scores,1)/n_eps-1)*n_eps*n_eps/2,1);
    
    indg=1;
    indi=1;    
    for j=1:size(scores,1)
        for jj=1:size(scores,1)
            if(j<jj)
                if(v_id(j)==v_id(jj))
                    scoreG(indg,1)=scores(j,jj);
                    indg=indg+1;
                else
                    scoreI(indi,1)=scores(j,jj);
                    indi=indi+1;
                end
            end
        end
    end
    
    [FAR,FRR]=compute_FAR_FRR(scoreG,scoreI);
    [EER,AUC]=compute_EER(FAR,FRR);
    EER
    EERs(i)=mean(EER,2);
end
end

