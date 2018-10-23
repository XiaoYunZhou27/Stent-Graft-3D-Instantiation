function Face_out = FaceConnection(Ver_inx_sta_1,Ver_inx_sta_2)
%% FaceConnection connect point rings by triangulation
%INPUT: Ver_inx_sta_1  start index of first ring '0'
%       Ver_inx_sta_2  start index of second ring '360'
%OUTPUT: Face_out      triangulation connections
N_pos = 360;
for i=1:N_pos
    i1 = 2*i-1;
    i2 = 2*i;
    if i==1
        Face_out(i1,:) = [Ver_inx_sta_2+N_pos  Ver_inx_sta_1+i   Ver_inx_sta_2+i];
        Face_out(i2,:) = [Ver_inx_sta_1+i      Ver_inx_sta_1+i+1 Ver_inx_sta_2+i];
    elseif i==N_pos
        Face_out(i1,:) = [Ver_inx_sta_2  Ver_inx_sta_2+N_pos-1  Ver_inx_sta_2+N_pos];
        Face_out(i2,:) = [Ver_inx_sta_2  Ver_inx_sta_2+N_pos    Ver_inx_sta_1+1];
    else
        Face_out(i1,:) = [Ver_inx_sta_1+i  Ver_inx_sta_2+i-1    Ver_inx_sta_2+i];
        Face_out(i2,:) = [Ver_inx_sta_1+i  Ver_inx_sta_1+i+1  Ver_inx_sta_2+i ];
    end
end
end