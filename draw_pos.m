function draw_pos(input_im, row)
imshow(input_im);
title('Press any keyboard button to pass next.');

pos1 = [row(1, 1, 1), row(1, 1, 2)];
pos2 = [row(1, 1, 3), row(1, 1, 4)];
pos3 = [row(1, 1, 5), row(1, 1, 6)];

text(double(pos1(1)), double(pos1(2)), '1', 'FontSize', 15);
text(double(pos2(1)), double(pos2(2)), '2', 'FontSize', 15);
text(double(pos3(1)), double(pos3(2)), '3', 'FontSize', 15);

line1 = imline(gca, [pos1;pos2]);
setColor(line1, 'red');

line2 = imline(gca, [pos2;pos3]);
setColor(line2, 'green');

line3 = imline(gca, [pos3;pos1]);
setColor(line3, 'blue');