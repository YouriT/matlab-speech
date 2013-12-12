
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function gui_guidata_guihandles

% Création de l'objet Figure
figure('units','pixels',...
    'position',[250 250 500 500],...
    'color',[0.925 0.913 0.687],...
    'numbertitle','off',...
    'name','[GUI] Utilisation de GUIDATA',...
    'menubar','none',...
    'tag','interface');

% Création de l'objet Uicontrol Pushbutton -
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.1 0.1 0.1 0.05],...
    'string','-',...    
    'callback',@retrancher,...
    'tag','bouton_retrancher');

% Création de l'objet Uicontrol Pushbutton +
uicontrol('style','pushbutton',...
    'units','normalized',...
    'position',[0.3 0.1 0.1 0.05],...
    'string','+',...    
    'callback',@ajouter,...
    'tag','bouton_ajouter');

% Création de l'objet Uicontrol Text résultat
uicontrol('style','text',...
    'units','normalized',...
    'position',[0.1 0.2 0.3 0.05],...
    'string','0',...
    'tag','resultat');

% Génération de la structure contenant les identifiants des objects graphiques dont la 
% propriété Tag a été utilisée.

data=guihandles(gcf);

% D'après les Tag utilisés pour les objets graphiques crées précédemment, la structure data 
% contient les champs suivant :
%   data.interface
%   data.resultat
%   data.bouton_ajouter
%   data.bouton_retrancher
%

% Initialisation de la variable représentant la valeur courante du compteur nCompteur à 0
% Note : nCompteur est ici un champ de la structure data
data.nCompteur=0;

% Enregistrement de data dans les données d'application de l'objet Figure
guidata(gcf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA FONCTION PRINCIPALE%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DEBUT DE LA SOUS-FONCTION RETRANCHER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function retrancher(obj,event)

data=guidata(gcbf);
% Récupération des données stockées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)

% Diminution de la valeur de nCompteur
data.nCompteur=data.nCompteur-1;

% Modification de sa propriété String
set(data.resultat,'string',num2str(data.nCompteur));

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

% Augmentation de la valeur de nCompteur
data.nCompteur=data.nCompteur+1;

% Modification de sa propriété String
set(data.resultat,'string',num2str(data.nCompteur));

% Enregistrement des données modifiées dans les données d'application de l'objet Figure
% contenant l'objet graphique dont l'action est exécutée (gcbf)
guidata(gcbf,data)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIN DE LA SOUS-FONCTION AJOUTER%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%