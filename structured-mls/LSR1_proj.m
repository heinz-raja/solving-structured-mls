function x = LSR1_proj(T,b)
%   [x] = LSR1_proj(T,b) where T is a tensor of
%   order 3 and b is the right-hand side in the equation:
%      T.2x.3x = b
%   
% 
%   Authors: Heinz Doss         (h.doss@student.maastrichtuniversity.nl)
%            Martijn Bousse     (m.bousse@maastrichtuniversity.nl)
%
% Version History:
% - 2023/11/15   HD      Initial implementation
    
    %input check
    %Assuming order 3
    sz = size(T);
    if(size(sz)<3)
        error('LSR1_proj:T','not a tensor')
    end
    if(sz(2)~=sz(3))
        error('LSR1_proj:T','2nd and third modes must be equal')
    end
    if(sz(1)<(sz(2)*2))
        error('LSR1_proj:T','3rd mode must be greater than 2*1st mode')
    end
    if(sz(1)~=size(b,1))
        error('LSR1_proj:T','dimensions of b and T do not match')
    end
    A = tens2mat(T,1);            
    V = orth(A(:,sz(2)+1:end));
    A_tilde = (eye(size(V,1))-V*V')*A;
    A_tilde = A_tilde(:,1:sz(2));
    x_tilde = A_tilde\b;
    x = x_tilde;
end