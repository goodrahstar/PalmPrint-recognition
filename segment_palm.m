function [Left_Image,Left_Mask,Right_Image,Right_Mask]=segment_palm(I)
%%
% This function is used to automaticaly generate the ROI and provides the
% Left and Right palm seperately
% INPUT PARAMETER :
%         I = Input Image of palm
% OUTPUT PARAMETER :
%         Left_Image = Croped Left palm image
%         Left_Mask = Mask of croped Left palm image
%         Right_Image = Croped Right palm image
%         Right_Mask = Mask of croped Right palm image

% Obtaining separate objects
% h=waitbar(0,'Loading');

I=imrotate(I,-90);
% waitbar(10/100,'Loading');
GrayIM=rgb2gray(I);
clear I;
% waitbar(3/100,'Loading.');
BinIM=im2bw(GrayIM,graythresh(GrayIM));
% waitbar(6/100,'Loading..');
BinIM= bwmorph(BinIM,'open');
% waitbar(10/100,'Loading...');
% Masking
for i=1:3
BW3 = bwmorph(BinIM,'skel');
BW3 = bwmorph(BW3,'skel');
BinIM = bwmorph(BW3,'open');
end
% waitbar(20/100,'Detecting Palms...');
CC = bwconncomp(BinIM);
L = labelmatrix(CC);
RGB = label2rgb(L);
% figure, imshow(RGB);

% Segmenting

[ro col]=size(RGB);
stats = regionprops(CC,'BoundingBox','Area');
for i=1:CC.NumObjects
    if (stats(i).Area>11180)
        CropImage{i} = imcrop(GrayIM, stats(i).BoundingBox);
        CropMask{i}=imcrop(BinIM, stats(i).BoundingBox);
        [R C]=size(CropImage{i});
        csize(i) = R*C;

%     hold on 
%     rectangle('Position', stats(i).BoundingBox);
%     hold off
     end
end
% waitbar(50/100,'Extracting Left Palm...');
[Value,Index1]= max(csize);
Left_Image=CropImage{Index1};
Left_Mask=CropMask{Index1};
csize(Index1)=0;
% waitbar(70/100,'Extracting Right Palm...');
[Value,Index2]= max(csize);
Right_Image=CropImage{Index2};
Right_Mask=CropMask{Index2};
if (Index1>Index2)
tmp=Left_Image;
tmp2=Left_Mask;
clear Left_Image; clear Left_Mask;
Left_Image=Right_Image;
Left_Mask=Right_Mask;
clear Right_Image; clear Right_Mask;
Right_Image=tmp;
Right_Mask=tmp2;
clear tmp;clear tmp2;
end
% waitbar(80/100);
% figure,
% subplot(1,2,1);imshow(Left_Image);title('Left Palm');
% subplot(1,2,2);imshow(Right_Image);title('Right Palm');
clear BW3
clear BinIM
clear CC
clear CropMask
clear GrayIM
clear L
clear RGB
clear SIZE
% waitbar(90/100);
clear col
clear i
clear C
clear CropImage
clear Index1
clear Index2
clear R
clear Value
clear csize
clear ro
clear stats
% waitbar(100/100,'Done...');
% close(h);
end