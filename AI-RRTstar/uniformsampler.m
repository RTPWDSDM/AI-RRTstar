function [x_rand] = uniformsampler(h,w,x_goal,k0)


if rand < k0
    x_rand = rand(1,2).*[h,w];
else
    x_rand = x_goal.coord;
end
