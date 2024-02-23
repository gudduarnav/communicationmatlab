% QPSK Modulator and Demodulator


% --- clear ---
close all;
clear all;
clc;

% --- setup ---
M = 4; % number of symbols. 4 for QPSK
NUM_DATA = 1000000; % Number of data samples
SNR = 14; % dB. SNR

% --- Generate the data ---
data = randi([0, M-1], NUM_DATA, 1);

% --- Modulate the data ---
txsignal = pskmod(data, M, pi/M);

% --- Corrupt the signal with AWGN (White) Noise ----
rxsignal = awgn(txsignal, SNR, 'measured');

% --- show the received constellation ---
scatterplot(rxsignal)

% --- demodulate the received signal ---
rxdata = pskdemod(rxsignal, M, pi/M);

% --- calculate the error count ---
error_count = symerr(data, rxdata, 'overall');

% --- calculate the BER ---
ber = error_count / NUM_DATA;
fprintf("BER = %g\n", ber);

