function mean_activation = Networks_Project_4

% Build algorithm for model
clear figure
% specific network data:
n = 16;

A = [0 1 1 1 -1 -1 -1 0 0 0 -1 -1 0 0 0 0;
    1 0 1 1 -1 0 -1 0 0 0 0 -1 -1 -1 0 0;
    1 1 0 1 0 0 0 0 0 -1 -1 -1 -1 -1 -1 0;
    1 1 1 0 0 0 -1 0 0 -1 -1 -1 0 0 -1 -1;
    -1 -1 0 0 0 1 1 1 1 0 0 0 0 0 0 0;
    -1 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0;
    -1 -1 0 -1 1 0 0 1 1 1 1 0 -1 0 -1 0;
    0 0 0 0 1 0 1 0 1 1 1 1 0 0 1 0;
    0 0 0 0 1 1 1 1 0 1 1 0 0 0 0 -1;
    0 0 -1 -1 0 0 1 1 1 0 1 0 -1 -1 -1 0;
    -1 0 -1 -1 0 0 1 1 1 1 0 0 0 0 0 -1;
    -1 -1 -1 -1 0 0 0 1 0 0 0 0 1 0 0 1;
    0 -1 -1 0 0 0 -1 0 0 -1 0 1 0 1 1 0;
    0 -1 -1 0 0 0 0 0 0 -1 0 0 1 0 1 0;
    0 0 -1 -1 0 0 -1 1 0 -1 0 0 1 1 0 1;
    0 0 0 -1 0 0 0 0 -1 0 -1 1 0 0 1 0];

community1 = [1,2,3,4];
n1 = 4;
community2 = [5,6,7,8,9,10,11];
n2 = 7;
community3 = [12,13,14,15,16];
n3 = 5;

% Algorithm adapted to average long-run simulations:
repeat = 100;

activation_state = zeros(16,repeat);
% insert a 1 in here if made active at time t

activation_time = zeros(16,repeat);
% insert time of activation here


% Time-specification:
tfinal = 500;

% also must specify initial seed network to activate
seed_network = zeros(repeat,1);
for i = 1:repeat
    seed_network(i) = randi(12) + 4;
end

for i = 1: repeat
activation_state(seed_network(i),i)=1;
end

% specify normalising constants:
mu = 0.5 ;
epsilon = 0.1 ;

% now construct probability matrix:

X = zeros(16,16);

for i = 1:4
    for j = 1:4
    X(i,j) = mu;
    end
end

for i = 5:11
    for j = 5:11
    X(i,j) = mu/4;
    end
end

for i = 12:16
    for j = 12:16
    X(i,j) = mu/4;
    end
end

for i = 12:16
    for j = 5:11
        X(i,j) = epsilon/8;
        X(j,i) = epsilon/8;
    end
end


% Note: index each node we trial by z.

for repeatno = 1:repeat
    for t=1:tfinal
    activated_states = [];
    for i = 1:n
    if activation_state(i,repeatno)==1
        activated_states = [activated_states i];
    end
    end
    for i = 1 : length(activated_states)
            z = activated_states(i);
            for zz = 1:n
                if A(z,zz) == 1
                if activation_state(zz,repeatno) == 0
                    if rand < X(z,zz)
                        activation_state(zz,repeatno) = 1;
                        activation_time(zz,repeatno) = t;
                    end
                end
                end
            end
        end
    end
end
activation_time
G = graph(A);
x = [7,8,8,9,4,4,2,6,1.5,0,5,14.5,15,12.5,11.3,11];
y = [7.5,8.5,6.5,7.5,0,4,5,1.7,0.4,1.8,3.5,1.5,4,5,3,1];
figure(1);
graphplot = plot(G,'XData',x,'YData',y);
for i = 1:16
    for j = 1:16
        if A(i,j) == -1
            highlight(graphplot,i,j,'LineStyle','--','EdgeColor','k')
        elseif A(i,j) == 1
            highlight(graphplot,i,j,'EdgeColor','k')
        end
    end
end

community1 = [1,2,3,4];
community2 = [5,6,7,8,9,10,11];
community3 = [12,13,14,15,16];

for i = 1:4
    j = community1(i);
    highlight(graphplot,j,'Marker','o','MarkerSize',12)
end

for i = 1:7
    j = community2(i);
    highlight(graphplot,j,'Marker','s','MarkerSize',12)
end

for i = 1:5
    j = community3(i);
    highlight(graphplot,j,'Marker','^','MarkerSize',12)
end


for i = 1:n
    time = string(activation_time(i));
    s= strcat('t=', time);
    s = cellstr(s);
    labelnode(graphplot,i,s);
end

for i =1:n
        labelnode(graphplot,i,'')
        highlight(graphplot,i,'markersize',20)
end

% text(graphplot.XData(9)-1.2,graphplot.YData(9)-0.5,'Seed','fontsize',18);

A = zeros(4,4);
hold on
xnew = zeros(4,1);
ynew = zeros(4,1);
for i = 1:4
    xnew(i) = x(i);
    ynew(i) = y(i);
end
secondplot = plot(graph(A),'XData',xnew,'YData',ynew);
for i =1:4
    labelnode(secondplot,i,'')
    highlight(secondplot,i,'markersize',20,'nodecolor','k')
end

mean_activation = zeros(16,1);

for j = 1:16
    for i = 1:repeat
        mean_activation(j,1) = mean_activation(j,1) + activation_time(j,i);
    end
end
mean_activation = mean_activation/repeat;

graphplot.NodeCData = mean_activation;
colormap jet
c = colorbar;
w = c.FontSize;
c.FontSize = 18;
xmin = min(x);
xmax = max(x)+0.8;
ymin = min(y);
ymax = max(y);
axis([xmin,xmax,ymin,ymax]);
axis off
end
