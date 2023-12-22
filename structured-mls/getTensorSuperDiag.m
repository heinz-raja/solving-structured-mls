function sdiag = getTensorSuperDiag(T)
%UNTITLED Summary of this function goes here
%   sdiag = getTensorSuperDiag(T) where T is a tensor 
%   sdiag is an array containing the superdiagonal elements of T
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/11/13   HD      Initial implementation
sz = size(T);
num_unique_dimensions = numel(unique(sz));
if num_unique_dimensions ~= 1
    error('getTensorSuperDiag:T','Tensor dimensions are not the same size');
end
sdiag = zeros(1,sz(1));
for i=1:sz(1)
    sdiag(i) = T(i,i,i);
end
end