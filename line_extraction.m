function [Feature_Line] = line_extraction(Lines,CropImage)
Left=Lines>0.5;
CLines=bwmorph(Left,'thicken',2);

CL=bwmorph(CLines,'close',2);
CL=bwmorph(CL,'thicken',5);
CL=bwmorph(CL,'close',5);

% figure,imshow(CL);

CC = bwconncomp(CL);
L = labelmatrix(CC);
RGB = label2rgb(L);
% figure, imshow(RGB);
S=regionprops(CC);
 idx = find([S.Area] >4000);
Feature_Line = ismember(labelmatrix(CC), idx);
% imshow(Feature_Line);
% Feature_Line(:,find(all(cellfun(@isempty,Feature_Line),1))) = [];
end