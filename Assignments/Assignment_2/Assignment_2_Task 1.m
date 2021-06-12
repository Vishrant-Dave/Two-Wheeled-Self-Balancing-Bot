
% Variables

mc = 1.5; mp = 0.5; g = 9.82; L = 1; d1 = 0.01; d2 = 0.01;

% Defining A and B matrix

a32 = (g*mp)/mc; a33 = -(d1/mc); a34 = -(d2/(L*mc));
a42 = (g*(mc+mp))/(L*mc); a43 = -d1/(L*mc); a44 = -((d2*(mc+mp))/(L*L*mc*mp));
B = [0; 0; 1/mc; 1/(L*mc)];
A = [0 0 1 0; 0 0 0 1; 0 a32 a33 a34; 0 a42 a43 a44];
clear a32 a33 a34 a42 a43 a44;
clear mc mp g L d1 d2;

% If q1(x) and q2(theta) both are output
%C = [1 0 0 0; 0 1 0 0]; D = [0; 0];
% But here, only q2(theta) is the output
C = [0 1 0 0]; D = 0;

sys = ss(A,B,C,D);

%Pole values
pole_sys = pole(sys);
positive_pole = pole_sys(pole_sys >0);
if(~isempty(positive_pole))
    fprintf('There is a positive pole, therefore not stable');
end
clear positive_pole;

%Eigen Values 
eig_values = eig(A);

%Observable and Controllable Syntaxes
obs = rank(obsv(sys));
ctr = rank(ctrb(sys));

%Zero Pole Map
pzmap(sys);

%Transfer Function

sys_tf = tf(sys);
[a, b] = ss2tf(A,B,C,D);

%end%