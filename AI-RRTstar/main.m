%% Self-adaptive Informed RRT*
% Author: Huang Yuan
% Time: 2022/06/13












%% preparation
clear all
close all


global stepsize threshhold_tree threshhold_rewire
global idx121 idx122 idx131 idx133 idx212 idx211 idx232 idx233 idx313 idx311 idx323 idx322
global link12 link13 link23 nolink linktype
global cost_pre13 cost_now13 cost_pre23 cost_now23 cost_pre12 cost_now12 sum_type1 sum_type2
global safedist radiusclass k0 k1 k2 k3 cbest cbestdraw
global drawxnew

global display x_start x_goal clusterclass_up_add d
d=0;
display = true;
cc2_sum=0;
cc1_sum=0;
bb1_sum=0;
bb2_sum=0;
drawxnew=[];
%% load the map
maporder=2;
map = imread(['simulation',num2str(maporder),'.png']);
map = im2bw(map);
% map = ones(600,600);
% fix the map [h,w]
h = 600;
w = 600;
map = imresize(map,[h,w]);









global times_max
success_temp=[];
times_max=1;
fail_attempt = 0;

switch maporder
    case 1
        for i = 188:328
            for j = 229:230
                map(i,j)=1;
            end
        end
        for i = 188:328
            for j=359:361
                map(i,j)=1;
            end
        end
        for i=188:328
            j=508:509;
            map(i,j)=1;
        end
        %% initialization
        % RRT. narrow--in narrow passage
        % RRT. mark -- in ellipse
        % x_start.coord = [300 284];
        % x_start.coord = [580 580];
        x_start.coord=[500,100];
        x_start.cost = 0;
        x_start.parent = 0;
        x_start.narrow = 0;
        
        x_goal.coord = [28 562];
        x_goal.cost = 0;
        x_goal.parent = 0;
        x_goal.narrow = 0;
        k0 = 0.5; % [uniform] random vs goal-bias
        k1 = 0.8; % [hybird] crossbridgetest vs random (pathfound=0)
        k2 = 0.2; % [hybrid] crossbridgetest vs informed (pathfound=1)
        k3 = 0.8; % [hybrid] random sampling vs goal-biased
        stepsize = 10;
        threshhold_tree = 30;
        threshhold_rewire = 150;
        
        safedist = 40;% the minimum passable width for robot 15 25 40
        radiusclass = 30;
    case 2
        x_start.coord=[550,50];
        x_start.cost = 0;
        x_start.parent = 0;
        x_start.narrow = 0;
        
        x_goal.coord = [270 500];
        x_goal.cost = 0;
        x_goal.parent = 0;
        x_goal.narrow = 0;
        k0 = 0.5; % [uniform] random vs goal-bias
        k1 = 0.8; % [hybird] crossbridgetest vs random (pathfound=0)
        k2 = 0.2; % [hybrid] crossbridgetest vs informed (pathfound=1)
        k3 = 0.8; % [hybrid] random sampling vs goal-biased
        stepsize = 15;
        threshhold_tree = 30;
        threshhold_rewire = 50;
        
        safedist = 13;% the minimum passable width for robot
        radiusclass = 30;
    case 3
        x_start.coord=[580,100];
        x_start.cost = 0;
        x_start.parent = 0;
        x_start.narrow = 0;
        
        x_goal.coord = [200 120];
        x_goal.cost = 0;
        x_goal.parent = 0;
        x_goal.narrow = 0;
        k0 = 0.5; % [uniform] random vs goal-bias
        k1 = 0.8; % [hybird] crossbridgetest vs random (pathfound=0)
        k2 = 0.2; % [hybrid] crossbridgetest vs informed (pathfound=1)
        k3 = 0.8; % [hybrid] random sampling vs goal-biased
        stepsize = 15;
        threshhold_tree = 30;
        threshhold_rewire = 150;
        
        safedist = 9;% the minimum passable width for robot
        radiusclass = 30;
    case 4
        for i = 188:328
            for j = 229:230
                map(i,j)=1;
            end
        end
        for i = 188:328
            for j=359:361
                map(i,j)=1;
            end
        end
        for i=188:328
            j=508:509;
            map(i,j)=1;
        end
        %% initialization
        % RRT. narrow--in narrow passage
        % RRT. mark -- in ellipse
        % x_start.coord = [300 284];
        % x_start.coord = [580 580];
        x_start.coord=[500,60];
        x_start.cost = 0;
        x_start.parent = 0;
        x_start.narrow = 0;
        
        x_goal.coord = [50 60];
        x_goal.cost = 0;
        x_goal.parent = 0;
        x_goal.narrow = 0;
        k0 = 0.8; % [uniform] random vs goal-bias
        k1 = 0.8; % [hybird] crossbridgetest vs random (pathfound=0)
        k2 = 0.2; % [hybrid] crossbridgetest vs informed (pathfound=1)
        k3 = 0.8; % [hybrid] random sampling vs goal-biased
        stepsize = 10;
        threshhold_tree = 30;
        threshhold_rewire = 150;
        
        safedist = 25;% the minimum passable width for robot 15 25 40
        radiusclass = 30;
    case 5 
           x_start.coord=[500,60];
        x_start.cost = 0;
        x_start.parent = 0;
        x_start.narrow = 0;
        
        x_goal.coord = [500 500];
        x_goal.cost = 0;
        x_goal.parent = 0;
        x_goal.narrow = 0;
        k0 = 0.8; % [uniform] random vs goal-bias
        k1 = 0.8; % [hybird] crossbridgetest vs random (pathfound=0)
        k2 = 0.2; % [hybrid] crossbridgetest vs informed (pathfound=1)
        k3 = 0.8; % [hybrid] random sampling vs goal-biased
        stepsize = 10;
        threshhold_tree = 30;
        threshhold_rewire = 150;
        
        safedist = 0;% the minimum passable width for robot 15 25 40
        radiusclass = 30;
end
map0=map;

if display
    figure(1)
    %     subplot(321)
    imshow(map0);
    hold on
    box on
    axis on
    
end
%%
for times=1:times_max
    
    
    
    
    if display
        scatter(x_start.coord(2),x_start.coord(1),'p','filled','r');
        hold on;
        scatter(x_goal.coord(2),x_goal.coord(1),'s','filled','g');
        hold on;
        title('load map')
    end
    %parameters of rrt
    
    
    
    
    
    RRTree1 = x_start;
    RRTree2 = x_goal;
    
    
    
    %linktype type1--T1,T3,T2 type2--T1,T2
    
    idx121 = 0;
    idx122 = 0;
    idx131 = 0;
    idx133 = 0;
    idx212 = 0;
    idx211 = 0;
    idx232 = 0;
    idx233 = 0;
    idx313 = 0;
    idx311 = 0;
    idx323 = 0;
    idx322 = 0;
    
    link13 = 0;
    link23 = 0;
    link12 = 0;
    nolink = 0;
    
    cost_pre13 = inf;
    cost_now13 = 0;
    cost_pre23 = inf;
    cost_now23 = 0;
    cost_pre12 = inf;
    cost_now12 = 0;
    linktype = 0;
    sum_type1 = inf;
    sum_type2 = inf;
    
    
    cbest = inf;
    cbestdraw = inf;
    
    
    
    
    %% generate x_mid by cross-bridge test
    tic
    x_midfound = false;
    num_samplingnode_narrow_attempt = 1;
    num_samplingnode_narrow_max = 20000;
    if safedist>0
    [narrownode1,narrownode2] = narrownodedetect(map,safedist); 
    [narrownode,searchmethod] = decidesearchmethod(narrownode1,narrownode2,safedist);
    [clustercenter_p,clusterclass_p,nodeclass_p] = meanshift(h,w,map,narrownode); % passable cluster
    [clustercenter_up,clusterclass_up,nodeclass_up] = meanshift(h,w,map,narrownode2); % unpassable cluster
    map=mapupdate(map,narrownode2);
    clusterclass_up_add=0;
    for i=1:clusterclass_p
        for j=1:clusterclass_up
            if distancecost(clustercenter_p(i,:),clustercenter_up(j,:))<2*safedist
                clusterclass_up_add = [clusterclass_up_add;i];
                for p=1:length(nodeclass_up)
                    if nodeclass_up(p)==j
                        map(narrownode2(p,1),narrownode2(p,2))=1;
                    end
                end
            end
        end
    end
    
    %     imshow(map)
    if display
        Vc='bgrcmyk';
        if clusterclass_p~=0
            figure;imshow(map0);hold on;title("passable passage")
            for i=1:length(narrownode)
                for j=1:clusterclass_p
                    if nodeclass_p(i)==j
                        scatter(narrownode(i,2),narrownode(i,1),'MarkerEdgeColor','none','MarkerFaceColor',Vc(j));
                        hold on
                        break
                    end
                    
                end
            end
        end
        %         if clusterclass_up~=0
        %                  figure;imshow(map0);hold on;title("unpassable passage")
        %             for i=1:length(narrownode2)
        %                 for j=1:clusterclass_up
        %                     if nodeclass_up(i)==j
        %                         scatter(narrownode2(i,2),narrownode2(i,1),'MarkerEdgeColor','none','MarkerFaceColor',Vc(j));
        %                         hold on
        %                         break
        %                     end
        %
        %                 end
        %             end
        %         end
    end
    else
        clustercenter_p=0;
        clusterclass_p=0;
        clustercenter_up=0;
        clusterclass_up=0;
        searchmethod=0;
    end
    if ~searchmethod
        [initialpath,RRTree1,RRTree2] = Birrt(x_goal,x_start,map,h,w,RRTree1,RRTree2,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up);
    else
        [initialpath,RRTree1,RRTree2,RRTree3] = Triplerrt(x_goal,x_start,map,h,w,RRTree1,RRTree2,clustercenter_p,clusterclass_p,clustercenter_up,clusterclass_up,narrownode,nodeclass_p);
    end
    cc1=toc;
    
    cc1_sum = cc1+cc1_sum;
    bb1_sum = cbest+bb1_sum;
    dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Initialpathcost.txt'],cbest,'-append','precision','%.2f');
    dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Initialpathtime.txt'],cc1,'-append','precision','%.4f');
    if times==times_max
        cc1_ave = cc1_sum/times_max;
        bb1_ave = bb1_sum/times_max;
        dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Initialpathcost_Ave.txt'],bb1_ave,'precision','%.2f');
        dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Initialpathtime_Ave.txt'],cc1_ave,'precision','%.4f');
    end
    %% draw initial path
    if display
        figure
        imshow(map0);
        hold on
        temp = [];
        
        for i = 1: length(initialpath)-1
            scatter(initialpath(i,2),initialpath(i,1),'filled','g');hold on;
            temp = [temp;line([initialpath(i,2),initialpath(i+1,2)],[initialpath(i,1),initialpath(i+1,1)], 'Color', 'c', 'LineWidth', 1)];hold on;
        end
        scatter(initialpath(end,2),initialpath(end,1),'filled','g');hold on;
    end
    %% optimise
    
    [optimizedpath,cbestdraw] = optimization(initialpath,map);
    cc2=toc;
    cc2_sum = cc2+cc2_sum;
    bb2_sum = cbest+bb2_sum;
    dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Finalpathcost.txt'],cbest,'-append','precision','%.2f');
    dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Finalpathtime.txt'],cc2,'-append','precision','%.4f');
    if times==times_max
        cc2_ave = cc2_sum/times_max;
        bb2_ave = bb2_sum/times_max;
        dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Finalpathcost_Ave.txt'],bb2_ave,'precision','%.2f');
        dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_Finalpathtime_Ave.txt'],cc2_ave,'precision','%.4f');
    end
    %% draw convergence curve
    if display
        figure
        imshow(map0);hold on
        for i = 1: length(optimizedpath)-1
            scatter(optimizedpath(i,2),optimizedpath(i,1),'filled','g');hold on;
            temp = [temp;line([optimizedpath(i,2),optimizedpath(i+1,2)],[optimizedpath(i,1),optimizedpath(i+1,1)], 'Color', 'b', 'LineWidth', 2)];
        end
        scatter(optimizedpath(end,2),optimizedpath(end,1),'filled','g');hold on;
        figure;plot(cbestdraw)
    end
    save(['Simulation',num2str(maporder),'_SIRRTstar_',num2str(times),'.mat']);
    img=figure(4);
    %     imshow(map0);hold on
    temp=[];
    for i = 1: length(optimizedpath)-1
        scatter(optimizedpath(i,2),optimizedpath(i,1),'filled','g');hold on;
        temp = [temp;line([optimizedpath(i,2),optimizedpath(i+1,2)],[optimizedpath(i,1),optimizedpath(i+1,1)], 'Color', 'b', 'LineWidth', 2)];
    end
    scatter(optimizedpath(end,2),optimizedpath(end,1),'filled','g');hold on;
    %         prompt = 'success or failure?:';
    %         x=input(prompt);
    %
    %         if x==1
    %             success_temp = [success_temp;1];
    %
    %         else
    %             success_temp = [success_temp;0];
    %             fail_attempt = fail_attempt+1;
    %         end
    %          saveas(gcf,['Simulation1_SIRRTstar_',num2str(times),'.png'],[600]]);
    savefig(img,['Simulation',num2str(maporder),'_SIRRTstar_Result',num2str(times)]);
    close all
    dlmwrite(['Simulation',num2str(maporder),'_SIRRTstar_convergencecurve.csv'],cbestdraw,'-append','precision','%.2f');
end

save(['Simulation',num2str(maporder),'_SIRRTstar_SuccessRate.txt'],'success_temp','-ASCII');

%% draw sampling pool encourage curve
figure
imshow(map0);
hold on
temp = [];

for i = 1: length(initialpath)-1
    scatter(initialpath(i,2),initialpath(i,1),'filled','g');hold on;
    temp = [temp;line([initialpath(i,2),initialpath(i+1,2)],[initialpath(i,1),initialpath(i+1,1)], 'Color', 'c', 'LineWidth', 1)];hold on;
end
scatter(initialpath(end,2),initialpath(end,1),'filled','g');hold on;
temp=[];
for i = 1: length(optimizedpath)-1
    scatter(optimizedpath(i,2),optimizedpath(i,1),'filled','g');hold on;
    temp = [temp;line([optimizedpath(i,2),optimizedpath(i+1,2)],[optimizedpath(i,1),optimizedpath(i+1,1)], 'Color', 'b', 'LineWidth', 2)];
end
scatter(optimizedpath(end,2),optimizedpath(end,1),'filled','g');hold on;



figure;
for i=1:size(d,2)
    plot(d(:,i),'LineWidth',1.5);hold on;
end
    yyaxis right;plot(cbestdraw(length(cbestdraw)-length(d)+1:end),'b');
