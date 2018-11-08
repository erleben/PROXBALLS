function [lambda, results] = prox_adaptive_r(A, b, lambda, params)
N = length(b);
K = params.K;

theta = zeros(K,1);
theta_last = inf;
r = 1 ./ diag(A);    % Initial r-factors
k = 1;
while k <= K    
    lambda_old = lambda;    
    for i=1:N
        res = A(i,:)*lambda + b(i);
        z = lambda(i) - r(i) * res;
        lambda(i) = max(0, z );
    end
    delta = lambda - lambda_old;
    theta_cur = delta'*delta;
    dtheta = theta_last - theta_cur;    
    if dtheta < 0
        % divergence, decrease r-factor and rollback iterate
        r = r*0.9;
        lambda = lambda_old;
    else
        % convergence detected
        if dtheta < 0.01
            % convergence is slow, lets try increasing r-factors
            r = r * 1.1;
        end
        % Things are going nice, so we accept the update
        theta(k) = theta_cur;
        theta_last = theta_cur;
        k = k +1;
    end    
end

results = struct(...
    'theta', theta,...
    'r', r...
    );

end
