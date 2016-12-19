function run_length_code = my_runlength_encode(img)
% MY_RUNLENGTH_ENCODE encode an image using run length encoding
%    RUN_LENGTH_CODE = MY_RUNLENGTH_ENCODE(IMG) returns a binary 
%    vector RUN_LENGTH_CODE containing the run length encoding of 
%    the binary image IMG. The binary output vector contains a sequence
%    of 8 bit binary numbers indicating the length of runs of white and 
%    black pixels (counting across the rows of the image first).  

% reshape the image to a 1D vector
image= img'; % transpose the image to vectorize row by row
img_1D = image(:)'; % vectorize the image

runs = [];
run_len = 0;
pixel_value = 1; % Assume white pixel run at first
for bit_count = 1:length(img_1D),
    if img_1D(bit_count) == pixel_value,
        run_len = run_len + 1; 
    else
        pixel_value = img_1D(bit_count);
        runs = [runs run_len];
        run_len = 1;
    end
    % % % % Revise the following code to split runs longer than 255 bits  % % % %  
    if run_len == 255,
        runs = [runs run_len 0];
        run_len = 0;
    end
    % % % % Do not change the code below % % % %    
end
runs = [runs run_len];
% encode runs as 8 bit binary vectors
run_length_code = reshape(dec2binArray(runs)',1,length(runs)*8);
end