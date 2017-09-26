function Networks_Project_1

% Full adjacency matrix of our network:

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

G = graph(A);


x = [7,8,8,9,4,4,2,6,1.5,0,5,14.5,15,12.5,11.3,11];
y = [7.5,8.5,6.5,7.5,0,4,5,1.7,0.4,1.8,3.5,1.5,4,5,3,1];
graphplot = plot(G,'XData',x,'YData',y);

for i = 1:16
    for j = 1:16
        if A(i,j) == 1
            highlight(graphplot,i,j,'EdgeColor','g')
        elseif A(i,j) == -1
            highlight(graphplot,i,j,'EdgeColor','r','LineStyle','--')
        end
    end
end

community1 = [1,2,3,4];
community2 = [5,6,7,8,9,10,11];
community3 = [12,13,14,15,16];

for i = 1:4
    j = community1(i);
    highlight(graphplot,j,'Marker','o','MarkerSize',10)
end

for i = 1:7
    j = community2(i);
    highlight(graphplot,j,'Marker','s','MarkerSize',10)
end

for i = 1:5
    j = community3(i);
    highlight(graphplot,j,'Marker','^','MarkerSize',10)
end

% highlight bad edges
highlight(graphplot,8,12,'linewidth',5)
highlight(graphplot,8,15,'linewidth',5)

for i = 1:n
    labelnode(graphplot,i,'')
end



axis off
figure(1)
% PRODUCES GAMANEG DATASET GRAPH



end

