function [narrownode1,narrownode2]=narrownodedetect(map,safedist)

% able to extract the passages whose width are smaller or equal to
% safedist(robot)
% narrownode1--good
% narrownode2--bad


lambda1=1;
lambda2=1;
narrownode1 = [];
safedist1=ceil(lambda1*safedist)+1;
h = size(map,1);
w = size(map,2);

b = [];
for i = 1:w
    for j = 1:safedist1
        b(j,i) = 0;
    end
end
b = [b;map(1:end-safedist1,:)];
c = map + b;
c0 = c;
c = mat2gray(c);

d = [];
for i = 1:w
    for j = 1:safedist1
        d(j,i) = 0;
    end
end
d = [map(safedist1+1:end,:);d];
e = map + d;
e0 = e;

e = mat2gray(e);

f = [];
for i = 1:h
    for j = 1:safedist1
        f(i,j) = 0;
    end
end
f = [f map(:,1:end-safedist1)];
g = map + f;
g0 = g;

g = mat2gray(g);

k = [];
for i = 1:h
    for j = 1:safedist1
        k(i,j) = 0;
    end
end
k = [map(:,safedist1+1:end) k];
l = map + k;
l0 = l;

l = mat2gray(l);



t = b + d + f +k;
t0 = b + d + f + k;
B = t0(:);
n = length(unique(B));
t = mat2gray(t);


for i = 1:size(map,1)
    for j = 1:size(map,2)
        if map(i,j)
            if (b(i,j)+d(i,j)==2&&f(i,j)+k(i,j)==0)||(b(i,j)+d(i,j)==0&&f(i,j)+k(i,j)==2)
                
                narrownode1 = [narrownode1;i,j];
            end
        end
    end
end


safedist2 = ceil(lambda2*safedist)-1;
narrownode2 = [];
h = size(map,1);
w = size(map,2);

b = [];
for i = 1:w
    for j = 1:safedist2
        b(j,i) = 0;
    end
end

b = [b;map(1:end-safedist2,:)];
c = map + b;
c0 = c;
c = mat2gray(c);

d = [];
for i = 1:w
    for j = 1:safedist2
        d(j,i) = 0;
    end
end
d = [map(safedist2+1:end,:);d];
e = map + d;
e0 = e;

e = mat2gray(e);

f = [];
for i = 1:h
    for j = 1:safedist2
        f(i,j) = 0;
    end
end
f = [f map(:,1:end-safedist2)];
g = map + f;
g0 = g;

g = mat2gray(g);

k = [];
for i = 1:h
    for j = 1:safedist2
        k(i,j) = 0;
    end
end
k = [map(:,safedist2+1:end) k];
l = map + k;
l0 = l;

l = mat2gray(l);



t = b + d + f +k;
t0 = b + d + f + k;
B = t0(:);
n = length(unique(B));
t = mat2gray(t);


for i = 1:size(map,1)
    for j = 1:size(map,2)
        if map(i,j)
            if (b(i,j)+d(i,j)==2&&f(i,j)+k(i,j)==0)||(b(i,j)+d(i,j)==0&&f(i,j)+k(i,j)==2)
                narrownode2 = [narrownode2;i,j];
            end
        end
    end
end



