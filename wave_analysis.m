% Show Time and Frequency Spectrum of Analog Signal

close all;
clear all;
clc;

% setup
AMPLITUDE = 1;  % V amplitude of wave
FREQUENCY = 10; % Hz Frequency to analyze
PHASE = deg2rad(0); % Phase angle

SAMPLE_TIME = 1e-3; % s. 

% generate signals
time_base = 0:SAMPLE_TIME:1; % Time axis
y = AMPLITUDE * sin(2 * pi * FREQUENCY * time_base); % y = A sin (2 pi f t)

% plot time time spectrum
f = figure(1);
f.Position = [100, 100, 800, 600];

subplot(2, 1, 1)
plot(time_base, y)
xlabel('Time (s)')
ylabel('Amp. (V)')
grid on
title(sprintf('Time spectrum of Sine Wave of %g Hz %g V', FREQUENCY, AMPLITUDE))
xlim([0, max(time_base)])


% generate the frequency spectrum
SAMPLE_RATE = 1 / SAMPLE_TIME;
frequency_base = linspace(-SAMPLE_RATE/2, SAMPLE_RATE/2, length(y));
frequency_y = pow2db(abs(fft(y)).^2);
frequency_y = fftshift(frequency_y);

subplot(2, 1, 2)
plot(frequency_base, frequency_y)
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on
title('Frequency spectrum')
xlim([-SAMPLE_RATE/2, SAMPLE_RATE/2])
ylim([-60, 60])

