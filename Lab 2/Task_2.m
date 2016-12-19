% load a speech signal
[x,Fs] = audioread('test.wav');

% define the frame length
frame_length = 256; 

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% function get_frame_power: compute power of each frame

% calculate the total number of full frames of length frame_length
num_frames = fix(length(x)/frame_length); 

% % % % Revise the following code  % % % %  

y_framed = reshape(x(1:frame_length*(num_frames)), [frame_length, num_frames]);
frame_power = zeros(1,num_frames);
for i=1:num_frames,
    frame_power(i) = sum(y_framed(1:end,i).*y_framed(1:end,i)) / frame_length;
end;

% % % % Do not change the code below % % % % 

% get frame with maximum power 
[mxpow,fnum] = max(frame_power);              
frame = y_framed(:,fnum);

% generate plots
figure(1);
plot_speech_power(x,frame_power,frame_length);

% plot the frame fnum
figure(2);
plot(0:(frame_length-1),frame);
ax = axis;
axis([0 frame_length-1 ax(3:4)]);
grid
title(['Frame ' num2str(fnum) ' waveform']);