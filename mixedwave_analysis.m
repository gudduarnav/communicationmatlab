% when two waves are mixed

% --- clear ----
close all;
clear all;
clc;

% --- setup ---

% - wave 1 -
WAVE1_FREQ = 1e3; % Hz
WAVE1_A = 1;      % V
WAVE1_PHASE = deg2rad(0); % angle

% - wave 2 -
WAVE2_FREQ = 2e3; % Hz
WAVE2_A = 1;      % V
WAVE2_PHASE = deg2rad(90); % angle

% - experiment setup -
STEP_TIME = 0.1e-4; % s
EXP_TIME  = 1; % s
NUM_SAMPLES = round(EXP_TIME/STEP_TIME); 



% --- generate wave and mix ---
SAMPLE_INDEX = 0 : NUM_SAMPLES-1;
SAMPLE_TIME = SAMPLE_INDEX * STEP_TIME; % s

x = WAVE1_A * cos(2*pi*WAVE1_FREQ*SAMPLE_TIME + WAVE1_PHASE) + ...
    WAVE2_A * cos(2*pi*WAVE2_FREQ*SAMPLE_TIME + WAVE2_PHASE);

% plot time time spectrum
f = figure(1);
f.Position = [100, 100, 800, 600];

subplot(2, 1, 1)
plot(SAMPLE_TIME, x)
xlabel('Time (s)')
ylabel('Amp. (V)')
grid on
title('Time spectrum of Mixed Waves')
%xlim([0, max(SAMPLE_TIME)])
xlim([0, 10e-3])

% generate the frequency spectrum
SAMPLE_RATE = 1 / STEP_TIME;
frequency_base = linspace(-SAMPLE_RATE/2, SAMPLE_RATE/2, length(x));
frequency_x = pow2db(abs(fft(x)).^2);
frequency_x = fftshift(frequency_x);

subplot(2, 1, 2)
plot(frequency_base, frequency_x)
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
grid on
title('Frequency spectrum')
xlim([-SAMPLE_RATE/2, SAMPLE_RATE/2])
ylim([-60, 100])


