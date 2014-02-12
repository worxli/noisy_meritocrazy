%%
%contribution to destabilize FRNE

% # of agents
arg.n = 16;

%group size
arg.g = 4;

%personal payoff
arg.rs = 1.6/arg.g;

%initially everybody gives nothing
arg.vector = zeros(arg.n,1);

%beta value
beta = 0:0.1:10;

data = [];

for b = beta
    
    arg.vector = zeros(arg.n,1);
    
    arg.b = b;
    giving = sum(arg.vector);
    paygiving = 0;
    paynotgiving = 1;
    
    while(paygiving<paynotgiving)        
        
        payoff = vectorPayoff(arg);
        paynotgiving = 1 + payoff(1,1);
        
        ind = find(arg.vector==0);
        if length(ind)~=0
            arg.vector(ind(1,1))=1;
        else
            disp('everyone is contributing');
            break;
        end
        
        payoff = vectorPayoff(arg);
        paygiving = payoff(1,2);
        
    end
    
    if sum(arg.vector)~=arg.n
        dest = sum(arg.vector);
    else
        dest = -1;
    end
    
    data = [data,dest-1];
    
    
end

%plot(beta,data);

save(['destabFRNE' '.mat']);