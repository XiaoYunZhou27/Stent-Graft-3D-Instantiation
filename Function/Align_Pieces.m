function [Piece_tran,Cen_tran,XXc] = Align_Pieces(Piece_tran,Cen_tran,XXc,Error_pro,Gap)

[~,Inx] = sort(Error_pro);
Inx = Inx(1,1);
for i=1:size(Error_pro,2)
    if Inx+i<size(Error_pro,2)+1
        Inx_min = Inx+i-1;
        Inx_max = Inx+i;
        
        Nor_min = Cen_tran(:,2*Inx_min-1)-Cen_tran(:,2*Inx_min);
        Nor_min = Nor_min/norm(Nor_min);
        Nor_max = Cen_tran(:,2*Inx_max-1)-Cen_tran(:,2*Inx_max);
        Nor_max = Nor_min/norm(Nor_max);
        Nor = (Nor_min+Nor_max)/2;
        
        Motion = Cen_tran(:,2*Inx_min)-Gap(Inx_min,1)*Nor-Cen_tran(:,2*Inx_max-1);
        Piece_tran(Inx_max).ver = Piece_tran(Inx_max).ver+repmat(Motion,1,size(Piece_tran(Inx_max).ver,2));
        Cen_tran(:,2*Inx_max-1:2*Inx_max) = Cen_tran(:,2*Inx_max-1:2*Inx_max)+repmat(Motion,1,size(Cen_tran(:,2*Inx_min-1:2*Inx_min),2));
        XXc(:,5*Inx_max-4:5*Inx_max) = XXc(:,5*Inx_max-4:5*Inx_max)+repmat(Motion,1,size(XXc(:,5*Inx_max-4:5*Inx_max),2));
    end
end
   
for i=0:size(Error_pro,2)
    if Inx-i>1
        Inx_min = Inx-i-1;
        Inx_max = Inx-i;
        
        Nor_min = Cen_tran(:,2*Inx_min-1)-Cen_tran(:,2*Inx_min);
        Nor_min = Nor_min/norm(Nor_min);
        Nor_max = Cen_tran(:,2*Inx_max-1)-Cen_tran(:,2*Inx_max);
        Nor_max = Nor_min/norm(Nor_max);
        Nor = (Nor_min+Nor_max)/2;
        
        Motion = Cen_tran(:,2*Inx_max-1)+Gap(Inx_min,1)*Nor-Cen_tran(:,2*Inx_min);
        Piece_tran(Inx_min).ver = Piece_tran(Inx_min).ver+repmat(Motion,1,size(Piece_tran(Inx_min).ver,2));
        Cen_tran(:,2*Inx_min-1:2*Inx_min) = Cen_tran(:,2*Inx_min-1:2*Inx_min)+repmat(Motion,1,size(Cen_tran(:,2*Inx_min-1:2*Inx_min),2));
        XXc(:,5*Inx_min-4:5*Inx_min) = XXc(:,5*Inx_min-4:5*Inx_min)+repmat(Motion,1,size(XXc(:,5*Inx_min-4:5*Inx_min),2));
    end
end

end