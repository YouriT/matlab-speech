function [R] = cleanSignal(S)
S = S.*hamming(length(S));
filterHF = [1 0.9];
R = filter(1,filterHF,S);
end