% Load the input image
lorem_img = imread('lorem_img.png');


% display the raw image
figure(1);
imshow(lorem_img);
title('Original image');

% run-length encode
run_length_code = runlength_encode(lorem_img);
% convert the binary array into an decimal array of runs
runs = bin2decArray(run_length_code);

% huffman code        
% compute the probability of the run lengths .
rlen_list = [0:10,255]
figure(2);
hist = histogram(runs,rlen_list,'Normalization','probability','Visible','off');
% show the probability
prob = hist.Values'
%show the probability using the function bar 
bar([0:10],prob); xlabel('run length'); ylabel('Probability');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','>=10'});
title('Histogram of the runs from 0 to 9 and >= 10');

% % % % Revise the following code to generate a valid  and efficient dictionary   % % % %  
%dict = {[0 0 0 0], [0 0 0 1], [0 0 1 0], [0 0 1 1], [0 1 0 0],...
%        [0 1 0 1], [0 1 1 0], [0 1 1 1], [1 0 0 0], [1 0 0 1],[1 0 1 0]};
dict = {[0 0 1 0 1 1 0 0], [1], [0 0 0], [0 1 0], [0 1 1], [0 0 1 1 0], [0 0 1 0 1 0]...
        [0 0 1 1 1], [0 0 1 0 1 1 1], [0 0 1 0 1 1 0 1], [0 0 1 0 0]};


% % % % Do not change the code below % % % %  

% Use the dictionary to encode the run lengths
huffman = huffman_encode_dict(runs, dict);

% Decode
% Get the runs from the encoded bitstream
runs_new= huffman_decode_dict(huffman, dict);
new_length_code = reshape(dec2binArray(runs_new).',1,length(runs_new)*8);

% recreate 500 by 500 image from the run length code
img_new = runlength_decode(new_length_code);
figure(3);
imshow(img_new);
title('Recreated image');

% Put figure  1 and 2 on top by calling them again
figure(2);
figure(1);

% compare the lengths
size_raw_data = length(lorem_img(:))
size_huffman = length(huffman)