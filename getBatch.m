function [im, label] = getBatch(imdb, batch)
%GETBATCH  Get a batch of training data
%   [IM, LABEL] = The GETBATCH(IMDB, BATCH) extracts the images IM
%   and labels LABEL from IMDB according to the list of images
%   BATCH.
batch_size = numel(batch);
im_name = imdb.images.name(:,batch);
im = single(zeros([size(imread(im_name{1})), batch_size]));
label = single(zeros(size(imdb.images.labels, 1),  batch_size));
for i = 1:batch_size
    im(:,:,:,i) = single(imread(im_name{i}));
    for c = 1:3
        im(:,:,c,i) = im(:,:,c,i) - imdb.images.normalization.average(c);
    end
    label(:, i) = single(imdb.images.labels(:, batch(i)));
end
label = reshape(label, 1, 1, size(label, 1), batch_size);