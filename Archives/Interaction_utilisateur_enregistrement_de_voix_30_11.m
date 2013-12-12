%Enregistrer une voix%

Fs = 11025
rec = audiorecorder(Fs, 16, 2);

disp('Appuyez sur une touche pour enregistrer un son');
w = waitforbuttonpress;

if (w == 0 || w == 1 )
    record(rec);

end

disp('Appuyez sur une touche pour terminer l''enregistrement');
w1 = waitforbuttonpress;

if (w == 0 || w == 1 )
    record(rec);

end

stop(rec)

play(rec)