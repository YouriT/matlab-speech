function [R] = cleanSignal(S)
R = S.*hamming(length(S));
end