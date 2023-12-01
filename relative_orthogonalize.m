function v1_oth = relative_orthogonalize(v1,v2)
%UNTITLED2 Summary of this function goes here
%   Orthogonalizes v1 wrt to v2
if(size(v1)~=size(v2))
    error("relative_orthogonalize:, vectors not of the same size")
end
v1_oth = v1 - dot(v1,v2)*v2/(norm(v2)^2);
end