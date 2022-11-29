clc;
close all;
clear all;
%NUmber of information bits.
m = 10^3;
%Range of SNR values.
snr_dB = [0:1:20];
for j = 1:1:length(snr_dB)
    n_err = 0;
    n_bits = 0;
    while n_err < 100
        inf_bits = round(rand(1,m));
        %BPSK modulator.
        x = -2*(inf_bits - 0.5);
        %Noise variance.
        N0 = 1/10^(snr_dB(j)/10);
        %Noise for the first.
        n1 = sqrt(N0/2)*abs((randn(1,length(x)) + i*randn(1,length(x))));
        %Noise for the second.
        n2 = sqrt(N0/2)*abs((randn(1,length(x)) + i*randn(1,length(x))));
        %Rayleigh amplitude 1.
        h1 = sqrt(0.5)*abs((randn(1,length(x)) + i*randn(1,length(x))));
        %Rayleigh amplitude 2.
        h2 = sqrt(0.5)*abs((randn(1,length(x)) + i*randn(1,length(x))));
        %Equal Gain combining.
        %Signal 1.
        y1 = h1.*x+n1;
        %Signal 2.
        y2 = h2.*x+n2;
        y_equal = 0.5*(y1+y2);
        %dec_metric = (norm(y_equal-h1*x-h2*x))^2.
        %Decision making at the Receiver.
        est_bits = y_equal<0;
        %Calculate Bit Errors.
        diff = inf_bits - est_bits;
        n_err = n_err + sum(abs(diff));
        n_bits = n_bits + length(inf_bits);
    end
    %Calculate Bit Error Rate.
    BER(j) = n_err/n_bits;
end
%Rayleigh Theoretical BER.
%%%For 2nd Graph%%%
snr = 10.^(snr_dB/10);
theoryBER = 0.5.*(1-sqrt(snr./(snr+1)));
semilogy(snr_dB,theoryBER,'blad-','LineWidth',2);
hold on;
%%%----%%%%
semilogy(snr_dB,BER,'or-','LineWidth',2);
legend('Rayleigh EGC Simulated','Rayleigh Theoretical');
axis([0 20 10^-5 1]);
xlabel('SNR(dB)');
ylabel('BER');
grid on;