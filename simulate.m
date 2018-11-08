function [config, dt, results] = simulate(config, info, dt, params)

%--- Extract data foom structures -- for readability only
X  = config.X;
Y  = config.Y;
Vx = config.Vx;
Vy = config.Vy;
Fx = config.Fx;
Fy = config.Fy;
w  = config.W;

%--- Filter proximity info to only contain relevant contact information
idx = info.D <= 0.01;
O   = info.O(  idx==1,:);
Nx  = info.Nx( idx==1,:);
Ny  = info.Ny( idx==1,:);
D   = info.D(  idx==1,:);

%--- Setup contact force problem

C      = length(D);   % Number of contacts
B      = length(w);   % Number of bodies
J      = zeros( C, B*2 );
lambda = zeros( C, 1 );
if( C>0)
  for c=1:C
      a = O(c,1);
      b = O(c,2);
      J(c,a)   =  Nx(c);
      J(c,b)   = -Nx(c);
      J(c,a+B) = Ny(c);
      J(c,b+B) = -Ny(c);
  end  
  u = [Vx; Vy];
  W = diag( [w; w] );
  A = J*W*J';
  b = J*u + dt*J*W*[Fx; Fy];
  [lambda, results] = solve_lcp(A,b,lambda, config.lcp_solver_method, params);
end

%--- Compute the resulting contact forces in body-space
Fc = J'*lambda;
Cx = -Fc(1:B);
Cy = -Fc(B+1:end);

%--- Velocity update
Vx = Vx - w.*Cx + dt* w.*Fx;
Vy = Vy - w.*Cy + dt* w.*Fy;

%--- Position update
X = X + dt*Vx;
Y = Y + dt*Vy;

%--- Store new values in config object
config.X  = X;
config.Y  = Y;
config.Vx = Vx;
config.Vy = Vy;

end
