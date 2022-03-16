function f = gene_control(x,p)
% GENE_CONTROL Describes the gene control model
%   
%   x is a column vector containing the states of the system. In this case,
%   this vector is of dimension two. x(1) contains 'x' and x(2) contains
%   'y'.
% 
%   p is a column vector containing the parameters of the system. In this
%   case, this vector is of dimension one. p(1) contains r.
% 
%   f is a column vector with the same dimension as x. On exit, this
%   contains the derivatives of x describing the system.
%

    alpha1 = 2;
    alpha2 = 2;
    
    f = zeros(2,1);
    
    f(1) = alpha1/(1 + x(2)^p(1)) - x(1);
    f(2) = alpha2/(1 + x(1)^p(1)) - x(2);

end 