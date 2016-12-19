% Exponential factor controlling step response of channel
ach = 0.93;
% Exponential factor controlling the equalizer. This is the
% equalizer's estimate of the a of the channel.  Ideally, this
% should equal ach, but in practice, there is often mismatch.
aeq = 0.98;

nsamp = 1200;
n=0:(nsamp-1);

flist = logspace(-3,-1);
h_rx = zeros(1,length(flist));
h_eq_rx = zeros(1,length(flist));
h_eq_tx = zeros(1,length(flist));
  
for i=1:length(flist)
    % % % % Revise the following code   % % % %  
aeq = 0.83
    % normalized frequency of the signal (cycles/sample)
    freq = flist(i);
    
    % create a sinusoidal function with frequency freq and nsamp samples
    tx_wave = cos(2*pi*freq*n);
    
    % send the signal through the channel
    rx_wave = txrx(tx_wave,ach,'pureexp');
    eq_rx = equalizer(rx_wave,aeq);
    eq_tx = equalizer(tx_wave,aeq);

    h_rx(i) = max(rx_wave(201:end)) - min(rx_wave(201:end));
    h_eq_rx(i) = max(eq_rx(201:end)) - min(eq_rx(201:end));
    h_eq_tx(i) = max(eq_tx(201:end)) - min(eq_tx(201:end));
        
	% % % % Do not change the code below   % % % %  
    
end
figure(1);
% Divide the peak to peak amplitude of the output by 
% the peak to peak amplitude of the input (2)
loglog(flist,h_rx/2,'b'); 
hold on;
loglog(flist,h_eq_rx/2,'r'); 
loglog(flist,h_eq_tx/2,'g'); hold off;
grid
legend('output','equalized output','equalized input');
xlabel('Normalized Frequency');
ylabel('Amplitude');
title('Frequency responses');