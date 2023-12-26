function [x_mid_coord_temp,samplingnode_narrowfound,appendix,narrowmark] = crossbridgetest(map,h,w)

global safedist

narrowmark = 0;

theta = 2*pi*rand;
r = ceil(normrnd(safedist,2));
centerpoint_vice1 = [centerpoint(1,1)+ceil(r*(cos(theta))),centerpoint(1,2)+ceil(r*(sin(theta)))];
centerpoint_vice2 = [centerpoint(1,1)+ceil(r*(-cos(theta))),centerpoint(1,2)+ceil(r*(-sin(theta)))];
centerpoint_devived1 = [centerpoint(1,1)+ceil(r*(sin(theta))),centerpoint(1,2)+ceil(r*(-cos(theta)))];
centerpoint_devived2 = [centerpoint(1,1)+ceil(r*(-sin(theta))),centerpoint(1,2)+ceil(r*(cos(theta)))];


if map(centerpoint(1),centerpoint(2))==1 && centerpoint_vice1(1)>0&& centerpoint_vice1(2)>0&& centerpoint_vice1(1)<h&& centerpoint_vice1(2)<w&&...
        centerpoint_vice2(1)>0&& centerpoint_vice2(2)>0&& centerpoint_vice2(1)<h&& centerpoint_vice2(2)<w&&centerpoint_devived1(1)>0&&...
        centerpoint_devived1(2)>0&& centerpoint_devived1(1)<h&&centerpoint_devived1(2)<w&&centerpoint_devived2(1)>0&& centerpoint_devived2(2)>0&&...
        centerpoint_devived2(1)<h&& centerpoint_devived2(2)<w
    temp1 = map(centerpoint_vice1(1,1),centerpoint_vice1(1,2));
    temp2 = map(centerpoint_vice2(1,1),centerpoint_vice2(1,2));
    temp3 = map(centerpoint_devived1(1,1),centerpoint_devived1(1,2));
    temp4 = map(centerpoint_devived2(1,1),centerpoint_devived2(1,2));
    temp = [temp1,temp2,temp3,temp4];
    if(isequal(temp,[1 1 0 0])||isequal(temp,[0 0 1 1])||isequal(temp,[0 0 0 0]))
        samplingnode_narrowfound = true;
        x_mid_coord_temp = centerpoint;
        if isequal(temp,[1 1 0 0])
            appendix = [centerpoint_vice1;centerpoint_vice2];
        end
        if isequal(temp,[0 0 1 1])
            appendix = [centerpoint_devived1;centerpoint_devived2];
        end
        if isequal(temp,[0 0 0 0])
            appendix = [0];
        end       
    else
%         scatter(centerpoint(2),centerpoint(1))
        samplingnode_narrowfound = false;
        x_mid_coord_temp = centerpoint;
        appendix = centerpoint;

    end
else
    samplingnode_narrowfound = false;
    x_mid_coord_temp = centerpoint;
    appendix = centerpoint;

end

