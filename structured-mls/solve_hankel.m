function x = solve_hankel(T,b)
%   [x] = solve_part_diag(T,b) where T is hankel of order 3 and b is the 
%   right-hand side in the equation:
%      T.2x.3x = b
%
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/12/29   HD      Initial implementation
    sz = size(T);
    % Assuming T of order 3
    %%TODO check hankel structure
    num_unique_dimensions = numel(unique(sz));
    x=[];
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be hankel in any
        %mode
        %TODO return appropriate response
        error('solve_circ:T','Dimensions dont match.')
    end
    if(isTensorHankel(T,[1,2;1,3]))
        F = dftmtx(sz(1));
        omega = tmprod(T,{F,F,F},[1,2,3])/sz(2)^2;
        y = solve_super_diag(getTensorSuperDiag(omega),size(sz,2),b);
        x = conj(dftmtx(sz(2)))*y'./sz(2);
        return
    end
    if(isTensorHankel(T,[1,2]))
        %TODO
        F = dftmtx(sz(2));
        omega = tmprod(T,{F,F},[1,2])/sz(2)^2;
        return

    end
    if(isTensorHankel(T,[2,3]))
        %Possibility of {2,3} hankel
        F = dftmtx(sz(2));
        F_list = {F,F};
        omega = tmprod(T,F_list,[2,3])./sz(2)^2;
        y = solve_part_diag(omega,b);
        x = conj(dftmtx(sz(2)))*y./sz(2);
        return
    end
    if(isTensorHankel(T,[1,3]))
        %TODO
        omega = tmprod(T,{conj(dftmtx(sz(1))),dftmtx(sz(1))},[1,3])/sz(1)^2;
        return
    end
    error("solve_circ:T","Tensor not hankel in any mode")
end 