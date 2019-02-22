for j=1:21
root='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\';

load(sprintf('%s%iF.mat',root,j));
for i=1:21
U=load(sprintf('%s%iF.mat',root,i));
[L_matched_pts1,L_matched_pts2,R_matched_pts1,R_matched_pts2,L_match_score,R_match_score]=palm_matching(L_features, L_valid_corners,R_features, R_valid_corners,U.L_features,U.L_valid_corners,U.R_features, U.R_valid_corners);
if((mode(L_match_score)+mode(R_match_score))<=10)
Percent=100-(mode(L_match_score)+mode(R_match_score))*10;
disp(sprintf('Matching Percentage = %i',Percent));
Score{i}={mode(L_match_score),mode(R_match_score),Percent};

else
    disp('Not Matched');
    
Score{j}.user{i}={mode(L_match_score),mode(R_match_score),0};
end
end
end