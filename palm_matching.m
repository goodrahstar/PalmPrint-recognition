function [L_matched_pts1,L_matched_pts2,R_matched_pts1,R_matched_pts2,L_match_score,R_match_score]=palm_matching(L_features, L_valid_corners,R_features, R_valid_corners,New_L_features, New_L_valid_corners,New_R_features, New_R_valid_corners)
[L_indexPairs,L_match_score] = matchFeatures(L_features,New_L_features,'Method','NearestNeighborSymmetric');
[R_indexPairs,R_match_score] = matchFeatures(R_features,New_R_features,'Method','NearestNeighborSymmetric');


L_matched_pts1 = L_valid_corners(L_indexPairs(1:end,1));
L_matched_pts2 = New_L_valid_corners(L_indexPairs(1:end, 2));

R_matched_pts1 = R_valid_corners(R_indexPairs(1:end, 1));
R_matched_pts2 = New_R_valid_corners(R_indexPairs(1:end, 2));
% mode(L_match_score)
% mode(R_match_score)

end