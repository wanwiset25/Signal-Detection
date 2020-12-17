 EbN0_dB = -10:0.5:12;
 EbN0 = 10.^(EbN0_dB/10);

P_b = qfunc(sqrt(2*EbN0));
N = 8;
sigmasq = 1;
A = sqrt(EbN0*sigmasq*2*(1/N)); 
y = zeros(1,length(EbN0));
count = zeros(1,length(EbN0));
trials = 3000000;

for j = 1:trials
    for i = 1:length(EbN0)
        n_k = randn([1,N]).*sqrt(sigmasq);
        s_k = A(i)+n_k;
        y(i) = (1/N)*(sum(s_k));
        if y(i) <= 0
            count(i) = count(i)+1;
        end
    end
end

BER = count/trials;

figure;
p1 = semilogy(EbN0_dB,P_b);
hold on;
p2 = semilogy(EbN0_dB,BER);


grid on;
axis tight;
xlabel('Eb/N0 (dB)')
ylabel('Bit Error Rate (BER)')
title("Theoretical P_b vs. Simulated BER I&D LPF (N=8)("+trials+" trials)")

m1 = "Theoretical Probability of Error (P_b)";
m2 = "Simulated Bit Error Rate I&D LPF(BER)";
legend([p1;p2],[m1;m2]);





