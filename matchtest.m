for i=1:21

root='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\';
root1='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\D_mat\';
load(sprintf('%s%iF.mat',root,i));
load(sprintf('%s%i.mat',root1,i));
    
    for j=1:5

Image=sprintf('%i-1 (%i).jpeg',i,j);
cd dataset\
I=imread(Image);
cd ..
disp('Segmenting...');
[Left_Image,Left_Mask,Right_Image,Right_Mask]=segment_palm(I);
disp('Feature extraction...');
[New_L_features, New_L_valid_corners,New_R_features, New_R_valid_corners]=palm_features(Left_Image,Left_Mask,Right_Image,Right_Mask);

% load('E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\3F.mat');
% load('E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\D_mat\3.mat');

[OLeft_Image,OLeft_Mask,ORight_Image,ORight_Mask]=segment_palm(Palm);
disp('Matching...');
[L_matched_pts1,L_matched_pts2,R_matched_pts1,R_matched_pts2,L_match_score,R_match_score]=palm_matching(L_features, L_valid_corners,R_features, R_valid_corners,New_L_features, New_L_valid_corners,New_R_features, New_R_valid_corners);
if((mode(L_match_score)+mode(R_match_score))<=10)
Percent=100-(mode(L_match_score)+mode(R_match_score))*10;
% disp(sprintf('Matching Percentage = %i',Percent));
Score{i}.U{j}={mode(L_match_score),mode(R_match_score),Percent};

else
%     disp('Not Matched');
Score{i}.U{j}={mode(L_match_score),mode(R_match_score),0};

end


%
% figure;
% for i=1:20:size(L_matched_pts1,1)
% showMatchedFeatures(OLeft_Image,Left_Image,L_matched_pts1(i),L_matched_pts2(i),'montage');
% 
% title('Putative point matches');
% legend('matchedPts1','matchedPts2');
% drawnow;
% end
    end
end
%%
% 
% I=imread('dataset\1-1 (5).jpeg');
% [Left_Image,Left_Mask,Right_Image,Right_Mask]=segment_palm(I);
% [L_features1, L_valid_corners1,R_features1, R_valid_corners1]=maskin_using_bwmorph (Left_Image,Left_Mask,Right_Image,Right_Mask);
% 
% I=imread('dataset\13-1 (1).jpeg');
% [Left_Image,Left_Mask,Right_Image,Right_Mask]=segment_palm(I);
% [L_features13, L_valid_corners13,R_features13, R_valid_corners13]=maskin_using_bwmorph (Left_Image,Left_Mask,Right_Image,Right_Mask);
% 
% 
% %% 
% % Matching
% C=load('E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\1F.mat');
% I=load('E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\5F.mat');
% 
% [L_indexPairs,L_true_score] = matchFeatures(C.L_features,I.L_features);
% mean(L_true_score)
% mode(L_true_score)
% [R_indexPairs,R_true_score] = matchFeatures(R_features,R_features1);
% figure,
% subplot(1,2,1), hist(L_true_score,size(L_true_score,1));title('Same man Left');
% subplot(1,2,2), hist(R_true_score,size(R_true_score,1));title('Same man Right');
% 
% % [L_indexPairs,L_false_score] = matchFeatures(L_features,L_features13);
% % [R_indexPairs,R_false_score] = matchFeatures(R_features,R_features13);
% % figure, 
% % subplot(1,2,1),hist(L_false_score,size(L_false_score,1));title('Diff man Left');
% % subplot(1,2,2),hist(R_false_score,size(R_false_score,1));title('Diff man Right');
% % 
% % [L_indexPairs,L_false_score1] = matchFeatures(L_features1,L_features13);
% % [R_indexPairs,R_false_score1] = matchFeatures(R_features1,R_features13);
% % figure, 
% % subplot(1,2,1),hist(L_false_score1,size(L_false_score1,1));title('Diff man Left');
% % subplot(1,2,2),hist(R_false_score1,size(R_false_score1,1));title('Diff man Right');
% % 
% % [ver_rate, miss_rate, rates] = produce_ROC_PhD(L_true_score,L_false_score);
% % 
% % rates.FRR_10FAR_ver
% % figure, 
% % plot_ROC_PhD(ver_rate, miss_rate);
% % 
% % [ver_rate, miss_rate, rates] = produce_ROC_PhD(L_true_score,L_false_score1);
% % 
% % rates.FRR_10FAR_ver
% % figure, 
% % plot_ROC_PhD(ver_rate, miss_rate);
% 
% 
% %% showMatchedFeatures
% % 
% % 
% matched_pts1 = L_valid_corners(L_indexPairs(1:end, 1));
% matched_pts2 = L_valid_corners(L_indexPairs(1:end, 2));
% 
% figure; showMatchedFeatures(Left_Image,Left_Image13,matched_pts1,matched_pts2,'montage');
% title('Putative point matches');
% legend('matchedPts1','matchedPts2');