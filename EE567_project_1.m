n = -2:1:20;
N = 8;
alpha = (N-1)/(N+1);

h_n = zeros(1,length(n));
g_n = zeros(1,length(n));
h2_n = zeros(1,length(n));
g2_n = zeros(1,length(n)); 


for i = 1:length(n)
    if n(i)>=0 && n(i)<N 
        h_n(i) = 1/N;
        g_n(i) = (n(i)+1)/N;
    else
        if n(i)>= N
            g_n(i) = 1;
        end
    end
    if n(i)>=0
        h2_n(i) = (1-alpha)*(alpha^n(i));
        g2_n(i) = 1-(alpha^(n(i)+1));
    end
end



figure;
stem(n,h_n)
axis([-2.25 12 -0.01 0.26])
set(gca, 'YTick', [0 1/16 1/8 3/16 2/8]);
set(gca, 'YTickLabel', {'0' '1/16' '1/8' '3/16' '2/8'});
xticks(n);
xlabel('n')
ylabel('h[n]')
title('I&D Filter Impulse Response h[n] (N=8)')

figure;
stem(n,g_n)
axis([-2.25 12 -0.01 1.1])
yl = 0:1/8:1;
set(gca, 'YTick', yl);
set(gca, 'YTickLabel', {'0' '1/8' '2/8' '3/8' '4/8' '5/8' '6/8' '7/8' '1' });
xticks(n);
xlabel('n')
ylabel('g[n]')
title('I&D Filter Step Response g[n] (N=8)')

figure;
stem(n,h2_n)
axis([-2.25 20.5 -0.01 0.25])
xlabel('n','Interpreter','Latex')
ylabel('$$\hat{h}[n]$$','Interpreter','Latex')
title('IIR Filter Impulse Response $$\hat{h}[n] (\alpha = 7/9)$$ ','Interpreter','Latex')


figure;
stem(n,g2_n)
axis([-2.25 20.5 -0.01 1.1])
xlabel('n','Interpreter','Latex')
ylabel('$$\hat{g}[n]$$','Interpreter','Latex')
title('IIR Filter Step Response $$\hat{g}[n] (\alpha = 7/9)$$','Interpreter','Latex')