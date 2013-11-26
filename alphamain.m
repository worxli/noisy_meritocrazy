function [ proba ] = alphamain( arg, be )

    %beta vector
    beta = [0,100];

    EA=[];
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

        SMNE_alpha
        EA = [EA,E];

    end

	a = 1-1/(1+be)
   
    ex1 = a*EA(:,1)+(1-a)*EA(:,3);
    ex2 = a*EA(:,2)+(1-a)*EA(:,4);
    
    diff = abs(ex1-ex2);
    [mindist1,minInd1] = min(diff);
    diff(minInd1)=1;
    [mindist2,minInd2] = min(diff);

    mprob=zeros(1,4);

    if minInd2<minInd1
        t = minInd2;
        minInd2 = minInd1;
        minInd1 = t;
        t = mindist2;
        mindist2 = mindist1;
        mindist1 = t;
    end

    if mindist1 < 0.01
        mprob(1,1:2) = [mindist1, qA(minInd1)];
    else
        mprob(1,1) = mindist1;
    end

    if mindist2 < 0.01
        mprob(1,3:4)=[mindist2, qA(minInd2)];
    else
        mprob(1,3) = mindist2;
    end

    proba = mprob;
    
end

