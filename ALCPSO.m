function [xm,fv,curve] = ALCPSO(N,M,lb,ub,D,fitness)
%% N是种群个数
%% M迭代次数
%% D维度
format long;
w=0.9;
%------初始化种群的个体------------
c1max=2;
c1min=0;
c2max=2;
c2min=0;
% for i=1:N
% 
%     for j=1:D
% 
%         x(i,j)=randn;  %随机初始化位置
% 
%         v(i,j)=randn;  %随机初始化速度
% 
%     end
% 
% end
x=initialization(N,D,ub,lb);
v=initialization(N,D,ub,lb);







%------先计算各个粒子的适应度，并初始化Pi和Pg----------------------

for i=1:N

    p(i)=fitness(x(i,:));

    y(i,:)=x(i,:);

end

pg = x(N,:);             %Pg为全局最优

for i=1:(N-1)

    if fitness(x(i,:))<fitness(pg)

        pg=x(i,:);

    end

end

%------进入主要循环，按照公式依次迭代------------

for t=1:M

    c1 = c1max - (c1max - c1min)*t/M;
    
    c2 = c2max - (c2max - c2min)*t/M;
    
    for i=1:N

        v(i,:)=w*v(i,:)+c1*rand*(y(i,:)-x(i,:))+c2*rand*(pg-x(i,:));

        x(i,:)=x(i,:)+v(i,:);

        if fitness(x(i,:))<p(i)

            p(i)=fitness(x(i,:));

            y(i,:)=x(i,:);

        end

        if p(i)<fitness(pg)

            pg=y(i,:);

        end

    end

    Pbest(t)=fitness(pg);
end
xm = pg;
fv = fitness(pg);
curve=Pbest;



