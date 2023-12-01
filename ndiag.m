function [D,Dstruct] = ndiag(array,order)
%NDIAG Diagonal tensor
%   [D,Dstruct] = ndiag(array,order) returns a diagonal tensor of order
%   order both as a dense tensor D and a struct Dstruct.

% Author(s): Martijn Boussé      (Martijn.Bousse@esat.kuleuven.be)
%
% Version History:
% - 2016/03/10   MB      Initial version

% Define diagonal tensor as a sparse tensor using a struct.
dim = length(array);
Dstruct.val = array;
tmp = (1:dim).';
Dstruct.sub = tmp(:,ones(1,order));
Dstruct.size = dim*ones(1,order);
Dstruct.sparse = true;

% Format unity tensor as sparse tensor.
Dstruct = fmt(Dstruct);

% Compute dense tensor.
D = ful(Dstruct);



end

