function ind_dev = find_deviant(tones)

L = length(tones);
sliding_window_size = 6;
ind_dev = zeros(size(tones));

for i = sliding_window_size:L
    chunk = tones(i-sliding_window_size+1:i);
    train = sum(chunk(1:5));
    trial = chunk(6);
    if (train==0 && trial==1)||(train==5 && trial==0)
        ind_dev(i)=1;
    end
end