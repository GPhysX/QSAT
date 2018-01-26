syms w1(t) w2(t) w3(t)
IT = inertia(0.3,0.1,0.1,4);
I=eig(IT);
M = [1,0,0];

ode1 = diff(w1) == (M(1)-(I(3)-I(2))*w2*w3)/I(1);
ode2 = diff(w2) == (M(2)-(I(1)-I(3))*w3*w1)/I(2);
ode3 = diff(w3) == (M(3)-(I(2)-I(1))*w1*w2)/I(3);

odes=[ode1;ode2;ode3];
cond1 = w1(0) == 0;
cond2 = w2(0) == 0;
cond3 = w3(0) == 0;
conds = [cond1; cond2; cond3];
[w1Sol(t),w2Sol(t),w3Sol(t)] = dsolve(odes,conds);
%Plot
fplot(w1Sol);
hold on;
fplot(w2Sol);
fplot(w3Sol);
legend('w1','w2','w3');