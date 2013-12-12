function [R] = cleanSignal(S)
B = [1 -0.95];
R = filter(B,1,S);
end