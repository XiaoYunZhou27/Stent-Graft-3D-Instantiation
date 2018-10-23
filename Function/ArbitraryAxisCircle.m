function [Ver_out] = ArbitraryAxisCircle(Ver_in,Ver_Z,Cur_ver,Cen_old,Nor_new)
%% ArbitraryAxis generates a circle along arbitrary axis at arbitrary position
% INPUT:  Ver_in   original circle centre at [0 0 0]
%         Ver_Z    height of circle
%         Cur_Ver  start point of central line
%         Cen_old  old start point of central line
%         Nor_new  Normal of circle
% OUTPUT: Ver_out  arbitrary axis aligned circle
Sin_theta = (Nor_new(1,1)^2+Nor_new(1,2)^2)^0.5/(Nor_new(1,1)^2+Nor_new(1,2)^2+Nor_new(1,3)^2)^0.5;
Cos_theta = Nor_new(1,3)/(Nor_new(1,1)^2+Nor_new(1,2)^2+Nor_new(1,3)^2)^0.5;
Nor_old = [0 0 -1];
U = cross(Nor_new,Nor_old);
U =U/norm(U);
X = U(1,1);
Y = U(1,2);
Z = U(1,3); 
Mar = [Cos_theta+X^2*(1-Cos_theta)    X*Y*(1-Cos_theta)+Z*Sin_theta   X*Z*(1-Cos_theta)-Y*Sin_theta;...
       X*Y*(1-Cos_theta)-Z*Sin_theta  Cos_theta+Y^2*(1-Cos_theta)     Y*Z*(1-Cos_theta)+X*Sin_theta;...
       X*Z*(1-Cos_theta)+Y*Sin_theta  Y*Z*(1-Cos_theta)-X*Sin_theta   Cos_theta+Z^2*(1-Cos_theta)];
Ver_out = Ver_in*Mar;
Ver_out(:,3) = Ver_out(:,3)+Ver_Z;
for i=1:3
    Ver_out(:,i) = Ver_out(:,i)+Cur_ver(1,i)-Cen_old(1,i);
end
end 