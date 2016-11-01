function visualize_prediction(net, batch)
imdb = load('imdb.mat');
[im, label, im_mean] = getBatch(imdb, batch);

batch_size = numel(batch);
opts.batchSize = 1;
for b = 1:batch_size
    res = vl_simplenn(net, im(:, :, :, b)) ;
    loss = MPE(opts, label(:, :, :, b), res);
    title_str = sprintf('Image index %d: MPE is %f', batch(b), loss);
    display(title_str);
    
    test_image = im(:, :, :, b);
    for c=1:3
        test_image(:, :, c) = test_image(:, :, c) + im_mean(c,b);
    end
    test_image = uint8(test_image);
    draw_pos(test_image, res(end).x*imdb.meta.image_size, title_str);
    w = 0;
    while w ~= 1
        w = waitforbuttonpress;
    end
    
end