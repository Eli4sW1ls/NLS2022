function f  = ex2_system( x, p )
% EX2_SYSTEM Describes a simplified equilibrium equation
%   
%   x is a column vector containing the states of the system. In this case,
%   this vector is of dimension one.
% 
%   p is a column vector containing the parameters of the system. In this
%   case, this vector is of dimension two, p(1) contains r and p(2)
%   contains h.
% 
%   f is a column vector with the same dimension as x. On exit, this
%   contains the derivatives of x describing the system.
%

    f = -1/3*x^3 + p(1)*x + p(2);

end

