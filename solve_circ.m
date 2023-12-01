function x = solve_circ(T,b)
%   [x] = solve_part_diag(T,b) where T is circular of order 3 and b is the 
%   right-hand side in the equation:
%      T.2x.3x = b
%
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/11/18   HD      Initial implementation
    sz = size(T);
    % Assuming T of order 3
    %%TODO check circular structure
    num_unique_dimensions = numel(unique(sz));
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be circular in any
        %mode
        %TODO return appropriate response
        error('solve_circ:T','Dimensions dont match.')
    end
    if(sz(1)==sz(2))
        %Possibility of {1,2} circular
        omega = tmprod(T,{conj(dftmtx(sz(2))),dftmtx(sz(2))},[1,2])/sz(2)^2;
        if isTensorDiagonal(omega)
            %TODO 
            return
        end

    end
    if(sz(2)==sz(3))
        %Possibility of {2,3} circular
        omega = tmprod(T,{conj(dftmtx(sz(2))),dftmtx(sz(2))},[2,3])/sz(2)^2;
        if isTensorDiagonal(omega)
            y = solve_part_diag(omega,b);
        %     x = conj(conj(dftmtx(sz(2)))*y)./sz(2);
            x = conj(dftmtx(sz(2)))*y./sz(2);
            return
        end
    end
    if(sz(1)==sz(3))
        %Possibility of {1,3} circular
        omega = tmprod(T,{conj(dftmtx(sz(1))),dftmtx(sz(1))},[1,3])/sz(1)^2;
        if isTensorDiagonal(omega)
            %TODO 
            return
        end
    end
    error("solve_circ:T","Tensor not circular in any mode")
end 