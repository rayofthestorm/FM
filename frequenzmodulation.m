% Frequecy Modulation (FM)

fs = 500e3; % sample rate 500kHz
Ts = 1/fs;  % time step
t = 0:Ts:10-Ts; %time vector start / step / end

% generate waves:
% wave 1 -> carrier / Traeger
fc = 20e3; %Hz
uc = cos(2 * pi * fc * t); %sinus auch möglich

% wave 2 -> baseband / Audiosignal
fb = 2000; %Hz
ub = cos(2 * pi * fb * t);

% Modulation
%delta_f = 4800; %Frequenzhub
eta = 3; %Modulationsindex en: modulationindex eta < 1 -> Schmalband-FM (NBFM)
delta_f = eta * fb; 
int_ub = 1/fs * cumsum(ub);
ufm = cos(2 * pi * fc * t + 2 * pi * delta_f * int_ub);

% Plor Time Domain (Zeitbereichsdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t,ub, t, ufm ), grid on;
axis([0.0 0.001 -2.2 2.2]); % Axenskalierung ändern axis([xbeginn xend ybegin yend])
title('time domain')
xlabel('time');
ylabel('voltage');
legend('AM signal','baseband');

% Calculate Frequncy Spectrum
% with Fast Fourier Transforamtion (FFT)
F = fft(ufm); % fourier coefficient (=amplitude) at each frequrncy
n = length(ufm); % number of samples
f = (0 : n-1)*(fs/n); % vector of frequencies
volt = 2/n * abs(F); % absolute value of amplitude

% Plot Frequency Domain (Frequenzbereichsdarstellung)
subplot(2, 1, 2); % 2nd row
plot(f, volt); % volt(f)
grid on;
axis([0 50e3 0 1.2]);
title('frequency doamin')
xlabel('frequency');
ylabel('voltage');

