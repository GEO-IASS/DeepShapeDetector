function area = area_of_triangle(pos_triangle)
ax = pos_triangle(1);
ay = pos_triangle(2);

bx = pos_triangle(3);
by = pos_triangle(4);

cx = pos_triangle(5);
cy = pos_triangle(6);

area = abs(ax*(by-cy)+bx*(cy-ay)+cx*(ay-by))/2;