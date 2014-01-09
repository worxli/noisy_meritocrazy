function [ k ] = alphaNEPNE( arg, be, betaend )

   %beta vector
    beta = [0,100];

    EC=[];
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
        
        EC = [EC,Eci];

    end

	a = 1-be/betaend;
    
    %%%%%%%%%%%%%%%%%%%%%%
    
    clear('Eci');
    Eci(:,1)=a*EC(:,1)+(1-a)*EC(:,3);
    Eci(:,2)=a*EC(:,2)+(1-a)*EC(:,4);
    
    NEPNE;
    
    
end