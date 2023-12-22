function [x] = solve_super_diag(D,N,b)
%UNTITLED Summary of this function goes here
%   [x] = SOLVE_SUPER_DIAG(D,N,b) where D is an array containing the
%   diagonal of an Nth-order tensor and b is the right-hand side in the
%   equation:
%      T.2x.3x = b
%   
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/10/25   HD      Initial implementation

    % input check
    % pre-processing
    sz = size(D,2);
    
    % computation
    x = zeros(1,sz);
    for i=1:sz
        x(i) = (b(i)/D(i))^(1/(N-1));
    end
end