%u,d are preloaded
n=size(u,1);
% autocorrelation R = E[u u']
nCoeff = 3;
a = xcorr(u,u,nCoeff-1,'unbiased');
a = a(nCoeff:(2*nCoeff-1));
R = toeplitz(a);

sigma_v=0.72;
p = [sigma_v;0;0];
wo = R \ p;

T1=[u(1) 0 0;u(2) u(1) 0];
T2(:,1) = u(3:n);
T2(:,2) = u(2:n-1);
T2(:,3) = u(1:n-2);
T=vertcat(T1,T2);
y = T*wo;
sound(d-y,44100)