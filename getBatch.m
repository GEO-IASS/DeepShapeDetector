function [im, label, im_mean] = getBatch(imdb, batch)
%GETBATCH  Get a batch of training data
%   [IM, LABEL] = The GETBATCH(IMDB, BATCH) extracts the images IM
%   and labels LABEL from IMDB according to the list of images
%   BATCH.
batch_size = numel(batch);
im_name = imdb.images.name(:,batch);
set = imdb.images.set(:,batch);
im = single(zeros([imdb.meta.image_size, imdb.meta.image_size, 3, batch_size]));
label = single(zeros(size(imdb.images.labels, 1),  batch_size));
mean = single(zeros(3, batch_size));
for i = 1:batch_size
    if set(:,i) == 1
        [im(:,:,:,i), label(:, i)] = gen_shape(imdb.meta.image_size);
        label(:, i) = label(:, i) / imdb.meta.image_size;
    else
        im(:,:,:,i) = single(imread(im_name{i}));
        label(:, i) = single(imdb.images.labels(:, batch(i)));
    end

    for c = 1:3
        mean(c, i) = mean2(im(:,:,c, i));
        im(:,:,c,i) = im(:,:,c,i) - mean(c, i);
    end
end
label = reshape(label, 1, 1, size(label, 1), batch_size);

if nargout > 2
    im_mean = mean;
end