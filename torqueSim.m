function [M] = torqueSim(B,angle)
%TORQUESIM Takes rotation matrix and position to return torque in body fixed frame
global msat p Bs Hc Vhyst uhyst %Import global constants
global oldH
u0=(4*pi)*1e-7; %permittivity of free space
DCM=rotate3(angle);
B=B*DCM; %rotate magnetic field vector to sat coordinate system
H=B/u0; %magnetic flux density body-fixed reference frame

%Creates lag effect produced by magnetic hsyteresis. Based on Flatley and
%Henretty. If dH/dt < 0, +Hc used, if dH/dt > 0, -Hc used.
a=double(H<oldH); %setup logoical comparator
a(a==0)=-1; %transorm to -1 for false
%hysteresis loop model, rhombus shaped hysteresis loop
Bhyst=(2/pi)*Bs*atan(p*(H+a.*Hc));
mhyst=((Bhyst*Vhyst)/u0).*uhyst; %unit vector attributes rod placement
m=mhyst+msat; %combine the magnetic moments
M=cross(m,B);
oldH = H(3); %store previous external H, used for dH/dt
end

