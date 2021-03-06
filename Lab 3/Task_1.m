% Exponential factor controlling step response of channel
a = 0.9;

% normalized frequency of the signal (cycles/sample)
freq = 0.0005;
% length of the input waveform
nsamp = 4000;
% sample indices 
n=0:(nsamp-1);
% create a sinosuidal function with frequency freq and nsamp samples
tx_wave = cos(2*pi*freq*n);

% send the signal through the channel
rx_wave = txrx(tx_wave,a,'pureexp');

% estimate maximum and minimum amplitude of received waveform
% skip the first 200 samples to avoid transient effects
mx = max(rx_wave(200:end));
mn = min(rx_wave(200:end));
peak2peak = mx - mn;
%plot tx_wave
figure(1);
plot(tx_wave);
axis([1 length(tx_wave) -1.1 1.1]);
title('Transmitted signal');
ylabel('amplitude')
grid
 
%plot rx_wave
figure(2);
plot(rx_wave);
hold on;   
line([0 length(rx_wave)], [mn mn], 'Color',[1 0 0]);
line([0 length(rx_wave)], [mx mx], 'Color',[1 0 0]);
hold off;
axis([1 length(tx_wave) -1.1 1.1]);
title('Received signal');
grid
xlabel('sample')
ylabel('amplitude')
set(gca,'YTick',[-1:.1:1])
