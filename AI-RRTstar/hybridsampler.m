function [x_rand] = hybridsampler(h,w,pathfound,k1,k2,k3,x_start,x_goal,cbest,narrownode,treeclass,nodeclass_p)


% samplingnode_narrowfound = false;
if ~pathfound
    if rand > k1
        %         while ~samplingnode_narrowfound
        %             [x_rand,samplingnode_narrowfound,~,narrowmark] = crossbridgetest(map,h,w,narrownode);
        %         end
        for i = 1:length(narrownode)
            if nodeclass_p(i) == treeclass
                x_rand = narrownode(i,:);
            end
        end
    else
        if rand > 0.5 %half goal-bias half start biased
            [x_rand] = uniformsampler(h,w,x_goal,k3);
        else
            [x_rand] = uniformsampler(h,w,x_start,k3);
        end
    end
end
if pathfound
    if rand < k2
        %         while ~samplingnode_narrowfound
        %             [x_rand,samplingnode_narrowfound,~,narrowmark] = crossbridgetest(map,h,w,narrownode);
        %         end
        for i = 1:length(narrownode)
            if nodeclass_p(i) == treeclass
                x_rand = narrownode(i,:);
            end
        end
    else
        [x_rand] = informedsampler(x_goal,x_start,h,w,cbest);
        
    end
end


