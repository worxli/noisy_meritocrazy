function [ payoff ] = vectorPayoff( arg )

    %all permuatations achievable with current agents givings
    permutations = uniqueperms(arg.vector);
    
    %iterate over permutations
    for i=1:length(permutations(:,1))

        %take current permutation
        curr_vec = permutations(i,:)';
       
        %calculate division factor
        p = factorial(sum(arg.vector))*factorial(arg.n-sum(arg.vector));
    
        %calculate probability to get ranked for each place
        for j=1:arg.n
            sum_j = exp(arg.b*curr_vec(j:end));
            p = p*exp(arg.b*curr_vec(j))/sum(sum_j);
        end
        arg.prob(i,1) = p;

    end
    
    for i=1:length(permutations(:,1))
        
    	%take current permutation
        arg.vec = permutations(i,:)';
        
        %calculate order payoff and multiply with order probability
        arg.payoff(i,:) = order_payoff(arg)*arg.prob(i);

    end

    payoff = sum(arg.payoff,1);

end

