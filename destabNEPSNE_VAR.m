%%
%contribution to destabilize NEPSNE

% # of agents
arg.n = 16;

%group size
arg.g = 4;

%personal payoff
arg.rs = 1.6/arg.g;

%beta value, set to inf
arg.b = 10^3;

varianz = 0:1;

data = [];

for v = varianz
    
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
    
    dest = arg.n-sum(arg.vector)-count;

    data = [data,dest-1];
    
    
end

%plot(beta,data);

save(['destabNEPSNE' '.mat']);