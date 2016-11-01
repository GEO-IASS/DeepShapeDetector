function test_getBatch(batch)
imdb = load('imdb.mat');
display(batch)
[im, label, im_mean] = getBatch(imdb, batch);

im_size = size(im, 1);
batch_size = numel(batch);

for b = 1:batch_size
    fprintf('Index %d\n', batch(b));
    test_image = im(:, :, :, b);
    for c=1:3
        test_image(:, :, c) = test_image(:, :, c) + im_mean(c,b);
    end
    test_image = uint8(test_image);
    input_pos = label(1, 1, :, b)*im_size;
    draw_pos(test_image, input_pos, 'test_getBatch');
    waitforbuttonpress;
end
end