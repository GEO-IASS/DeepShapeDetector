function [image, pos_triangle] = gen_shape(image_size)
% Create an empty image
image = randi(191, image_size, image_size, 3, 'uint8') + 64;

% Blur the image
sigma = rand(1,1) + 1;
image = imgaussfilt(image, sigma);

% Draw background triangle & quadrilateral
%opacity = rand(1,1)/10 + 0.9;
%image = insertShape(image,'FilledPolygon', {randi(image_size, 1, 6)},'Color', randi(255, 1, 3),'Opacity', opacity);
%opacity = rand(1,1)/10 + 0.9;
%image = insertShape(image,'FilledPolygon', {randi(image_size, 1, 8)},'Color', randi(255, 1, 3),'Opacity', opacity);

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

% Draw another non-filled circle
radius = floor(sqrt(min_area)/3);
pos_circle = [pos_triangle(3), pos_triangle(4), radius];
image = insertShape(image,'Circle', pos_circle,'Color', randi(128, 1, 3),'Opacity', opacity);

% center = ([pos_triangle(3), pos_triangle(4), 0] + [pos_triangle(5), pos_triangle(6), 0]) / 2;
% v1_to_center = center - [pos_triangle(1), pos_triangle(2), 0];
% v1_to_v2 = [pos_triangle(3), pos_triangle(4), 0] - [pos_triangle(1), pos_triangle(2), 0];
% c = cross(v1_to_v2, v1_to_center);
% if c(3) < 0
%     temp_x = pos_triangle(3);
%     temp_y = pos_triangle(4);
%     pos_triangle(3) = pos_triangle(5);
%     pos_triangle(4) = pos_triangle(6);
%     pos_triangle(5) = temp_x;
%     pos_triangle(6) = temp_y;
% end