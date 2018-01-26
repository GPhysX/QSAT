eul0=[0 0 0];
t=[0 1];
w0=[1 2 2];
I = inertia(0.1,0.1,0.34,4);
M = [1,4,9].*1e-8;
[t,w] = ode45(@(t,w) motionODE(t,w,I,M),t,w0);
plot(t,w(:,1));
hold on;
plot(t,w(:,2));
plot(t,w(:,3));
legend('x','y','z');
i=length(w);
dt=t(i)-t(1);
dw=w(i,:)-w(1,:);
da=(0.5*dt.*dw)+dt.*w(i,:);
eul=eul0+w0*dt+(0.5)*da.*dt^2