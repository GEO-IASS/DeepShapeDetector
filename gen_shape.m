function gen_shape(path, image_size, num_sample)
% Setup variable
all_pos_triangle = zeros(num_sample, 6);
if ~exist(path, 'dir')
    mkdir(path);
end

for i = 1:num_sample
    % Create an empty image
    image = randi(191, image_size, image_size, 3, 'uint8') + 64;
    
    % Blur the image
    sigma = rand(1,1) + 1;
    image = imgaussfilt(image, sigma);
    
    % Draw triangle
    min_area = image_size * image_size * 0.05;
    area = 0;
    while area < min_area
        pos_triangle = randi(image_size, 1, 6);
        area = area_of_triangle(pos_triangle);
    end
    opacity = rand(1,1)/10 + 0.9;
    image = insertShape(image,'FilledPolygon', {pos_triangle},'Color', randi(255, 1, 3),'Opacity', opacity);
    
    % Draw vertice shape
    radius = floor(sqrt(min_area)/3);
    pos_circle = [pos_triangle(1), pos_triangle(2), radius];
    image = insertShape(image,'FilledCircle', pos_circle,'Color', randi(128, 1, 3),'Opacity', opacity);
    
    radius = floor(sqrt(min_area)/3);
    pos_circle = [pos_triangle(3), pos_triangle(4), radius];
    image = insertShape(image,'Circle', pos_circle,'Color', randi(128, 1, 3),'Opacity', opacity);
    
    % Save image and positions
    imwrite(image, [path, 'im', sprintf('%05d',i), '.jpg']);
    all_pos_triangle(i,:) = pos_triangle;
end

% Save all positions
save([path, 'all_pos_triangle.mat'], 'all_pos_triangle');