function ind_std = find_standard_all(tones)

L = length(tones);
sliding_window_size = 6;
ind_std = zeros(size(tones));
flag_found_std = 0;

for i = sliding_window_size:L
    chunk = tones(i-sliding_window_size+1:i);
    train = sum(chunk);
    if (train==0 || train==6)
            ind_std(i)=1;
    end
end