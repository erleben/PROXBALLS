function [lambda, results] = psor(A, b, lambda, params)

N = length(b);
K = params.K;

theta = zeros(K,1);
gamma = 1.4;
r = gamma ./ diag(A);    % Initial r-factors

k = 1;
while k <= K
    
    lambda_old = lambda;
        
    for i=1:N         
        res = A(i,:)*lambda + b(i);
        lambda(i) = max(0, lambda(i) - r(i) * res );
    end
    
    delta = lambda - lambda_old;
    theta(k) = max(abs(delta(i)));
    
    k = k +1; 
end

results = struct(...
    'theta', theta,...
    'r', r...
    );

end
