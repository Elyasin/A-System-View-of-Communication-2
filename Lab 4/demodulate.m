function [rx, xd] = demodulate(x,Fs,freq_carrier,freq_cutoff)
% DEMODULATE Demodulate a waveform X.
%
% [RX, XD] = DEMODULATE(X, FS, FREQ_CARRIER, FREQ_CUTOFF) demodulates a waveform
%    Inputs:
%        X = waveform to demodulate
%        FS = sampling frequency
%        FREQ_CARRIER = frequency of cosinusoidal carrier
%        FREQ_CUTOFF = cut-off frequency of low pass filter 
%    Outputs:
%        RX = demodulated waveform
%        XD = X mixed with cosinusoidal carrier wave (for debugging)

% Get vector of time samples
%t = zeros(size(x));
Ts = 1/Fs; %  sample period
Tmax= (length(x)-1)*Ts; 
t=0:Ts:Tmax;

% mix waveform with carrier    
xd = x .* cos(2*pi*freq_carrier*t); 

% apply lowpass filtering
rx=lowpass(xd,Fs,freq_cutoff);    

end