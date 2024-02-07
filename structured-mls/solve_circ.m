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
    x=[];
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be circular in any
        %mode
        %TODO return appropriate response
        error('solve_circ:T','Dimensions dont match.')
    end
    if(isTensorCircular(T,[1,2;1,3]))
        omega = tmprod(T,{dftmtx(sz(1)),conj(dftmtx(sz(1))),conj(dftmtx(sz(1)))},[1,2,3])/sz(2)^2;
        y = solve_super_diag(getTensorSuperDiag(omega),size(sz,2),b);
        x = conj(dftmtx(sz(2)))*y'./sz(2);
        return
    end
    if(isTensorCircular(T,[1,2]))
        %TODO
        omega = tmprod(T,{conj(dftmtx(sz(2))),dftmtx(sz(2))},[1,2])/sz(2)^2;
        return

    end
    if(isTensorCircular(T,[2,3]))
        %Possibility of {2,3} circular
        F = 1/sqrt(sz(2))*dftmtx(sz(2));
        F_list = {F,conj(F)};
        omega = tmprod(T,F_list,[2,3]);
        y = solve_part_diag(omega,b);
        x = F\y;
%         x = conj(dftmtx(sz(2))./sz(2))*y;
        return
    end
    if(isTensorCircular(T,[1,3]))
        %TODO
        omega = tmprod(T,{conj(dftmtx(sz(1))),dftmtx(sz(1))},[1,3])/sz(1)^2;
        return
    end
    error("solve_circ:T","Tensor not circular in any mode")
end 