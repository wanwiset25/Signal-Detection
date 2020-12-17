alpha =  0.98:0.0001:1-0.0001;
EbN0_dB = 7;
EbN0 = 10.^(EbN0_dB/10);
N = 8;
sigmasq = 1;
A = sqrt(EbN0*sigmasq*2*(1/N)); 
y = zeros(1,N);
count = zeros(1,length(alpha));
trials = 10000000;

for k = 1:trials
        n_k = randn([1,N]).*sqrt(sigmasq);
        s_k = A+n_k;
    for i = 1:length(alpha)
        y(1) = (1-alpha(i))*s_k(1);
        for j = 2:N
            y(j) = (1-alpha(i))*s_k(j) + alpha(i)*y(j-1);
        end
        if y(N) <= 0
            count(i) = count(i)+1;
        end
    end
end


BER = count/trials;

plot(alpha,BER);
grid on;
axis tight;
xlabel('\alpha')
ylabel('Bit Error Rate (BER)')
title(['BER vs. \alpha (EbN0 = ',num2str(EbN0_dB),' dB)(', num2str(trials) ,' trials)'])


