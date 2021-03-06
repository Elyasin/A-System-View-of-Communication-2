% initalization
Fs=1e6;               %sampling frequency
Fc=1e5;               %carrier frequency for message 1
Fcutoff=25e3;         %cutoff frequency of low pass filter 
SPB=20;               % samples per bit     
Ts=1/Fs;              % sample period

textmsg1 = sprintf('%s\n%s\n%s',...
    'It was the best of times, it was the worst of times',...
    'it was the age of wisdom, it was the age of foolishness,',...
    'it was the epoch of belief,');
textmsg2 = sprintf('%s\n%s\n%s',...
    'Lorem ipsum dolor sit amet, at vivamus erat lectus a augue,',...
    'eget a diam aliquam consectetuer, vivamus ad wisi hac posuere,',...
    'praesent tincidunt vel.');

%Transmitter QPSK
tx_wave = tx_QPSK(textmsg1, textmsg2, Fs, Fc, SPB, Fcutoff);

% Channel
rx_wave = txrx(tx_wave,1,'ideal'); 

% create vector of sample times
t = Ts * [0:(length(rx_wave)-1)];

phase_shift = pi/16;

% % % % Revise the following  % % % %     

wave_r1 = rx_wave.*cos(2*pi*Fc*t + phase_shift); 
wave_r1 = lowpass(wave_r1, Fs,Fcutoff);   
msg_r1 = waveform2text(wave_r1,SPB);

wave_r2 = rx_wave.*sin(2*pi*Fc*t + phase_shift); 
wave_r2 = lowpass(wave_r2, Fs,Fcutoff);
msg_r2 = waveform2text(wave_r2,SPB);

% % % % Do not change the code below % % % %

% compare the messages
display(sprintf('Original Message  1: \n%s',  textmsg1 ));
% filter non-printing characters
filtmsg = filter_text(msg_r1);
display(sprintf('Recovered Message 1: \n%s',  filtmsg ));
display(['Num of Bit-Error: '  num2str(sum(textmsg1~=msg_r1(1:length(textmsg1)))) ]);
display(' ');
display(sprintf('Original Message  2: \n%s',  textmsg2 ));
% filter non-printing characters
filtmsg = filter_text(msg_r2);
display(sprintf('Recovered Message 2: \n%s',  filtmsg ));
display(['Num of Bit-Error: '  num2str(sum(textmsg2~=msg_r2(1:length(textmsg2)))) ]);    
      