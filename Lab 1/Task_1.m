% Load the input image
lorem_img = imread('lorem_img.png');
 
% display the raw image
figure(1);
imshow(lorem_img);
title('Original image');
% run-length encode
run_length_code = runlength_encode(lorem_img);

% convert the binary array into an decimal array of run lengths
runs = bin2decArray(run_length_code);

% Huffman encode
% huffman_encode(runs,dict)
% if dict = 1, same dictionary for both black and white runs
% if dict = 0, separate dictionaries for black and white runs
huffman = huffman_encode(runs,0);

size_raw_data = length(lorem_img(:))
size_run_length = length(run_length_code)
size_huffman = length(huffman)