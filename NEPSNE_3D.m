%%
%contribution to destabilize NEPSNE

% # of agents
agents = 4:2:16;

%group size
arg.g = 2;

%group payoff
perspays = 1:0.05:2;

%beta value
beta = 0:0.1:10;

for a = agents

    arg.n = a;
    
    for p = perspays
        
        %half of group payoff
        arg.rs = p/arg.g;
        data = [];
        
        for b = beta

            arg.b = b;
            
            %initial vector
            arg.vector = ones(arg.n,1);

            %prepare phase
            prephase = true;

            paygiving = 0;
            paynotgiving = 1;
            count=0;

            while(paygiving>paynotgiving)||prephase

                payoff = vectorPayoff(arg);
                paygiving = payoff(1,2);

                ind = find(arg.vector==1);
                if length(ind)~=0
                    arg.vector(ind(1,1))=0;
                else
                    disp('no one is contributing');
                    if prephase == true
                        arg.vector = arg.n-1;
                    end
                    break;
                end

                payoff = vectorPayoff(arg);
                paynotgiving = 1 + payoff(1,1);

                if paygiving>paynotgiving
                    prephase = false;
                end

                if prephase==true
                    count=count+1;
                end

            end

            if prephase==true
                count = 0;
            end

            dest = arg.n-sum(arg.vector);

            data = [data,dest-1];


        end
        
        save(['task1/task1-rate-' num2str(arg.rs) '-a-' num2str(arg.n) '.mat'], 'data');
        
    end
    
end

%plot(beta,data);

%save(['destabNEPSNE' '.mat']);