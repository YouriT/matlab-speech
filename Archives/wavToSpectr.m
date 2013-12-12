function spec = wavToSpectr(d , sr )
% Calculate basic RASTA-PLP cepstra and spectra
[cep, spec] = rastaplp(d, sr,0,15);
spec = abs(spec);
end