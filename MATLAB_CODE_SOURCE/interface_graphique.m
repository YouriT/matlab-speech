
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function gui_guidata_guihandles
data=guihandles(gcf);


% Création de l'objet Figure
figure('units','pixels',...
    'position',[250 250 500 500],...
    'color',[0.95 0.95 0.95],...
    'numbertitle','off',...
    'name','Projet Traitement de Signal : Speech Analysis',...
    'menubar','none',...
    'tag','interface');

% Création de l'objet Uicontrol Pushbutton -
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.1 0.8 0.1 0.05],...
    'string','Enregistrer',...    
    'callback',@retrancher,...
    'tag','bouton_retrancher');

% Création de l'objet Uicontrol Pushbutton +
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.3 0.8 0.1 0.05],...
    'string','Ecouter',...    
    'callback',@ajouter,...
    'tag','bouton_ajouter');

uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.5 0.8 0.1 0.05],...
    'string','Jouer',...    
    'callback',@ecouter,...
    'tag','bouton_ecouter');

% Création de l'objet Uicontrol Text résultat
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.1 0.2 0.3 0.05],...
    'string','0',...
    'tag','resultat');

uicontrol('style','text',...
    'units','normalized',...
    'position',[0.35 0.9 0.3 0.03],... %[X,Y,Largeur,Hauteur]
    'string','Reconnaissance Vocal');
% Génération de la structure contenant les identifiants des objects graphiques dont la 
% propriété Tag a été utilisée.

% D'après les Tag utilisés pour les objets graphiques crées précédemment, la structure data 
% contient les champs suivant :
%   data.interface
%   data.resultat
%   data.bouton_ajouter
%   data.bouton_retrancher
%


data.Fs = 11025;
data.nbits_sound=16;
data.nbits_channel=1;

%L'utilisateur enregistre un son
data.isListenning=0;
%Nombre de lettre que l'utilisateur a enregistré
data.nbletter=0;
%Tableau contenant les lettres enregistrées
data.tbcell = cell(data.nbletter,1);
%Alphabet
data.alphabet={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
for i=1:length(data.alphabet)
    path=strcat(data.alphabet{i},'.wav');
    if exist(path)
        data.nbletter=data.nbletter+1;
        data.tbcell{data.nbletter,1}=data.alphabet{i};
    end;
end;

data.columnName = {'Lettre'};
data.tableau=uitable('ColumnName', data.columnName,'Data', data.tbcell);


%data.rec = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);
%data.rec_save = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);

% Enregistrement de data dans les données d'application de l'objet Figure

guidata(gcf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION RETRANCHER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function retrancher(obj,event)

% Récupération des données stockées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
data=guidata(gcbf);
%record(data.rec);
if data.isListenning==0
    data.isListenning=1;
else
    data.isListenning=0; 
    data.nbletter=data.nbletter+1;
    similar = cell(size(data.tbcell));
    similar=data.tbcell;
    data.tbcell = cell(data.nbletter,1);
    data.tbcell=similar;
    prompt=cell(1);
    answer=inputdlg(prompt);
    data.tbcell{data.nbletter,1}=answer{1,1};
    %data.tbcell{data.nbletter,2} = getaudiodata(data.rec)
    %data.rec = audiorecorder(data.Fs,data.nbits_sound,data.nbits_channel);
end;
set(data.tableau, 'Data', data.tbcell);



% Modification de sa propriété String
%set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des données modifiées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION RETRANCHER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ajouter(obj,event)

% Récupération des données stockées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
data=guidata(gcbf);

if data.isListenning==0
    %y = getaudiodata(data.tbcell{data.nbletter,2}, 'int16');
    wavplay(data.tbcell{data.nbletter,2},data.Fs);
end;
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


function ecouter(obj,event)
data=guidata(gcbf);
prompt=cell(1);
answer=inputdlg(prompt);
test=answer{1,1};
test2=data.tbcell{test,2};
wavplay(test2,data.Fs);


guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
