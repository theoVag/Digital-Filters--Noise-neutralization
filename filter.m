n=1000;

v1=sqrt(0.32)*randn(n,1);
v1= v1 -mean(v1);

A = sqrt(0.15)*randn(n,1); A = A - 0;
d= zeros(n,1);
x= zeros(n,1);
u= zeros(n,1);
x(1)=A(1)*sin(pi/8 + pi/6);

d(1)=+v1(1);

for i=2:n
  x(i) =A(i)*sin(i*pi/8 + pi/6);
  d(i) = x(i) + v1(i);
end

u(1)=v1(1);
u(2)=0.25*u(1) + v1(2);

for i=3:n
  u(i) = 0.25*u(i-1) - 0.12*u(i-2) + v1(i);
end
R = [0.3417 0.0762724 -0.0219359;0.0762724 0.3417 0.0762724;-0.0219359 0.0762724 0.3417];
sigma_d=0.395;
p = [0.32;0;0];
Jmin=sigma_d -(p.')*inv(R)*p;
figure(1)
plot([d x u])
legend({'d(n)', 'x(n)', 'u(n)'})

wo = R \ p;

w = [-1; -1;-1];

mu=2;
wt = zeros([3,n]); wt(:,1) = w;
y = zeros(n, 1);

%s = [0; u];
s=u;
for i=3:n
  w = w + mu*(p-R*w); % Adaptation steps
  wt(:,i) = w;
  y(i) = s(i:-1:i-2)' * w; % filter
end

figure(2)
plot([d y])
legend({'d(n)', 'y(n)'})

%% parameter error
figure(3)
we = (wt - wo*ones(1,n)).^2;
e = sqrt(sum(we));

semilogy(e);
xlabel('time step n');
ylabel('Parameter error');
title('Parameter error');

figure(4)
plot([d-y x])
legend({'e', 'x'})