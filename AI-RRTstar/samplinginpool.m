function x_new = samplinginpool(optimizedpath,selectpool,map)

cmin = norm(optimizedpath(selectpool,:)-optimizedpath(selectpool+2,:));
cbest = norm(optimizedpath(selectpool,:)-optimizedpath(selectpool+1,:)) + norm(optimizedpath(selectpool+1,:)-optimizedpath(selectpool+2,:));

if cbest>cmin
    x_center = [(optimizedpath(selectpool,:) + optimizedpath(selectpool+2,:))/2,0];
    x_center = x_center';
    a_1=[(optimizedpath(selectpool+2,1) -optimizedpath(selectpool,1))/cmin;(optimizedpath(selectpool+2,2) - optimizedpath(selectpool,2))/cmin;0];
    id_t=[1,0,0];
    M=a_1*id_t;
    [U,S,Vh]=svd(M);
    C=(U*diag([1,1,det(U)*det(Vh')]))*(Vh);
    r=[cbest/2,sqrt(cbest.^2-cmin.^2)/2,sqrt(cbest.^2-cmin.^2)/2];
    L=diag(r);
    x_new = [0,0];
    while 1
        a=rand();
        b=rand();
        if b<a
            tmp=b;
            b=a;
            a=tmp;
        end
        x_ball=[b*cos(2*pi*a/b);b*sin(2*pi*a/b);0];
        t = C*L*x_ball+x_center;
        x_new=floor([t(1,1),t(2,1)]);
        if feasiblepoint(x_new,map)
            break;
        end
    end
else
    x_new = optimizedpath(selectpool+1,:);
end