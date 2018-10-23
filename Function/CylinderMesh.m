function Out = CylinderMesh(Radius,Height,Ang_int,Hei_int,Twi)
%% CylinderMesh generates a specific cylinder with parameteres
% INPUT:  Radius   radius of cylinder (Height*1 matrix)
%         Height   height of cylinder
%         Ang_int  angle interval of vertices along cross plane
%         Hei_int  height interval of cross planes
%         Twi      twist angle of cylinder
% OUTPUT: Out      if mesh exsits, output mesh
%                  if only vertices, output vertices

% 360 and Ang_int must be divisible 
% Height and Hei_int must be divisible

N_pos = 360/Ang_int;
for i=1:Height/Hei_int
    if i==1
        %vertice coordinate
        for j=1:N_pos
            Theta = (j-1)*2*pi/N_pos+Twi*pi/180;
            Ver((i-1)*N_pos+j,1) = Radius(i*Hei_int,1)*cos(Theta);
            Ver((i-1)*N_pos+j,2) = Radius(i*Hei_int,1)*sin(Theta);
            Ver((i-1)*N_pos+j,3) = (i-1)*Hei_int;
        end
    else
        for j=1:N_pos
            Theta = (j-1)*2*pi/N_pos+Twi*pi/180;
            %vertice coordinates
            Ver((i-1)*N_pos+j,1) = Radius(i*Hei_int,1)*cos(Theta);
            Ver((i-1)*N_pos+j,2) = Radius(i*Hei_int,1)*sin(Theta);
            Ver((i-1)*N_pos+j,3) = (i-1)*Hei_int;
            %face id
            if j==1
                Face((i-2)*2*N_pos+j*2-1,:) = [(i-1)*N_pos+N_pos,(i-2)*N_pos+j,(i-1)*N_pos+j];
                Face((i-2)*2*N_pos+j*2,:) = [(i-2)*N_pos+j,(i-2)*N_pos+j+1,(i-1)*N_pos+j];
            elseif j==N_pos
                Face((i-2)*2*N_pos+j*2-1,:) = [(i-2)*N_pos+j,(i-1)*N_pos+j-1,(i-1)*N_pos+j];
                Face((i-2)*2*N_pos+j*2,:) = [(i-2)*N_pos+j,(i-1)*N_pos+j,(i-2)*N_pos+1];
            else
                Face((i-2)*2*N_pos+j*2-1,:) = [(i-2)*N_pos+j,(i-1)*N_pos+j-1,(i-1)*N_pos+j];
                Face((i-2)*2*N_pos+j*2,:) = [(i-2)*N_pos+j,(i-2)*N_pos+j+1,(i-1)*N_pos+j];
            end
        end
    end
end
if Height==1
    Out = Ver;
else
    Out.ver = Ver;
    Out.face = Face;
end
end