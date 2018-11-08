function [lambda, results] = solve_lcp(A, b, lambda, lcp_solver_method, params)

if nargin<4 
    lcp_solver_method = 'psor';
end

if strcmp(lcp_solver_method,'pgs')
    [lambda, results] = pgs(A,b,lambda, params);
elseif strcmp(lcp_solver_method,'psor')
    [lambda, results] = psor(A,b,lambda, params);
elseif strcmp(lcp_solver_method,'prox_adaptive_r')
    [lambda, results] = prox_adaptive_r(A,b,lambda, params);
elseif strcmp(lcp_solver_method,'prox_anderson_acceleration')
    [lambda, results] = prox_anderson_acceleration(A,b,lambda, params);
else
    error(['solve_lcp: unknown method = ' lcp_solver_method])
end

end
