function [x] = solve_part_diag(T,b)
%UNTITLED Summary of this function goes here
%   [x] = solve_part_diag(T,b) where T is a partially diagonal tensor of
%   order 3 and b is the right-hand side in the equation:
%      T.2x.3x = b
%   
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/10/25   HD      Initial implementation
    
    %input check
    %Checking the type of partial diagonality
    %Assuming order 3
    sz = size(T);
    num_unique_dimensions = numel(unique(sz));
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be diagonal in any
        %mode
        %TODO return appropriate response
        error('solve_part_diag:T','dimensions dont match')
    end
    if(sz(1)~=size(b,1))
        error('solve_part_diag:T','dimensions of b and T do not match')
    end

    [ans,type]=isTensorDiagonal(T);
    if(~ans)
        error('solve_part_diag:T','Tensor not diagonal in any mode')
    end
    if(sz(1)~=size(b,1))
        error('solve_part_diag:T','dimensions do not match(T and b)')
    end

    %Computation
    if isequal(type,[1,2])
        %TODO 
        A = tens2mat(T,1);
        V = orth(A(:,(sz(2)+1):size(A,2)));
        A_tilde = (eye(size(V,1))-V*V');

    end
    if isequal(type,[1,3])
        %TODO 
    end
    if isequal(type,[2,3])
        A = zeros(sz(1),sz(3));
        for i=1:sz(2)
            A(:,i) = T(:,i,i);
        end
        % Solving equation
        %   Ax^2 = b
        x = sqrt(A\b);

    end
end

