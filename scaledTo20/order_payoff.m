function [ payoff] = order_payoff(arg)
    
    mat = reshape(arg.vec, arg.g, arg.n/arg.g)';
    payoff = [0,0];
    
    for i=1:arg.n/arg.g
        
        %group contribution
        group_contr = sum(mat(i,:));
        
        %payoff for each individual in the group
        group_pay_ind = arg.rs*group_contr;
        
        %number of agents which gave everything in group
        full_elem = nnz(mat(i,:));
        
        payoff = payoff + [(arg.g-full_elem)*group_pay_ind, full_elem*group_pay_ind];
        
    end
    
    %number of agents which gave everything in ordering
    full_elem = nnz(mat);
    
    payoff = payoff./[arg.n-full_elem, full_elem];
    
end