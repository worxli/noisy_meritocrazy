%%
% NEPSNE and FRNE

% # of agents
arg.n = 16;
agents = [12,16];

%group size
arg.g = 2;
groups = [4];

%personal payoff


%beta value
beta = 0:0.1:10;

data = [];

%%
%NEPSNE

for n = agents
    
    arg.n = n;
    
for g = groups
    
    arg.g = g;
    
    if arg.g == 2 
        rate = [(arg.n-arg.g+1)/(arg.n*arg.g-arg.g*arg.g+1)+0.01,1.6/arg.g,1-0.01];
    else
        rate = [0.8];
    end
    
for rs = rate
    
    arg.rs = rs;

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
    
    dest = arg.n-sum(arg.vector)-count;

    data = [data,dest-1];
     
end

NEPSNE = data;

%%
%FRNE

data = [];

for b = beta
    
    %initially everybody gives nothing
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

FRNE = data;

save(['destabNEPSNE_FRNE-' num2str(arg.n) '-' num2str(arg.g) '-' num2str(rs) '.mat']);

end

end

end