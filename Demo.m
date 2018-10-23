close all; clear; clc;

N_LOOP = 5;% number of stent loops
N_MARK = 5;% number of markers on each stent loop
N_POS = 360;
N_TOTA = N_LOOP*N_MARK;

load('./Data/Gap.mat');
load('./Data/Radius.mat');
load('./Data/Height.mat');
load('./Data/Stent_Graft_Model_Cen.mat');
load('./Data/Stent_Graft_Model_Piece.mat');

addpath('./Function/');

%% Data normalization
Stent_Graft_Model_Piece_tran = Stent_Graft_Model_Piece;
for j=1:N_LOOP
    Stent_Graft_Model_Piece_tran(j).ver =[Stent_Graft_Model_Piece(j).ver(:,1),Stent_Graft_Model_Piece(j).ver(:,3),Stent_Graft_Model_Piece(j).ver(:,2)+720];
    Stent_Graft_Model_Piece_tran(j).ver = Stent_Graft_Model_Piece_tran(j).ver'/1195;
end
Stent_Graft_Model_Cen_tran =[Stent_Graft_Model_Cen(:,1) Stent_Graft_Model_Cen(:,3) Stent_Graft_Model_Cen(:,2)+720];
Stent_Graft_Model_Cen_tran = Stent_Graft_Model_Cen_tran'/1195;

%% 2D projection
load('./Data/Marker_Position_2D.mat');
xxp = -Marker_Position_2D*0.8+repmat(204.8,N_LOOP*N_MARK,2);

%% 3D marker position
load('./Data/Marker_Position_3D.mat');
XXf = [Marker_Position_3D(:,1) Marker_Position_3D(:,3) Marker_Position_3D(:,2)+720];

XXf = XXf'/1195;
xxp = xxp'/1195;
XXc = [];

%% RPnP
for j=1:N_LOOP
    XXf_tmp = XXf(:,5*j-4:5*j);
    xxp_tmp = xxp(:,5*j-4:5*j);
    
    [XXc(:,5*j-4:5*j),Rota_loop(:,:,j),Tran_loop(:,j),Error_pro(:,j)] = Shape_Instantiation(XXf_tmp,xxp_tmp);
    
    Stent_Graft_Model_Piece_tran(j).ver = (Rota_loop(:,:,j)*Stent_Graft_Model_Piece_tran(j).ver+repmat(Tran_loop(:,j),1,size(Stent_Graft_Model_Piece_tran(j).ver,2)))*1195;
    Stent_Graft_Model_Cen_tran(:,2*j-1:2*j) = (Rota_loop(:,:,j)*Stent_Graft_Model_Cen_tran(:,2*j-1:2*j)+repmat(Tran_loop(:,j),1,size(Stent_Graft_Model_Cen_tran(:,2*j-1:2*j),2)))*1195;
end
XXc = XXc*1195;

[Stent_Graft_Model_Piece_tran,Stent_Graft_Model_Cen_tran,XXc] = Align_Pieces(Stent_Graft_Model_Piece_tran,Stent_Graft_Model_Cen_tran,XXc,Error_pro,Gap);
%% Back to world coordinates
for j=1:N_LOOP
    Stent_Graft_Model_Piece_tran(j).ver = [Stent_Graft_Model_Piece_tran(j).ver(1,:); Stent_Graft_Model_Piece_tran(j).ver(3,:)-720; Stent_Graft_Model_Piece_tran(j).ver(2,:)];
    Stent_Graft_Model_Piece_tran(j).ver = Stent_Graft_Model_Piece_tran(j).ver';
end
Stent_Graft_Model_Cen_tran = [Stent_Graft_Model_Cen_tran(1,:); Stent_Graft_Model_Cen_tran(3,:)-720; Stent_Graft_Model_Cen_tran(2,:)];
Stent_Graft_Model_Cen_tran = Stent_Graft_Model_Cen_tran';
XXc = [XXc(1,:); XXc(3,:)-720; XXc(2,:)];
XXc = XXc';

%% Shape Interpolation
Stent_Graft_Sha = Stent_Shape_Interpolation(Stent_Graft_Model_Piece_tran,Stent_Graft_Model_Cen_tran,Height,Gap,Radius,N_POS,N_LOOP);

%% Result Plot
figure;
subplot(1,2,1);
load('./Data/Image.mat');
imshow(Image);hold on;
plot(Marker_Position_2D(:,1),Marker_Position_2D(:,2),'w.','MarkerSize',10);
hold off;

subplot(1,2,2);
patch('Faces',Stent_Graft_Sha.face,'Vertices',Stent_Graft_Sha.ver,'FaceColor',[0.4 0.4 0.4],'FaceAlpha',1.0,'EdgeColor',[0.5 0.5 0.5],'EdgeAlpha',0);
axis equal; axis off; view([0, 0]);