SNR_dB = 0:0.5:15;
SNR = 10.^(SNR_dB/10);
sigmasq = 1;
A = sqrt(SNR.*2*sigmasq);
phi = 0;
Pfa = 10^-4;
T0 = 4.41;
N=16;
trials = 10000000;
signal = zeros(1,length(SNR));
nosignal = zeros(1,length(SNR));
zT = zeros(1,N);
zT2 = zeros(1,N);

for k = 1:trials
    n1 = randn(N,length(SNR)).*sqrt(sigmasq);
    n2 = randn(N,length(SNR)).*sqrt(sigmasq);
    for i = 1:length(SNR)
        for j = 1:N
            r1T = A(i)*cos(phi)+n1(j,i);
            r2T = A(i)*sin(phi)+n2(j,i);
            zT(j) = (1/N)*(r1T.^2+r2T.^2);
            zT2(j) = (1/N)*((n1(j,i).^2+n2(j,i).^2));
        end
        if  sum(zT) > T0
             signal(i) = signal(i) + 1;
        end
        if  sum(zT2) > T0
             nosignal(i) = nosignal(i) + 1;
        end
    end
end

P_d = signal./trials;
P_fa = sum(nosignal)/(trials*length(SNR));  %simulated value

semilogy(SNR_dB,1-P_d);
hold on;
grid on; axis tight;
xlabel('SNR (dB)')
ylabel('P_d')
title("P_d with post detection integration (N=16) ("+trials+" trials)")

set(gca,'ydir','reverse')
label = [0.0000001 0.000001 0.00001 0.0001 0.001 0.01 0.1];
revlabel = 1-label;
yticks(label)
yticklabels(revlabel);

p1 = plot(0,0);
m1 = "Simulated P_f_a = "+P_fa;
legend([p1],[m1]);