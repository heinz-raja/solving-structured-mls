function [x,y] = solve_part_diag_asymm(T,b)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
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
        return
    end

    %Computation
    if isequal(type,[1,2])
        %TODO 
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
        z = A\b;
        x = zeros(sz(2),1);
        y = randn(sz(2),1);
        for i=1:sz(2)
            x(i) = z(i)/y(i);
        end
        return;
    end

end