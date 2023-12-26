function [clustercenter,clusterclass,nodeclass] = meanshift(h,w,map,narrownode)
global radiusclass
if ~isempty(narrownode)
    img = map;
    B=img;
    bw=ones(h,w);
    
    p1 = narrownode(:,1);%find the obstacles or samples,return coordinates
    p2 = narrownode(:,2);
    data=[p1,p2];
    nodeclass = zeros(length(p1),1);
%     figure
%     subplot(2,1,1)
%     
%     
%     imshow(img)
%     hold on
%     plot(p1,p2,'*');
%     axis on
    
    %mean shift 算法
    [m,n]=size(data);
    index=1:m;
    radiusclass=50;
    D_min =radiusclass*0.85;  % 最小合并距离
    
    %stopthresh=1e-3*radiusclass;
    
    stopthresh=5;
    
    visitflag=zeros(m,1);%标记是否被访问
    count=[];
    clusterclass=0;
    tempclass = 1;
    clustercenter=[];
    
%     hold on;
    while ~isempty(index)
        cn=ceil((length(index)-1e-6)*rand);%随机选择一个未被标记的点，作为圆心，进行均值漂移迭代
        center=data(index(cn),:); % 圆心坐标
        this_class=zeros(m,1);%统计漂移过程中，每个点的访问频率
        
        %% 对一个点进行移动 直至无法移动
        % 步骤2、3、4、5
        while 1
            %计算球半径内的点集
            dis=sum((repmat(center,m,1)-data).^2,2);
            radius2=radiusclass*radiusclass;
            innerS=find(dis<radiusclass*radiusclass);
            visitflag(innerS)=1;%在均值漂移过程中，记录已经被访问过得点
            nodeclass(innerS)= tempclass;
            this_class(innerS)=this_class(innerS)+1; % 已访问次数加一
            %根据漂移公式，计算新的圆心位置
            newcenter=zeros(1,2);
            % newcenter= mean(data(innerS,:),1);
            sumweight=0;
            for i=1:length(innerS)
                w0=exp(dis(innerS(i))/(radiusclass*radiusclass));
                sumweight=w0+sumweight;
                newcenter=newcenter+w0*data(innerS(i),:);
            end
            newcenter=newcenter./sumweight;
            if norm(newcenter-center) <stopthresh%计算漂移距离，如果漂移距离小于阈值，那么停止漂移
                break;
            end
            center=newcenter;
%             plot(center(2),center(1),'*y');
            % pause
        end
        
        %% 步骤6 判断是否需要合并，如果不需要则增加聚类个数1个
        % 依次计算新的聚类点与其他点的距离
        mergewith=0;
        for i=1:clusterclass
            betw=norm(center-clustercenter(i,:));
            if betw<D_min
                mergewith=i;
                break;
            end
        end
        
        if mergewith==0           %不需要合并
            clusterclass=clusterclass+1;
            tempclass = tempclass+1;
            clustercenter(clusterclass,:)=center;
            count(:,clusterclass)=this_class;
        else                      %合并
            clustercenter(mergewith,:)=0.5*(clustercenter(mergewith,:)+center);
            count(:,mergewith)=count(:,mergewith)+this_class;
            nodeclass(innerS)=mergewith;
        end
        
        %重新统计未被访问过的点
        index=find(visitflag==0);
    end%结束所有数据点访问
    
%     clusterclass
    
%     %% 画聚类点
%     cVec = 'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';
%     for k = 1:clusterclass
%         plot(clustercenter(k,1),clustercenter(k,2),'o','MarkerEdgeColor','k','MarkerFaceColor',cVec(k), 'MarkerSize',10)
%     end
%     
%     %% 绘制分类结果
%     for i=1:m
%         [value index]=max(count(i,:));
%         Idx(i)=index;
%     end
%     % % pause
%     % figure(2);
%     %
%     subplot(2,1,2)
%     hold on;
%     imshow(map);
%     for i = 1:clusterclass
%         p = find(Idx == i);
%         p1 = data(p,1);
%         p2 = data(p,2);
%         
%         RES{i} = [min(p1),max(p1),min(p2),max(p2)];
%         
%         plot(p2,p1,'*','MarkerEdgeColor',cVec(i),'MarkerFaceColor',cVec(i))
%         plot(clustercenter(i,2),clustercenter(i,1),'o','MarkerEdgeColor','m','MarkerFaceColor',cVec(k), 'MarkerSize',10)
%         %    pause
%     end
%     
%     
%     
% %     figure
% %     
% %     for i = 1:length(RES)
% %         rule=RES{i};
% %         if (isempty(rule))
% %             continue;
% %         end
% %         
% %         im=B(rule(3):rule(4),rule(1):rule(2));
% %         
% %         imshow(im)
% %         
% %         %scoreInductance(im)
% %         
%     end
else
    clustercenter = 0;
    clusterclass = 0;
    nodeclass = 0;
end
    
    
    
