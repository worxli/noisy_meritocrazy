%%
%processing

%beta
beta = 0:0.1:10;

% # of agents

%group size
arg.g = 2;

agents = 4:arg.g:12;

%personal payoff
perspays = 1:0.05:2;

mat = [];
figure;
for a = agents

        name = ['task2_20/task2_2-a-' num2str(a) '-rep-10.mat'];
     
        if exist([name], 'file')
            data = load(name);
            
            data = sum(data.datamat)/size(data.datamat,1);
            
            mat = [mat; data];
        else
            disp(name);
        end
    
end

plot(perspays./arg.g, mat);
legend('4 agents', '6 agents', '8 agents', '10 agents', '12 agents');
xlabel('beta');
ylabel('sigma');