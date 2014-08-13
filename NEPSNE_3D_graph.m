%%
%processing

%beta
beta = 0:0.1:10;

% # of agents
agents = 8:4:16;

%group size
arg.g = 4;

%personal payoff
perspays = 1.1:0.05:2;

matH = [];
matL = [];
figure;
for a = agents
    
    BH = [];
    BL = [];
    
    for p = perspays
        
        arg.rs=p/arg.g;

        name = ['task1/task1_4-rate-' num2str(arg.rs) '-a-' num2str(a) '.mat'];
     
        if exist([name], 'file')
            load(name);
            %figure;
            
            b_low = find(data~=0);
            
            if numel(b_low)==0
                b_low = -1;
                b_high = -1;
            else
               b_low = beta(b_low(1)); 
               b_high = find(data==data(end));
               b_high = beta(b_high(1));
            end
            
            BH = [BH;b_high];
            BL = [BL;b_low];
        else
            disp(name);
        end

    end
    
    matH = [matH,BH];
    matL = [matL,BL];
    
end

xx=agents;
yy=perspays./2;
figure;
colormap('gray');
surf(xx,yy,matH,'FaceAlpha',0.3,'EdgeAlpha',0.8);

hold on;
surf(xx,yy,matL,'FaceAlpha',1,'EdgeAlpha',0.3);
xlabel('agents');
ylabel('personal rate of return');
zlabel('\beta');

%hold on;
%mesh(matL-matH);