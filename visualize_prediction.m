function visualize_prediction(net, batch)
imdb = load('imdb.mat');
im_name = imdb.images.name(:,batch);
im_size = size(imread(im_name{1}), 1);

batch_size = numel(batch);
opts.batchSize = 1;
for b = 1:batch_size
    test_image = imread(im_name{b});
    im = single(test_image);
    for c = 1:3
        im(:,:,c) = im(:,:,c) - imdb.images.normalization.average(c);
    end
    res = vl_simplenn(net, im) ;
    draw_pos(test_image, res(end).x*im_size);
    
    label = single(imdb.images.labels(:, batch(b)));
    label = reshape(label, 1, 1, size(label, 1), 1);
    loss = MPE(opts, label, res);
    display(sprintf('Image index %d: MPE is %f', batch(b), loss));

    w = 0;
    while w ~= 1
        w = waitforbuttonpress;
    end
    
end