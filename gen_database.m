%% Database
% Place this file in 
% E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\Database
% directory
try
    % construct image string and load image
for j=1:21
proceed = 1;
Root='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\Database\';
DRoot='E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\D_mat\';
Face='\face.JPG';
Palm='\Palm\1.jpeg';

Names = ls;
Names=cellstr(Names);
Names(1)=[];
Names(1)=[];
            User.Name=char(Names(j));
            s = sprintf('%s%s%s',Root,User.Name,Face);
            User.Face=imread(s);
            User.Face=rgb2gray(User.Face);
            User.Face= imresize(User.Face, 0.5);
            ss=sprintf('%s%s%s',Root,User.Name,Palm);
            User.Palm=imread(ss);

            savefile=sprintf('%s%i.mat',DRoot,j);
            save(savefile,'-struct','User');
            clear
         end    
catch
   proceed = 0;
   disp(sprintf('Could not load images from the database. Did you unpack it into \nthe appropriate directory? If NOT please follow the instructions \nin the user manual or the provided install script.'));
end
disp('Finished loading BioData.')
%% Feature Database

for i=1:21
 ROOT=   'E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\D_mat\';
 DROOT=   'E:\RESEARCH WORK\BIOMETRIC SYSTEM\Multimodal Biometrics\DFeature_mat\';
  s=sprintf('%s%i.mat',ROOT,i);
  load(s);
    
[Left_Image,Left_Mask,Right_Image,Right_Mask]=segment_palm(Palm);
[L_features, L_valid_corners,R_features, R_valid_corners]=maskin_using_bwmorph (Left_Image,Left_Mask,Right_Image,Right_Mask);
 
savefile=sprintf('%s%iF.mat',DROOT,i);
            save(savefile,'L_features', 'L_valid_corners','R_features', 'R_valid_corners');
            clear
            clock
end

