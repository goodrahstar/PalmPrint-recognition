function [New_L_features, New_L_valid_corners,New_R_features, New_R_valid_corners]=palm_features(Left_Image,Left_Mask,Right_Image,Right_Mask)
%%
% This funtion extract the principle line features
% h=waitbar(0,'Processing Left Palm...');
Left_Lines = p_lines(double(Left_Image),double(Left_Mask),14);
% waitbar(20/100,'Processing Left Palm...');
Right_Lines = p_lines(double(Right_Image),double(Right_Mask),14);
% waitbar(40/100,'Extracting Feature from Left Palm...');
Left_FLine = line_extraction(Left_Lines,Left_Image);
% waitbar(60/100,'Extracting Feature from Right Palm...');
Right_FLine = line_extraction(Right_Lines,Right_Image);
%% 
% Feature Extraction
% waitbar(80/100,'Detecting Principle line...');
Left_Template = detectMinEigenFeatures(Left_FLine);
% waitbar(90/100,'Detecting Principle line...');
Right_Template = detectMinEigenFeatures(Right_FLine);
% waitbar(95/100,'Done...');
[New_L_features, New_L_valid_corners] = extractFeatures(Left_FLine,Left_Template);  
% waitbar(100/100,'Done...');
[New_R_features, New_R_valid_corners] = extractFeatures(Right_FLine,Right_Template);  
% close(h);
% figure, imshow(Left_Image); hold on;
% plot(New_L_valid_corners);
% 
% figure, imshow(Right_Image); hold on;
% plot(R_valid_corners);
