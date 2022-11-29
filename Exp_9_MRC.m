clc;
clear all;
close all;
%%Initialization%%

%Number of trail.
N = 5;
%Number of bits in each trial.
m = 10^6;
%generated bits.
ip = rand(1,m) > 0.5;
%Generated BPSK symbols.
BPSK = 2*ip-1;
%Range of snr values.
snr_dB = 0:1:15;
%snr value in the normal scale.
snr = 10.^(snr_dB/10);
%Number of diversity branches.
L = 2;
%Theoritical BER value for MRC combiner with 2 diversity branches.
P_R_MRC = 1/2 - 1/2*(1+1./snr).^(-1/2);
ber_MRC_ana = P_R_MRC.^2.*(1+2*(1 - P_R_MRC));

%%Receive MRC one by two system%%

%Initialize teh bit error counter.
n_err = zeros(1,length(snr_dB));
for p = 1:N
    for q = 1:length(snr_dB)
        %Generate white noise samples.
        N0 = 1/sqrt(2)*[randn(L,m)+1j*randn(L,m)];
        %Generate channel co-efficient.
        h = 1/sqrt(2)*[randn(L,m)+1j*randn(L,m)];
        %Array of symbols.
        symbol = kron(ones(L,1),BPSK);
        %Received symbol.
        rec_vector = h.*symbol + 10^(-snr_dB(q)/20)*N0;
        %Decision metric.
        dec_metric = sum(conj(h).*rec_vector, 1)./sum(h.*conj(h),1);
        %Estimated symbol.
        ip_hat = real(dec_metric)>0;
        %Compare input and estimated sumbols.
        n_err(q) = n_err(q) + size(find([ip-ip_hat]),2);
    end
end
ber_MRC_sim = n_err/(N*m);
semilogy(snr_dB,ber_MRC_ana,'-r*','LineWidth',2);
hold on;
semilogy(snr_dB,ber_MRC_sim,'ob','LineWidth',2);
legend('ber MRC sim','ber MRC ana');
xlabel('SNR(dB)');
ylabel('BER');