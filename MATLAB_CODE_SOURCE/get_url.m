function get_url(acron)

%Ouverture d'une page wiki avec l'acronyme choisi
acrUp = upper(acron);
url = 'http://en.wikipedia.org/wiki/';
path = strcat(url,acrUp);
web(path);%ouvre une page de browser avec l'adresse précisé dans le path