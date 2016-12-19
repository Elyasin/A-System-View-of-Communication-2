% Load the input image
lorem_img = imread('lorem_img.png');
% The test image is black-and-white and has a 500-by-500 array of pixels.
% In MATLAB, pixels are encoded by their brightness, where black pixel has 
% a value of 0, and white pixel has a value of 1. Because the image is 
% black-and-white, one bit is needed to encode one pixel. 

% display the raw image
figure(1);
imshow(lorem_img);
title('Original image');

% % % run-length encode % % %
run_length_code = my_runlength_encode(lorem_img);
 
size_raw_data = length(lorem_img(:))
size_run_length = length(run_length_code)

% recreate 500 by 500 image
img_new = runlength_decode(run_length_code);
figure(2);
imshow(img_new);
title('Recreated image');
