% QPSK Modulator and Demodulator
% BER Plot


% --- clear ---
close all;
clear all;
clc;

% --- setup ---
M = 4; % number of symbols. 4 for QPSK
NUM_DATA = 1000000; % Number of data samples
SNR_Start = 0; % dB. SNR
SNR_Stop = 20; % dB. SNR

% --- Generate the data ---
data = randi([0, M-1], NUM_DATA, 1);

% --- Modulate the data ---
txsignal = pskmod(data, M, pi/M);

% Iterate power and get BER
BER = [];

for SNR = SNR_Start:1:SNR_Stop
    % --- Corrupt the signal with AWGN (White) Noise ----
    rxsignal = awgn(txsignal, SNR, 'measured');

    % --- show the received constellation ---
    %scatterplot(rxsignal)

    % --- demodulate the received signal ---
    rxdata = pskdemod(rxsignal, M, pi/M);

    % --- calculate the error count ---
    error_count = symerr(data, rxdata, 'overall');

    % --- calculate the BER ---
    ber = error_count / NUM_DATA;
    BER(end+1) = ber;
end


f = figure(1);
plot(SNR_Start:1:SNR_Stop, log10(BER))
grid on
xlabel('SNR (dB)')
ylabel('log10(BER)')
ylim([-log10(NUM_DATA), 0])
xlim([SNR_Start, SNR_Stop])


