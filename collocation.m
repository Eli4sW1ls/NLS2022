function [x,T] = collocation(f, x0, T_est, ntst, ncoll)
%COLLOCATION This function searches for a closed orbit using collocation
%
% f     describes the system of ODE's as a function of t and x
%
% x0    describes a point close to the closed orbit
%
% T_est describes an estimate of the period
%
% ntst  describes the number of intervals for collocation
%
% ncoll describes the number of collocation points per interval
%
%   Copyright: Thijs Steel & Henri De Plaen, KU LEUVEN
%   Date: March 2021

% Construct the time vector, includes both the mesh and t
n = ntst*ncoll;
t = linspace(0, 1, n+1);
t = t(1:end-1);

[~,x] = ode15s(f, t*T_est, x0);

du0 = zeros(2,size(x,1));
for i = 1:size(x,1)
    % Get the initial derivatives for phase condition
    du0(:,i) = f( T_est*t(i), x(i,:).' );
end

u = [reshape(x.',[2*size(x,1),1]);T_est];
options = optimset('Display','off');
[u,~] = fsolve(@(u2) collocation_res(u2), u,options);
x = reshape( u(1:2*n), [2,n] ).';
T = u(2*n+1);

%% INTERNAL FUNCTIONS

    function [x] = gausspoints(degree)
        %GAUSSPOINTS This function determines the roots of the Legendre polynomial
        %            on the interval[-1, 1]
        %
        % degree     degree of the legendre polynomial
        ii   = 1:degree-1;
        temp   = ii./sqrt(4*ii.^2-1);
        companionmatrix  = diag(temp,1) + diag(temp,-1);
        e   = eig(companionmatrix);
        x = sort(e)';
    end

    function [y,dy] = evaluatelagrange(x,pointx,pointy)
        ndim = size(pointy,1);
        npoints = size(pointx,2);
        L = ones(npoints,length(x));
        D = zeros(npoints,length(x));
        for ii=1:npoints
            for iii=1:npoints
                if (ii~=iii)
                    L(ii,:)=L(ii,:).*(x-pointx(iii))./(pointx(ii)-pointx(iii));
                    D(ii,:)=D(ii,:) + 1./(x-pointx(iii));
                end
            end
        end
        y=zeros(ndim,length(x));
        dy=zeros(ndim,length(x));
        for ii=1:npoints
            y=y+pointy(:,ii).*L(ii,:);
            dy=dy+pointy(:,ii).*L(ii,:).*D(ii,:);
        end
    end

    function res = collocation_res(u)
        gp = gausspoints(ncoll);
        res = zeros(size(u));
        u_coll = reshape(u(1:2*n),[2,n]);
        T2 = u(2*n+1);
        % Collocation equations
        for ii = 1:ntst-1
            jj = (ii-1)*ncoll + (1:ncoll+1);
            a = t((ii-1)*ncoll + 1);
            b = t(ii*ncoll + 1);
            gp2 = (b-a)/2.*gp + (a+b)/2;
            
            for jjj=1:ncoll
                [y,dy_approx] = evaluatelagrange( gp2(jjj), t(jj), u_coll(:,jj) );
                dy = T2*f( T2*gp2(jjj), y );
                res( (ii-1)*2*(ncoll)+(jjj-1)*2+(1:2) ) = dy_approx - dy;
            end
            
        end
        % Final collocation equation (wraps around)
        jj = (ntst-1)*ncoll + (1:ncoll);
        a = t((ntst-1)*ncoll + 1);
        b = 1;
        gp2 = (b-a)/2.*gp + (a+b)/2;
        for jjj=1:ncoll
            [y,dy_approx] = evaluatelagrange( gp2(jjj), [t(jj),1], [u_coll(:,jj),u_coll(:,1)] );
            dy = T2*f( T2*gp2(jjj), y );
            res( (ntst-1)*2*(ncoll)+(jjj-1)*2+(1:2) ) = dy_approx - dy;
        end
        
        % Phase condition
        for ii = 1:size(u_coll,2)
            res(2*n+1) = res(2*n+1) + u_coll(:,ii).'*du0(:,ii);
        end
        res(2*n+1) = res(2*n+1);
    end

end