function [ p ] = order_prob(arg)
    
    p = factorial(arg.full_contr)*factorial(arg.null_contr);
    
    for j=1:arg.n
        sum_j = exp(arg.b*arg.vec(j:end));
        p = p*exp(arg.b*arg.vec(j))/sum(sum_j);
    end
    
end