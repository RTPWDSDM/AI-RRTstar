function [x_mid,x_midfound,appendix] = generatenodenarrow(map,h,w,num_samplingnode_narrow_attempt,num_samplingnode_narrow_max,x_midfound,narrownode)

samplingnode_narrowfound = false;
while (num_samplingnode_narrow_attempt<num_samplingnode_narrow_max)
    [x_mid_coord_temp,samplingnode_narrowfound,appendix] = crossbridgetest(map,h,w,narrownode);
    if samplingnode_narrowfound

        x_mid.coord = x_mid_coord_temp;
        x_mid.cost = 0;
        x_mid.parent = 0;
        x_mid.narrow = 1;
        x_midfound = true;
        break;
    end
    num_samplingnode_narrow_attempt = num_samplingnode_narrow_attempt + 1;
    x_midfound = false;
end
