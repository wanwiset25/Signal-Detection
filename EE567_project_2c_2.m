
alpha = 7/9;
alpha2 = 0.999;
EbN0_dB = -10:0.5:12;
EbN0 = 10.^(EbN0_dB/10);
N = 8;
sigmasq = 1;
A = sqrt(EbN0*sigmasq*2*(1/N)); 
y = zeros(N,length(EbN0));
y2 = zeros(N,length(EbN0));

count = zeros(1,length(EbN0));
count2 = zeros(1,length(EbN0));
trials = 10000000;

for k = 1:trials
        n_k = randn([1,N]).*sqrt(sigmasq);
    for i = 1:length(EbN0)
        s_k = A(i)+n_k;
        y(1,i) = (1-alpha)*s_k(1);
        y2(1,i) = (1-alpha2)*s_k(1);
        for j = 2:N
            y(j,i) = (1-alpha)*s_k(j) + alpha*y(j-1,i);
            y2(j,i) = (1-alpha2)*s_k(j) + alpha2*y2(j-1,i);

        end
        if y(N,i) <= 0
            count(i) = count(i)+1;
        end
        if y2(N,i) <= 0
            count2(i) = count2(i)+1;
        end
    end
end


BER = count/trials;
BER2 = count2/trials;


p3 = semilogy(EbN0_dB,BER);
hold on;
p4 = semilogy(EbN0_dB,BER2);
grid on;
axis tight;
xlabel('Eb/N0 (dB)')
ylabel('Bit Error Rate (BER)')
title(['IIR LPF \alpha = 7/9 vs. \alpha = 0.999 (', num2str(trials),' trials)']);
m3 = "Simulated Bit Error Rate IIR LPF \alpha= "+alpha;
m4 = "Simulated Bit Error Rate IIR LPF \alpha= "+alpha2;
legend([p3;p4],[m3;m4]);





