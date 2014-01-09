%plot smoothed data

figure;
    load('smoothed.mat')

    g = plot(beta,smoothed(:,1),'--',beta,smoothed(:,2),beta,smoothed(:,3),0:0.1:10,K/16);
    set(g, 'LineWidth', 2);

    legend( 'p1', 'p2','p = 0');

    xlabel('\beta', 'FontSize', 20);
    ylabel('p', 'FontSize', 20);
    
    axis([0 10 0 1])



    load('smoothed_alpha.mat')

    figure;
    g = plot(beta,smoothed(:,1),'--',beta,smoothed(:,2));
    set(g, 'LineWidth', 2);

    legend( 'p1', 'p2','p = 0');

    xlabel('\beta', 'FontSize', 20);
    ylabel('p', 'FontSize', 20);

     axis([0 10 0 1])