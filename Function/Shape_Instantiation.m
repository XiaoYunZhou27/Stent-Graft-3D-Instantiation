function [XXc,Rota,Tran,Error] = Shape_Instantiation(XXf,xxp)
error_min = [10;10];
for i=1:size(XXf,2)
    for j=size(XXf,2)
        if j~=i
            [R T]= RPnP_deform(XXf,xxp,i,j);
            XXc_tmp = R*XXf+repmat(T,1,size(XXf,2));
            xxc = [XXc_tmp(1,:)./XXc_tmp(3,:); XXc_tmp(2,:)./XXc_tmp(3,:)];
            error = sum(abs(xxc-xxp),2);
            if error(1,1)<error_min(1,1)&&error(2,1)<error_min(2,1)
                error_min = error;
                XXc =  XXc_tmp;
                Error = sum(error);
                Rota = R;
                Tran = T;
            end
        end
    end
end
end