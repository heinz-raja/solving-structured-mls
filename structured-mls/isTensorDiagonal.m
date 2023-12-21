function [is_diag,type] = isTensorDiagonal(T,tol)
%UNTITLED Summary of this function goes here
%   [isdiag,type] = isTensorDiagonal(T,tol) where T is a third order
%   tensor and tol is the tolerance ...?    
%   isdiag is a boolean indicating whether the tensor is diagonal and type
%   is an array that describes what type of diagonailty the tensor has
%   type=[1,2] indicates the tensor is diagonal in mode 1 and 2
%   
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/11/05   HD      Initial implementation
    %input check
    if(nargin<2)
        %no tolerance provided, setting default value
        tol=1e-12;
    end
    %Checking the type of diagonality
    %Assuming order 3
    sz = size(T);
    num_unique_dimensions = numel(unique(sz));
    %default return values
    is_diag = false;
    type = [];
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be diagonal in any
        %mode
        %TODO return appropriate response
        error('isTensorDiagonal:T','Dimensions dont match.')
    end
    if num_unique_dimensions==1
        %all modes have same dimenstion, possiblility of being fully
        %diagonal
        isfullydiagonal = true;
        tmp = T - ndiag(getTensorSuperDiag(T),size(sz,2));
        if sum(abs(tmp),'all') > tol
            isfullydiagonal = false;
        end
        if(isfullydiagonal)
            is_diag=true;
            type=[1,2,3];
            return;
        end
    end
    is_diag = true;
    if(sz(1)==sz(2))
        %Possibility of {1,2} diagonal
        sum_matrix = sum(abs(T),3);
        if(isSqMatrixDiagonal(sum_matrix,tol))
            type =[1,2];
            return;
        end
    end
    if(sz(2)==sz(3))
        %Possibility of {2,3} diagonal
        sum_matrix = squeeze(sum(abs(T),1));
        if(isSqMatrixDiagonal(sum_matrix,tol))
            type =[2,3];
            return;
        end
    end
    if(sz(1)==sz(3))
        %Possibility of {1,3} diagonal
        sum_matrix = squeeze(sum(abs(T),2));
        if(isSqMatrixDiagonal(sum_matrix,tol))
            type =[1,3];
            return;
        end
    end
    is_diag=false;
    type=[];
end