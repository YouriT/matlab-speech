A = audioread('a.wav');
AWindowed = A.*hamming(length(A));
AFft = fft(AWindowed);
ATriangle = AFft.*bartlett(length(AFft));
ALog = log(ATriangle);
ADct = dct(ALog);
plot(ADct);
disp(ADct);