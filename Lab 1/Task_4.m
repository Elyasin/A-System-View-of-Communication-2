
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

% The rlen_list variable contains the run lengths we are interested in
% (here between 0 and  9 and >=10 runs).
rlen_list = [0:10,255];

% % % % Revise the following code  % % % %

% separate the black and white runs
len_runs = length(runs);
white_runs = runs(1:2:end);
black_runs = runs(2:2:end);

% compute the distributions and show the probabilities
figure(2);
hist = histogram(white_runs,rlen_list,'Normalization','probability','Visible','off');
white_prob = hist.Values'
hist = histogram(black_runs,rlen_list,'Normalization','probability','Visible','off');
black_prob = hist.Values'


%show the distributions using the function bar
bar([0:10],white_prob); xlabel('white runs'); ylabel('Probability');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','>=10'});
title('Histogram of the white runs from 0 to 9 and >= 10');

figure(3); bar([0:10],black_prob); xlabel('black runs'); ylabel('Probability');
set(gca,'XTickLabel',{'0','1','2','3','4','5','6','7','8','9','>=10'});
title('Histogram of the black runs from 0 to 9 and >= 10');

% Use the information in white_prob and black_prob to create
% separate dictionaries for the white and black run lengths.
white_dict = {[1 1 0 0 0 0 0], [1 1 0 0 1], [1 0], [1 1 1], [0 0],...
              [1 1 0 1], [0 1 0 1], [0 1 0 0], [1 1 0 0 0 1],...
              [1 1 0 0 0 0 1], [0 1 1]};
black_dict = {[0 1 1 1 0], [1], [0 0], [0 1 0], [0 1 1 0], [0 1 1 1 1 1],...
              [0 1 1 1 1 0 0 1 0 1], [0 1 1 1 1 0 1], [0 1 1 1 1 0 0 0],...
              [0 1 1 1 1 0 0 1 1], [0 1 1 1 1 0 0 1 0 0]};

% % % % Do not change the code below % % % %


% Encode the runs using the two dictionaries
huffman = huffman_encode_dict(runs, white_dict,black_dict);

% Extract the runs from the bitstream
runs_new= huffman_decode_dict(huffman, white_dict,black_dict);
new_length_code = reshape(dec2binArray(runs_new).',1,length(runs_new)*8);

% recreate 500 by 500 image from the length code
img_new = runlength_decode(new_length_code);
figure(4);
imshow(img_new);
title('Recreated image');

% compare the lengths
size_raw_data = length(lorem_img(:))
size_huffman = length(huffman)

figure(1);figure(2);figure(3);figure(4);
