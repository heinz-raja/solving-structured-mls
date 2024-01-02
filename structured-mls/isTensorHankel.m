function [ishankel,modes] = isTensorHankel(T,modes_to_check)
%   [x] = isTensorhankel(T,mode) where T is a tensor of
%   order 3 and mode is an optional argument. The function checks if the
%   tensor is hankel in the given mode(s), mode is a m x 2 matrix where
%   each row represents the mode to check
%   
%   if mode is not provided the
%   function automatically checks for all modes 
%   
%   The method used to check hankel is by trying to convert the given
%   tensor to a diagonal tensor using fourier bases if it is diagonalizable
%   in a mode then it is hankel in that mode
%
%   ishankel is a boolean indicating whether the tensor is hankel in
%   any mode
% 
%   modes is an m x 2 matrix where each row contains the mode in which the
%   tensor is hankel in 
%
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/12/01   HD      Initial implementation
    sz=getsize(T);
    num_unique_dimensions = numel(unique(sz));
    if numel(sz)==num_unique_dimensions
        %all modes are of different size and thus cannot be hankel in any
        %mode
        error('isTensorhankel:T','Dimensions dont match.')
    end
    %Initial return values
    ishankel = false;
    modes = [];

    if(nargin==2)
        sz_mode = size(modes_to_check);
        if(size(sz_mode)~=2)
            error('isTensorhankel:mode','Incorrect dimensions,mode must be a mx2 matrix')
        end
        if(sz_mode(2)~=2)
            error('isTensorhankel:mode','Incorrect dimensions,mode must be a mx2 matrix')
        end
        %mode(s) to check provided, checking for that mode(s)
        for m=1:sz_mode(1)
            if(sz(modes_to_check(m,1))~=sz(modes_to_check(m,2)))
                continue;
            end
            F = dftmtx(sz(modes_to_check(m,1)));
            omega = tmprod(T,{F,F},[modes_to_check(m,1),modes_to_check(m,2)])/sz(modes_to_check(m,2))^2;
            if isTensorDiagonal(omega)
                %TODO 
                modes = [modes ;[modes_to_check(m,1),modes_to_check(m,2)]];
                ishankel = true;
            else
                ishankel = false;
                modes = [];
                return
            end
        end
        return
    end

    %Assuming order 3
    if(sz(1)==sz(2))
        %Possibility of {1,2} hankel
        F = dftmtx(sz(2));
        omega = tmprod(T,{F,F},[1,2])/sz(2)^2;
        if isTensorDiagonal(omega)
            %TODO 
            modes = [modes ;[1,2]];
            ishankel = true;
        end
    end

    if(sz(2)==sz(3))
        %Possibility of {2,3} hankel
        F = dftmtx(sz(2));
        omega = tmprod(T,{F,F},[2,3])/sz(2)^2;
        if isTensorDiagonal(omega)
            modes = [modes; [2,3]];
            ishankel = true;
        end
    end

    if(sz(1)==sz(3))
        %Possibility of {1,3} hankel
        F = dftmtx(sz(1));
        omega = tmprod(T,{F,F},[1,3])/sz(1)^2;
        if isTensorDiagonal(omega) 
            modes = [modes ;[1,3]];
            ishankel = true;
        end
    end
end