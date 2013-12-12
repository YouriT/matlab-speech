
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function gui_guidata_guihandles
data=guihandles(gcf);



% Création de l'objet Figure
figure('units','pixels',...
    'position',[250 200 600 500],...
    'color',[0.95 0.95 0.95],...
    'numbertitle','off',...
    'name','Projet Traitement de Signal : Reconnaissance vocale',...
    'menubar','none',...
    'tag','interface');

% Création de l'objet Titre
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.35 0.9 0.3 0.03],... %[X,Y,Largeur,Hauteur]
    'string','Dictionnaire d''acronyme');

% Création de l'objet Uicontrol Bouton Enregistrer
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.08 0.8 0.15 0.05],...
    'string','Enregistrer',...
    'callback',@record,...
    'tag','bouton_retrancher');

% Création de l'objet Uicontrol Bouton Jouer
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.31 0.8 0.15 0.05],...
    'string','Jouer',...    
    'callback',@ecouter,...
    'tag','bouton_ecouter');

% Création de l'objet Uicontrol Bouton Reconnaitre
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.54 0.8 0.15 0.05],...
    'string','Reconnaitre',...    
    'callback',@match,...
    'tag','bouton_match');

% Création de l'objet Uicontrol Bouton Close
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.77 0.8 0.15 0.05],...
    'string','Quitter',...    
    'callback',@close,...
    'tag','bouton_close');


% Génération de la structure contenant les identifiants des objects graphiques dont la 
% propriété Tag a été utilisée.

% D'après les Tag utilisés pour les objets graphiques crées précédemment, la structure data 
% contient les champs suivant :
%   data.interface
%   data.resultat
%   data.bouton_ajouter
%   data.bouton_retrancher
%


data.Fs = 16000;
data.nbits_sound=16;
data.nbits_channel=1;

%L'utilisateur enregistre un son
data.isListenning=0;
%Nombre de lettre que l'utilisateur a enregistré
data.nbletter=0;
%Tableau contenant les lettres enregistrées
data.tbcell = cell(data.nbletter,1);
data.tbsignaux=cell(data.nbletter,1);
%Alphabet
data.alphabet={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
for i=1:length(data.alphabet)
    path=strcat(data.alphabet{i},'.wav');
    if exist(path)
        data.nbletter=data.nbletter+1;
        data.tbcell{data.nbletter,1}=data.alphabet{i};
        data.tbsignaux{data.nbletter,1}=wavread(path);
    end;
end;

data.columnName = {'Lettre'};
data.tableau=uitable('ColumnName', data.columnName,'Data', data.tbcell,'Position',[50 50 110 320]);


%data.rec = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);
%data.rec_save = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);

% Enregistrement de data dans les données d'application de l'objet Figure

guidata(gcf,data)

%%%%%%%%%%%%%%%%%%%%%%%%
%FONCTIONs SECONDAIRES%
%%%%%%%%%%%%%%%%%%%%%%%%

function close(obj,event)
answer = questdlg('Etes-vous sûr(e) de vouloir quitter l''application?', ...
        'Exit Dialog','Oui','Non','Non'); 
if strcmp(answer,'Oui')
   delete(gcf); 
end


function record(obj,event)

% Récupération des données stockées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
data=guidata(gcbf);
signal=record2data(1,1,16000);
prompt=cell(1);
answer=inputdlg(prompt);
temp=answer{1,1};
%Création du nom du fichier sur base du nom donné par l'utilisateur
pathname=strcat(temp,'.wav');
if exist(pathname)
    i=0;
    find=0;
    while(find==0)
        i=i+1;
        temp2=data.tbcell{i,1};
         if (temp2==temp)
            wavwrite(signal,pathname);
            data.tbsignaux{i,1}=signal; 
            find=1;
        end;
    end;
else
%Insertion 
data.nbletter=data.nbletter+1;
data.tbcell{data.nbletter,1}=answer{1,1};
data.tbsignaux{data.nbletter,1}=signal; 
wavwrite(signal,pathname);   
end;

%Rafraichissement du tableau
set(data.tableau, 'Data', data.tbcell);

    %data.tbcell{data.nbletter,2} = getaudiodata(data.rec)
    %data.rec = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);

% Modification de sa propriété String
%set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des données modifiées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
guidata(gcbf,data)


function ecouter(obj,event)
data=guidata(gcbf);
prompt=cell(1);
answer=inputdlg(prompt);
answer=answer{1,1};
temp=answer;
%answer=strcat(answer{1,1},'.wav')
i=0;
find=0;
while(find==0)
    i=i+1;
    if i>length(data.tbcell)
        disp('Signal non trouvé');
        break;
    end;
    if (data.tbcell{i,1}==temp)
        wavplay(data.tbsignaux{i,1},data.Fs);
        find=1;
    end;
end;
%signal=wavread(answer);
%wavplay(signal,data.Fs);


guidata(gcbf,data)

function match(obj,event)
data=guidata(gcbf);
recognizion=record2data(-1,1,16000);
a=diffBetweenSignals_newGen(recognizion,data.tbsignaux,16000);    
longueur_mot=length(a);
mot=blanks(longueur_mot);
for i=1:longueur_mot
    mot(i)=data.tbcell{a{1,i},1};
end
disp(mot);
mot=upper(mot);
web(strcat('http://en.wikipedia.org/wiki/',mot));

%prompt=cell(1);
%answer = inputdlg(prompt);
%data.answer=answer;
% Augmentation de la valeur de nCompteur
    %data.nCompteur=data.nCompteur+1;

% Modification de sa propriété String
    %set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des données modifiées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
