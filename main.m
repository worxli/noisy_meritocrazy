clear all;

%%
%global vars

%agents
arg.n = 16; 

%budget
arg.budget = 1; 

%group size
arg.g = 4;

%personal payoff
arg.rs = 1.6/arg.g;

%beta vector
beta = 0:0.1:10;
    
probv=[];
proba=[];
K=[];
KK=[];
EM = [];

for b = beta;

    arg.b=b

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
    
    SMNE
    %proba = [proba; alphamain(arg, b, beta(end))];
    
    
    %NEPNE
    %K = [K;k];
    %KK = [KK,alphaNEPNE(arg, b, beta(end))];
    
end

%{
%plot(beta, probv(:,1), beta, probv(:,2), beta, probv(:,3), beta, probv(:,4), beta, K./arg.n, beta, proba(:,1), beta, proba(:,2), beta, proba(:,3), beta, proba(:,4) );
%plot( beta,  proba(:,2), beta, proba(:,4), beta, KK/arg.n);
plot( beta, probv(:,2), beta, probv(:,4) );
%plot(beta, K);
axis([beta(1) beta(end) 0 1]);
xlabel('\beta');
ylabel('Efficiency');

legend('alpha1', 'alpha2', 'alpha K', 'logit \beta 1', 'logit \beta 2', 'logit \beta K'); 

%}

%{
qA = 0:0.01:1;
mesh(beta,qA,EM(:,1:2:end),'EdgeColor','Black')
hold on;
mesh(beta,qA,EM(:,2:2:end),'EdgeColor','Black')
alpha(.8)
xlabel('\beta');
ylabel('Probability');
zlabel('Expected value');

%}

save(['mainDATA.mat']);

    