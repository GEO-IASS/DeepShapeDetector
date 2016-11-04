function mpe = MPE(opts, labels, res)
if opts.batchSize > 1
    predictions = gather(res(end-1).x) ;
else
    predictions = res(end).x;
end

assert(numel(predictions) == numel(labels));
assert(all(size(predictions) == size(labels)));

delta = predictions - labels;

mpe = 0;
batchSize = size(labels, 4);
for b = 1:batchSize
    for i = 0:2
        mpe = mpe + sqrt(delta(1,1,2*i + 1,b)^2 + delta(1,1,2*i + 2,b)^2);
    end
end
end