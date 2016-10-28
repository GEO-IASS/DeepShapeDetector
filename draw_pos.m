function draw_pos(input_im, row)
imshow(input_im);

pos1 = [row(1, 1, 1), row(1, 1, 2)];
pos2 = [row(1, 1, 3), row(1, 1, 4)];
pos3 = [row(1, 1, 5), row(1, 1, 6)];

line1 = imline(gca, [pos1;pos2]);
setColor(line1, 'red');

line2 = imline(gca, [pos2;pos3]);
setColor(line2, 'green');

line3 = imline(gca, [pos3;pos1]);
setColor(line3, 'blue');