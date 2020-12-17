%Run after EE567_project_2a.m w/o clearing workspace
alpha = 7/9;
EbN0_dB = -10:0.5:12;
EbN0 = 10.^(EbN0_dB/10);
N = 8;
sigmasq = 1;
A = sqrt(EbN0*sigmasq*2*(1/N)); 
y = zeros(N,length(EbN0));


count = zeros(1,length(EbN0));
trials = 10000000;

for k = 1:trials
        n_k = randn([1,N]).*sqrt(sigmasq);
    for i = 1:length(EbN0)
        s_k = A(i)+n_k;
        y(1,i) = (1-alpha)*s_k(1);
    
        for j = 2:N
            y(j,i) = (1-alpha)*s_k(j) + alpha*y(j-1,i);
 

        end
        if y(N,i) <= 0
            count(i) = count(i)+1;
        end
    end
end


BER = count/trials;


delete(p1);
p3 = semilogy(EbN0_dB,BER);
hold on;
grid on;
axis tight;
xlabel('Eb/N0 (dB)')
ylabel('Bit Error Rate (BER)')
title(['BER of I&D vs. IIR LPF (N=8) (', num2str(trials),' trials)']);
m3 = "Simulated Bit Error Rate IIR LPF \alpha= "+alpha;
legend([p2;p3],[m2;m3]);
