function [is_diag] = isSqMatrixDiagonal(M,tol)
%UNTITLED Summary of this function goes here
%   [isdiag] = isSqMatrixDiagonal(M,tol) where M is a square matrix and tol
%   is the tolerance
%   is_diag is a boolean indicating whether the matrix is diagonal
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/11/06   HD      Initial implementation
    %input check
    if(numel(size(M))~=2)
        error('isSqMatrixDiagonal:M','Not a matrix')
        return;
    end
    if(size(M,1)~=size(M,2))
        error('isSqMatrixDiagonal:M','matrix not square')
        return;
    end
    if(nargin<2)
        %no tolerance provided, setting default value
        tol=1e-12;
    end
    is_diag=true;
    mat_size = size(M,1);
    for i=1:mat_size
        for j=1:mat_size
            if i==j
                if abs(M(i,j))<=tol
                    is_diag=false;
                    break;
                end
            else
                if abs(M(i,j))>tol 
                    is_diag=false;
                    break;
                end
            end
        end
        if(~is_diag)
            break;
        end
    end
end