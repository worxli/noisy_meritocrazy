%%
%simulation

% # of agents
arg.n = 16;

%group size
arg.g = 4;

%personal payoff
arg.rs = 1.6/arg.g;

%initially everybody gives nothing
arg.vector = zeros(arg.n,1);

%beta value
beta = 2.3:0.1:10;

%epsilon
arg.e = 0.01; %[0.01:0.02,0.05];

for b = beta
    
    arg.b = b;
    arg.vector = zeros(arg.n,1);

    %random seed for brutus
    seed=cputime*1000;
    s = RandStream('mt19937ar','Seed',seed);
    RandStream.setGlobalStream(s);

    giving = [];
    for loop=1:maxiter

        %choose random agent
        arg.agent = randi(arg.n,1);

        %calculate expected payoff when staying, expected payoff when changing
        %and how changed vector would look like
        [ex_curr_pay, ex_cha_payoff, best, nbest] = calcPayoff(arg);

        if rand(1)<(1-arg.e)
            arg.vector = best;
        else
            arg.vector = nbest;
        end

        giving = [giving;sum(arg.vector)];

    end
    
    jobindex=str2double(getenv('LSB_JOBINDEX'));

    save(['beta-' num2str(b) '-run' num2str(jobindex) '.mat']);
    
end

%{

plot(giving);
axis([0 maxiter 0 arg.n])
xlabel('time');
ylabel('# of players making full contribution');
legend(['\beta: ' num2str(arg.b)]); 
title(['players: ' num2str(arg.n) ', groupsize: ' num2str(arg.g) ', \epsilon: ' num2str(arg.e)]);

%}







