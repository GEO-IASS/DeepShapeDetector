function imdb = setup_imdb()
% Meta data
imdb.classes.name = cell(3, 1);
imdb.classes.name{1} = 'Filled Circle';
imdb.classes.name{2} = 'Circle';
imdb.classes.name{3} = 'Vertix';

% Loading training, validing and testing image
train_size = 10000;
val_size = 100;
test_size = 100;
train_path = 'data/training/';
val_path = 'data/validation/';
test_path = 'data/testing/';

target_size = 64;
label_size = 3;
gen_shape(train_path, target_size, train_size);
gen_shape(val_path, target_size, val_size);
gen_shape(test_path, target_size, test_size);

total_sample_size = train_size + val_size + test_size;
imdb.images.name = cell(1, total_sample_size);
imdb.images.labels = single(zeros(label_size*2, total_sample_size));
imdb.images.set = single(zeros(1, total_sample_size));
imdb.images.normalization.average = single(zeros(label_size, 1));

sizes = [train_size, val_size, test_size];
paths = {train_path, val_path, test_path};
sets = [1, 2, 3];

count = 0;
for i = 1:3
    path = paths{i};
    
    % Calculating the mean of the mean of the training sample
    if i == 1
        for s = 1:sizes(i)
            im = single(imread([path, 'im', sprintf('%05d', s), '.jpg']));
            for c = 1:3
                imdb.images.normalization.average(c) = imdb.images.normalization.average(c) + mean2(im(:,:,c))/sizes(i);
            end
        end
    end
    
    pos_struct = load([path, 'all_pos_triangle.mat']);
    for s = 1:sizes(i)
        count = count + 1;
        
        % Record image path
        imdb.images.name{count} = [path, 'im', sprintf('%05d', s), '.jpg'];
        
        % Organizinglocation
        imdb.images.labels(1:6, count) = pos_struct.all_pos_triangle(s, :)/target_size;
      
        % Organizing set
        imdb.images.set(count) = sets(i);
    end
end

save('imdb.mat', '-struct' ,'imdb');