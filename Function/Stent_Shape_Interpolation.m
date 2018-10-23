function [Stent_Graft_Sha] = Stent_Shape_Interpolation(Stent_Graft_Model_Piece_tran,Stent_Graft_Model_Cen_tran,Height,Gap,Radius,N_POS,N_LOOP)

Stent_Graft_Sha.ver = Stent_Graft_Model_Piece_tran(N_LOOP).ver;
Stent_Graft_Sha.face = Stent_Graft_Model_Piece_tran(N_LOOP).face;
for i=N_LOOP-1:-1:1
    i_inv = N_LOOP-i;
    if Gap(i,1) == 1
        Ver_inx_sta_1 = size(Stent_Graft_Sha.ver,1)-N_POS;
        Ver_inx_sta_2 = size(Stent_Graft_Sha.ver,1);
        Face_out = FaceConnection(Ver_inx_sta_1,Ver_inx_sta_2);
        Stent_Graft_Sha.face = cat(1,Stent_Graft_Sha.face,Face_out);
        
        Stent_Graft_Model_Piece_tran(i).face = Stent_Graft_Model_Piece_tran(i).face+size(Stent_Graft_Sha.ver,1);
        Stent_Graft_Sha.face = cat(1,Stent_Graft_Sha.face,Stent_Graft_Model_Piece_tran(i).face);
        Stent_Graft_Sha.ver = cat(1,Stent_Graft_Sha.ver,Stent_Graft_Model_Piece_tran(i).ver);
    else
        for j=1:Gap(i,1)-1
            Tall = sum(Height(1:2*i_inv-1),1);
            Ver_in = CylinderMesh(Radius(Tall+j,1),1,1,1,0);
            Cur_ver = Stent_Graft_Model_Cen_tran(2*i+1,:)+(Stent_Graft_Model_Cen_tran(2*i,:)-Stent_Graft_Model_Cen_tran(2*i+1,:))*j/Gap(i,1);
            Nor_new_1 = Stent_Graft_Model_Cen_tran(2*i-1,:)-Stent_Graft_Model_Cen_tran(2*i,:);
            Nor_new_1 = Nor_new_1/norm(Nor_new_1);
            Nor_new_2 = Stent_Graft_Model_Cen_tran(2*i+1,:)-Stent_Graft_Model_Cen_tran(2*i+2,:);
            Nor_new_2 = Nor_new_1/norm(Nor_new_2);
            Nor_new = Nor_new_2+(Nor_new_1+Nor_new_2)*j/Gap(i,1);
            
            Ver_out = ArbitraryAxisCircle(Ver_in,Tall,Cur_ver,[0 0 Tall],Nor_new);
            
            Tmp = size(Stent_Graft_Sha.ver,1);
            Tmp = Tmp-N_POS+1;
            Inx = knnsearch(Ver_out,Stent_Graft_Sha.ver(Tmp,:));
            
            Ver_out_tmp(1:N_POS-Inx+1,:) = Ver_out(Inx:N_POS,:);
            Ver_out_tmp(N_POS-Inx+1:N_POS,:) = Ver_out(1:Inx,:);
            
            Stent_Graft_Sha.ver = cat(1,Stent_Graft_Sha.ver,Ver_out_tmp);

            Ver_inx_sta_1 = size(Stent_Graft_Sha.ver,1)-2*N_POS;
            Ver_inx_sta_2 = size(Stent_Graft_Sha.ver,1)-N_POS;
            Face_out = FaceConnection(Ver_inx_sta_1,Ver_inx_sta_2);
            Stent_Graft_Sha.face = cat(1,Stent_Graft_Sha.face,Face_out);
        end
        Ver_inx_sta_1 = size(Stent_Graft_Sha.ver,1)-N_POS;
        Ver_inx_sta_2 = size(Stent_Graft_Sha.ver,1);
        Face_out = FaceConnection(Ver_inx_sta_1,Ver_inx_sta_2);
        Stent_Graft_Sha.face = cat(1,Stent_Graft_Sha.face,Face_out);
        
        Stent_Graft_Model_Piece_tran(i).face = Stent_Graft_Model_Piece_tran(i).face+size(Stent_Graft_Sha.ver,1);
        Stent_Graft_Sha.face = cat(1,Stent_Graft_Sha.face,Stent_Graft_Model_Piece_tran(i).face);
        Stent_Graft_Sha.ver = cat(1,Stent_Graft_Sha.ver,Stent_Graft_Model_Piece_tran(i).ver);
    end    
end

end

