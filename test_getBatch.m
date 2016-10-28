function test_getBatch(batch)
imdb = load('imdb.mat');
[im, label] = getBatch(imdb, batch);

im_size = size(im, 1);
batch_size = numel(batch);

for b = 1:batch_size
    fprintf('Index %d\n', batch(b));
    for c = 1:3
        im(:,:,c,b) = im(:,:,c,b) + imdb.images.normalization.average(c);
    end
    test_image = uint8(im(:,:,:,b));
    input_pos = label(1, 1, :, b)*im_size;
    draw_pos(test_image, input_pos);
    waitforbuttonpress;
end
end