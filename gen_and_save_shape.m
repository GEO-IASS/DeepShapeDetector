function gen_and_save_shape(path, image_size, num_sample)
% Setup variable
all_pos_triangle = zeros(num_sample, 6);
if ~exist(path, 'dir')
    mkdir(path);
end

for i = 1:num_sample
    [image, pos_triangle] = gen_shape(image_size);
    
    % Save image and positions
    imwrite(image, [path, 'im', sprintf('%05d',i), '.jpg']);
    all_pos_triangle(i,:) = pos_triangle;
end

% Save all positions
save([path, 'all_pos_triangle.mat'], 'all_pos_triangle');
