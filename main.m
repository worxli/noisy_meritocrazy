clear all;

%%
%global vars

%agents
arg.n = 8; 

%budget
arg.budget = 1; 

%group size
arg.g = 4;

%personal payoff
arg.rs = 1.6/arg.g;

%beta vector
beta = 0:0.1:4;
    
probv=[];
proba=[];
K=[];
Ex=[];
M=[];
Ecis=[];
for b = beta;

    arg.b=b;

    %i gives nothing
    arg.n_po = ones(4,1)*arg.budget+arg.rs*[3:-1:0]'*arg.budget;

    %i gives B
    arg.a_po = arg.budget*arg.rs*[4:-1:1]';

    %given distribution

    Eci = [];

    pV=0:arg.n;

    for pI = 1:length(pV)

        arg.full_contr = pV(pI);
        arg.null_contr = arg.n-arg.full_contr;

        P = uniqueperms([ones(arg.full_contr,1)*arg.budget;zeros(arg.null_contr,1)]);

        %calculate order probabilities
        arg.prob = [];
        for i=1:length(P(:,1))

            arg.vec = P(i,:)';
            arg.prob(i,1) = order_prob(arg);

        end


        %calculate order payoffs
        arg.payoff = [];
        for i=1:length(P(:,1))

            arg.vec = P(i,:)';
            arg.payoff(i,:) = order_payoff(arg)*arg.prob(i);

        end

        %add payoffs and remaining budget
        Eci = [Eci; arg.budget + sum(arg.payoff(:,1)), sum(arg.payoff(:,2))];

    end

    NEPNE
    SMNE
    
    proba = [proba; alphamain(arg, b)];
    
end

plot(beta, probv(:,1), beta, probv(:,2), beta, probv(:,3), beta, probv(:,4), beta, K./arg.n, beta, proba(:,1), beta, proba(:,2), beta, proba(:,3), beta, proba(:,4) );
axis([beta(1) beta(end) 0 1]);





    