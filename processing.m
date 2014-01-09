%%
%processing

%beta
beta = 0:0.1:10;

%runs
runs = 50;

data = [];
for b = beta
    
    giving = [];
    for run=1:runs

        name = ['simdata/beta-' num2str(b) '-run' num2str(run) '.mat'];
     
        if exist([name], 'file')
            arg = load(name);
            giving = [giving;sum(arg.giving)/arg.maxiter];
        else
            disp(name);
            giving = [giving;0];
        end

    end
    
    data = [data,giving];
    
end

boxplot(data,beta);

%{

plot(giving);
axis([0 maxiter 0 arg.n])
xlabel('time');
ylabel('# of players making full contribution');
legend(['\beta: ' num2str(arg.b)]); 
title(['players: ' num2str(arg.n) ', groupsize: ' num2str(arg.g) ', \epsilon: ' num2str(arg.e)]);

%}







