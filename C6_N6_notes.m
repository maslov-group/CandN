% Both the files 'C6_N6_Flux_vs_AllUIS.txt'
% and 'C6_N6_Flux_vs_AllUIS.mat' generated by the 
% commands below are located in the online folder at 
% https://www.dropbox.com/sh/cqhrgs3zg5dccwe/AAAHh1DKri9BS8xCZFZg2G34a?dl=0
a=dlmread('C6_N6_Flux_vs_AllUIS.txt');
%a=dlmread('C6_N6_Flux_vs_StableUIS.txt');
L=6;
fluxes=a(:,1:2.*L);
asym_fluxes=sum(fluxes(:,1:L),2)./sum(fluxes(:,(L+1):2.*L),2);
% f_states are feasible stable states (out of 1022 for L=6)
f_states=a(:,(2.*L+1):end);
[flux_stats,N_states]=size(f_states);
%m_states is the multiplicity of states for a given flux set
m_states=sum(f_states,2);
% find stable states (canduidates) as ones 
% present alone for at least oe flux
i1=find(m_states==1);
[a,b,c]=find(f_states(i1,:));
a_stable=zeros(1211,1);
a_stable(b)=1;
% zero volume states can be stable or unstable
a_zero=(v_states==0).*ones(1211,1);
a_zero=full(a_zero);
a_nonzero=1-a_zero;
% true unstable states excluding zero volume
a_unstable=1-a_stable;
i1=find(a_unstable.*a_zero);
a_unstable(i1)=0;
%
i_stable=find(a_stable);
i_unstable=find(a_unstable);
i_nonzero=find(a_nonzero);
%%
% Search of putative unstable states that are 
% in fact stable.
% Indices are unique for our problem
% End result is 36 unstable states
sum(ms_states~=mu_states+1)
sum(ms_states>mu_states+1)
i1=find(ms_states<mu_states+1); whos i1
km=sum(f_states(i1,:),1)';
km1=km.*a_unstable;
[x,y]=sort(km1,'descend');
%%
a_stable_candidates=zeros(1211,1);
a_stable_candidates(y(1:2))=1;
a_stable_candidates(y(5:6))=1;
a_stable_candidates(y(11:12))=1;
a_stable_candidates(y(16:17))=1;
a_stable_candidates(y(20))=1;
a_stable_candidates(y(22))=1;
a_stable_candidates(y(24))=1;
a_stable_candidates(y(29))=1;
a_stable_candidates(y(33))=1;
a_stable_candidates(y(36:37))=1;
a_stable_candidates(y(40))=1;
a_stable_candidates(y(42))=1;
a_stable_candidates(y(44:45))=1;
a_stable_candidates(y(58:60))=1;
a_stable_candidates(y(62))=1;
a_stable_candidates(y(67))=1;
a_stable_candidates(y(77))=1;
a_stable_candidates(y(83))=1;
%
% Let me speed it up
[i,j,v]=find(f_states);
fs1_states=sparse(i,j,v.*(a_stable(j)+a_stable_candidates(j)),1000000,1211);
fu1_states=sparse(i,j,v.*(a_unstable(j)-a_stable_candidates(j)),1000000,1211);
ms1_states=sum(fs1_states,2);
mu1_states=sum(fu1_states,2);
%
i2=find(ms1_states<mu1_states+1); whos i1
km2=sum(f_states(i2,:),1)';
km3=km2.*(a_unstable-a_stable_candidates);
[x3,y3]=sort(km3,'descend');
%
a_stable_candidates(y3(9))=1;
a_stable_candidates(y3(10))=1;
a_stable_candidates(y3(12))=1;
a_stable_candidates(y3(13))=1;
a_stable_candidates(y3(14))=1;
a_stable_candidates(y3(15))=1;
a_stable_candidates(y3(19))=1;
a_stable_candidates(y3(20))=1;
a_stable_candidates(y3(21))=1;
a_stable_candidates(y3(22))=1;
[i,j,v]=find(f_states);
fs1_states=sparse(i,j,v.*(a_stable(j)+a_stable_candidates(j)),1000000,1211);
fu1_states=sparse(i,j,v.*(a_unstable(j)-a_stable_candidates(j)),1000000,1211);
ms1_states=sum(fs1_states,2);
mu1_states=sum(fu1_states,2);
sum(ms1_states<mu1_states+1)
sum(ms1_states>mu1_states+1)
%%
a_unstable_final=a_unstable-a_stable_candidates;
a_stable_final=a_stable+a_stable_candidates;
sum(a_stable_final)
sum(a_unstable_final)
%%
i_stable_final=find(a_stable_final);
i_unstable_final=find(a_unstable_final);
%%
%
% we had 1022 stable, 173 putative unstable 
% and 16 zero volume states 
%
% after correction we have 
% 1022+36=1058 stable states
% and 173-36=137 unstable states
%
% v_states are volumes of states
%%
v_states=sum(f_states,1)./flux_stats;
v_states=v_states';
%%
% the matrix of overlaps between states
overlap=f_states'*f_states./flux_stats;
overlap=overlap-diag(diag(overlap));
%%
[a1,b1]=hist(log10(v_states(i_stable)),-6:0.5:-1);
figure; semilogy(b1,a1./sum(a1),'go-');
%%
hold on;
[a2,b2]=hist(log10(v_states(i_unstable)),-6:0.5:-1);
semilogy(b2,a2./sum(a2),'rd-');
%%
% More accurately
[a1,b1]=hist(log10(v_states(i_stable_final)),-6:0.5:-1);
figure; semilogy(b1,a1./sum(a1),'go-');
hold on;
[a2,b2]=hist(log10(v_states(i_unstable_final)),-6:0.5:-1);
semilogy(b2,a2./sum(a2),'rd-');
%
%figure;
aux3=overlap(i_stable_final,i_stable_final);
aux4=overlap(i_stable_final,i_unstable_final);
aux5=overlap(i_unstable_final,i_unstable_final);
[a3,b3]=hist(log10(aux3(find(aux3))),-6:0.5:-1);
hold on; semilogy(b3,a3./sum(a3),'bs-')
[a4,b4]=hist(log10(aux4(find(aux4))),-6:0.5:-1);
hold on; semilogy(b4,a4./sum(a4),'mv-')
[a5,b5]=hist(log10(aux5(find(aux5))),-6:0.5:-1);
hold on; semilogy(b5,a5./sum(a5),'k^-')
%%
k_overlap=sum(sign(overlap))';
figure; loglog(sort(k_overlap,'descend'),'ko-')
figure; loglog(v_states,k_overlap,'ko')
%%
k_weighted_overlap=sum(overlap)';
figure; loglog(sort(k_weighted_overlap,'descend'),'ko-')
figure; loglog(v_states,k_weighted_overlap,'ko')
%%
k_s=sum(sign(overlap(:,i_stable_final)),2)';
k_u=sum(sign(overlap(:,i_unstable_final)),2)';
figure; 
loglog(v_states(i_stable_final),k_s(i_stable_final),'go'); hold on;
loglog(v_states(i_unstable_final),k_s(i_unstable_final),'rd');
loglog(v_states(i_stable_final),k_u(i_stable_final),'kv');
loglog(v_states(i_unstable_final),k_u(i_unstable_final),'bs');
%%
kw_s=sum(overlap(:,i_stable_final))';
kw_u=sum(overlap(:,i_unstable_final))';
%%
% Zipf laws
figure; loglog(sort(v_states,'descend'),'ko-');
hold on; loglog(sort(overlap(:),'descend'),'rd-');
%%
[i,j,v]=find(overlap);
v1=v./min(v_states(i),v_states(j));
i1=find(i>j);
overlap_norm=sparse(i(i1),j(i1),v1(i1),N_states,N_states);
%overlap_norm=overlap_norm-diag(diag(overlap_norm));
%%
[a,b]=hist(overlap_norm(:),200);
figure; semilogy(b,a,'ko-')
%%
% calculate the probability distribution of volumes 
% of states with zero 
% overlap (black circles) and compare it to 
% that (red diamons) of all states (with nonzero volumes)
% Hypothesis: states with zero overlaps are smaller. 
% It is partially confirmed
i1=find((k_overlap==0).*(v_states>0)); whos i1
[a4,b4]=hist(log10(v_states(i1)),-6:0.5:-1);
figure; semilogy(b4,a4./sum(a4),'ko-')
hold on;
[a1,b1]=hist(log10(v_states(find(v_states))),-6:0.5:-1);
hold on; semilogy(b1,a1./sum(a1),'rd-')
%%
% m_volume_fractions(m,k) calculates the fractions of 
% the volume of state k where it is m-stable
m_max=max(m_states);
for k=1:N_states; 
    i1=find(f_states(:,k)); 
    n1=m_states(i1);[r1,p1]=hist(n1,1:m_max); 
    m_volume_fractions(1:m_max,k)=r1./max(length(i1),1); 
end;
figure; semilogy(m_volume_fractions,'ko')
figure; loglog(m_volume_fractions(2,:),m_volume_fractions(3,:),'ko')
%%
v_states_log10_pos=6+log10(v_states);
stable_flag=2.*a_stable_final+1.*a_unstable_final;
for m=1:N_states; names1{m}=num2str(m); end;
i1=adj2gephilab_sm_2_parameters('C6_N6_overlap_AllStates',overlap_norm,names1,v_states_log10_pos,stable_flag);
%%
i1=adj2gephilab_sm('C6_N6_overlap',overlap_norm,names1);
%%
for m=1:1211; 
    i1=find(f_states(:,m)); 
    if length(i1)>0; 
        for k=1:2.*L; 
            fluxes_average(m,k)=mean(fluxes(i1,k)); 
            fluxes_std(m,k)=std(fluxes(i1,k)); 
        end; 
    end; 
end;