# Proposition de dataset

<h1>Introduction</h1>

<h2>Données</h2>

<p>Les données utilisées dans ce projet de data visualisation sont des informations sur des chansons publiées sur Spotify et Youtube. Nous avons accès à des informations générales sur chaque titre comme l'artiste et l'album ou le single dont il est issu, ainsi que des attributs comme le tempo, la duration ou encore la danceabilité. Notre jeu de données peut être répartit en trois sous-groupes : les informations générales sur le titre, les informations liées à Spotify (nombre de streams, URI,...) et les informations liées à Youtube (nombre de vues, nombres de likes, chaîne youtube,...).</p>

<h2>Origine</h2>

<p>Les données ont été collectées sur la plateforme Kaggle. Mais le dataset ne contenait pas les dates de sortie des chansons, ce qui est une information très importante. Nous avons donc utilisé l'identifiant unique de chaque chanson pour récupérer sa date de sortie grâce à l'API Spotify et la bibliothèque spotifyr de R.</p>

<h2>Raison de notre choix de données</h2>

<p>Les raisons pour lesquelles nous avons choisi ce dataset son nombreuses. Tout d'abord le dataset est assez complet et il contient aussi bien des données numériques , des données catégorielles et même des données textuelles ce qui permet de mener une analyse approfondie et solide. De plus, le dataset a deux sous groupes de données en plus des données génrales sur chaque titre : d'une part nous avons les données sur Youtube et d'autre part nous avons les données sur Spotify. Cette répartition nous permettra d'effectuer une analyse comparative des deux plateformes de streaming. Enfin , ce dataset n'est ni trop grand ni trop petit (19064 lignes) et ne sera pas donc lourd à traiter ou encore inutile. Il offre en plus de tout cela une grande flexibilité sur le type d'analyse qu'on peut mener.</p>

<h2>Format des données</h2>

<p>Les données sont représentées sous forme d'un tableau de 27 colonnes, ce qui représente les 27 attributs pour chaque chanson. Le format utilisé est le format CSV.</p>

<h2>Les varaibles du dataset</h2>

| Nom variable     | Type variable | Description                                               |
|------------------|---------------|-----------------------------------------------------------|
| Artist           | character     | Nom de l'artiste                                          |
| URL_spotify      | character     | Identifiant du titre sur Spotify                          |
| track            | character     | Le nom du titre                                           |
| Album            | character     | Le nom de l'album                                         |
| Album_type       | character     | Donne le type de l'album : single, album...               |
| Uri              | character     | Identifiant Spotify unique                                |
| Danceability     | Numeric       | Décrit à quel point une piste est adaptée à la danse      |
| Energy           | Numeric       | Mesure perçue de l'intensité et l'activité de la piste.   |
| Speechiness      | numeric       | Détecte la présence de mots parlés dans une piste         |
| Acousticness     | numeric       | Le niveau acoustique de la piste                          |
| Instrumentalness | Numeric       | se sont les sons produits uniquements par les instruments |
| Loudness         | Numeric       | sonorité globale d'une piste en décibels                  |
| Liveness         | Numeric       | Détecte la présence d'un public dans l'enregistrement     |
| Valence          | Numeric       | Décrit la positivité musicale transmise par une piste     |
| Tempo            | Numeric       | La vitesse ou le rythme de la piste                       |
| Duration         | Numeric       | Durée de la piste                                         |
| URL_youtube      | character     | URL YouTube pour accéder à la piste                       |
| Title            | character     | Titre de la piste                                         |
| Chanel           | character     | Chaine YouTube de la piste                                |
| Views            | numeric       | Le nombre de vues sur YouTube                             |
| Likes            | numeric       | Le nombre de likes                                        |
| Comments         | numeric       | Le nombre de commentaires                                 |
| Description      | character     | Description de la piste                                   |
| Licensed         | logical       | Si la musique dispose d'une licence ou non                |
| Official_video   | logical       | Si la vidéo YouTube est officielle ou non                 |
| Streaming        | numeric       | Le nombre de streams                                      |
| Date             | character     | La date de sortie de la musique                           |

<h1>Comment on compte analyser ces données ?</h1>

<p>Dans la suite, on réfère aux 'attributs des chansons' : ce sont les variables :</p>

<ul>

<li>Danceability</li>

<li>Energy</li>

<li>Key</li>

<li>Loudness</li>

<li>Speechiness</li>

<li>Acousticness</li>

<li>Instrumentalness</li>

<li>Liveness</li>

<li>Valence</li>

<li>Tempo</li>

<li>Duration_ms</li>

</ul>

<h2>Nos intérrogations à propos de ce dataset</h2>

<p><strong>1. La date de sortie d'un titre a-t-elle en effet sur le nombre de stream/views ?</strong></p>

<p>Le résultat de cette analyse est très important pour savoir si on peut utiliser la date de sortie d'un titre et/ou le nb de streams/views pour indiquer la popularité d'un titre.</p>

<p>Variables : 'Streams', 'Views', 'date'</p>

<p>Objectif : Relation avec valeurs discrètes (nombres d'écoutes) et discrètes/ordinales (dates).</p>

<p>Hypothèses :</p>

<ul>

<li>Plus un titre a été publié il y a longtemps, plus il a de views/streams.</li>

<li>Ou à l'inverse, la date de publication n'a pas une grande corrélation avec le nombre d'écoutes et donc on peut dire que ce nombre d'écoute est purement lié à la popularité du titre.</li>

<li>Peut-être qu'il n'y a pas une grande dépendance entre le nombre d'écoutes et la date de publication car le dataset est peut-être échantillonné sur des titres qui ont un nombre d'écoutes supérieur à un certain nombre et donc les 'vieilles' chansons représentées dans le jeu de données sont vraiment des chansons 'intemporelles'. Ainsi on peut donc déduire la popularité d'un titre depuis l'apparition de plateformes de streaming comme Youtube et Spotify grâce au nombre d'écoutes total.</li>

<li>On pourra faire attention aux titres publiés avant l'apparition de Youtube et/ou avant l'apparition de Spotify (plus tard que Youtube) car le résultat peut être différent en fonction de l'échantillon de titres analysé.</li>

</ul>

<p><strong>2. Y'a t'il une relation entre le nombre de streams sur Spotify et le nombre de vues sur Youtube d'une chanson ?</strong></p>

<p>Ces deux plateformes n'ont pas exactement le même but : Youtube est plus axé sur la vidéo alors que Spotify est axé sur la musique et l'audio pur. Elles n'ont aussi pas été créés en même temps : Youtube est plus ancien que Spotify. Elles ont aussi des business plan différent, Youtube est plus dépendant de publicité sur du contenu gratuit que Spotify qui compte plus sur des abonnements payant pour avoir du contenu sans publicités.</p>

<p>Variables : 'Streams', 'Views', 'date'</p>

<p>Objectif : Relation/Comparaison avec valeurs discrètes (nombres d'écoutes) et discrètes/ordinales (dates).</p>

<p>Hypothèses :</p>

<ul>

<li>On s'attend à ce que les chansons plus 'vieilles' aient plus de vues totales sur Youtube car Youtube existe depuis plus longtemps.</li>

<li>On s'attend cependant à ce que les chansons plus 'récentes' (publiées après Spotify) aient plus de streams totaux sur Spotify car il semblerait que Spotify tend à remplacer Yotube pour l'écoute de musique depuis sa création (hypothèse qu'on pourra essayer de vérifier par l'analyse aussi).</li>

</ul>

<p><strong>3. Est-ce que les singles sont plus écoutés/appréciés des auditeurs que les albums ?</strong></p>

<p>Rappel : Les valeurs possibles pour la variable 'Album_type' sont album, single et compilation.</p>

<p>Variables : 'Streams', 'Views', 'Album_type', 'Likes', 'Comments'</p>

<p>Objectif : Comparaison avec valeurs discrètes et nominales (album_type).</p>

<p>Hypothèses :</p>

<ul>

<li>On s'attend à ce que les singles soit plus écoutés que les albums de manière générale.</li>

<li>On ne sait pas trop à quoi s'attendre pour les compilations</li>

</ul>

<p><strong>4. Y-a-t-il un lien entre les différents attributs des chansons et leur popularité ?</strong></p>

<p>On pourra par exemple aussi ajouté la comparaison avec la valeurs moyenne des attributs en fonction du nombre d'écoutes/la popularité.</p>

<p>Variables : attributs, 'Streams', 'Views', 'Likes', 'Comments'</p>

<p>Objectif : Relation + Comparaison avec valeurs discrètes (nombres d'écoutes) et continues (attributs).</p>

<p>Hypothèses :</p>

<ul>

<li>On peut s'attendre à ce que les titres avec plus de mots parlés soient plus populaires.</li>

<li>On peut aussi s'attendre à avoir une répartition avec beaucoup de titres 'lives' avec très peu d'écoutes mais aussi beaucoup avec un grand nombre d'écoutes car c'est un attribut dans une chanson qui peut être plus tranchant pour les auditeurs. On suppose que beaucoup de gens adorent la musique 'live' mais aussi beaucoup de gens la détestent aussi.</li>

</ul>

<p><strong>5. Quel est le lien entre le nombre de commentaires et/ou le nombre de likes et le nombre d'écoutes d'un titre ?</strong></p>

<p>On peut faire l'analyse pour le nombre d'écoutes total, le nombre de vues (Yt) et le nombre de streams (Spot.).</p>

<p>Variables : 'Streams', 'Views', 'Likes', 'Comments'</p>

<p>Objectif : Relation avec valeurs discrètes.</p>

<p>Hypothèses :</p>

<ul>

<li>On suppose qu'on pourra repérer un seuil de nombres d'écoutes à partir duquel la quantité de like et/ou commentaires augmentent fortement. En bref, le signal à partir de ce seuil passerait de linéaire à exponentiel.</li>

<li>Cette hypothèse vient du fait que nous supposons qu'à partir de cette valeur seuil, il y a assez d'engouement pour un titre pour qu'il "fasse le buzz".</li>

<li>On a pensé à cette valeur seuil car les algorithmes de recommandation de Youtube cherchent à "faire buzzer" des vidéos (du peu que nous connaissons de ces algorithmes du côté utilisateur).</li>

</ul>

<p><strong>6. Est-ce possible de discerner des 'modes' en termes d'attributs de chansons en fonction du temps ?</strong></p>

<p>Par exemple : le rap qui était à la mode à une période donnée et donc plus de titres avec les attributs 'Speechiness' élevé et 'Instrumentalness' faible.</p>

<p>Il s'agit donc ici d'essayer de repérer des intervalles de valeurs communes pour les attributs des titres d'une même période.</p>

<p>Variables : attributs, 'date'</p>

<p>Objectif : Relation + Evolution (+ distribution/statistique) avec valeurs continues (attributs) et ordinales (dates qu'on catégorisera en périodes : intervalles de dates).</p>

<p>Hypothèses :</p>

<ul>

<li>On s'attend à ce qu'on retrouve des intervalles de valeurs pour les attributs qui auront une densité légèrement plus élevée : il sera cependant probablement difficile de raccorder ces données à un genre précis de musique comme le rap donné en exemple.</li>

<li>La difficulté avec cette question/analyse est que sans savoir ce qu'on cherche, il sera peut-être difficile de repérer des schémas/patterns pour les attributs des chansons en fonction de la période. Il est donc possible que notre analyse soit difficilement conclusive.</li>

</ul>

<p><strong>7. Est-ce qu'on peut reconnaître un artiste / un album par une combinaison d'intervalles pour chaque attribut ?</strong></p>

<p>Cette question est très similaire à la précédente (q6) sauf que nous étudions les artistes / albums au lieu de périodes.</p>

<p>Variables : 'Artist', 'Album', attributs</p>

<p>Objectif : Relation + Comparaison + Distribution avec valeurs continues (attributs) et nominales (artistes, albums).</p>

<p>Hypothèses :</p>

<ul>

<li>Nous avons à peu près les mêmes hypothèses que la question précédente.</li>

<li>On aura probablement les mêmes difficultés aussi.</li>

</ul>

<p><strong>8. Sur youtube, est-ce que la distinction officiel/pas officiel a un effet sur les écoutes ? / les likes ? / les commentaires ?</strong></p>

<p>Variables : 'Official_video', 'Views', 'Likes', 'Comments'</p>

<p>Objectif : Relation avec valeurs discrètes (nombres d'écoutes, likes, ...) et nominales (official_video).</p>

<p>Hypothèses :</p>

<ul>

<li>Il semblerait que le jeu de données ne propose pas de vidéos officielles et des vidéos non officielles pour un même titre donc on peut supposer que si la vidéo d'une chanson n'est pas officielle, il n'existe probablement pas de vidéo officielle.</li>

<li>On s'attend donc à ce qu'il n'y ai pas de grande différence entre les écoutes / likes / commentaires des vidéos officielles et non officielles.</li>

</ul>

<p><strong>9. Est-ce que la fréquence de diffusion d'album / de single d'un artiste peut avoir un effet sur sa popularité ?</strong></p>

<p>On peut commencer par faire l'analyse indépendemment du type de l'album, mais on a trouvé cela pertinent d'aussi voir si cette variable a un effet sur nos résultats.</p>

<p>Variables : 'Streams', 'Views', 'Artist', 'Album-type', 'date' pour obtenir la fréquence</p>

<p>Objectif : Relation avec valeurs discrètes (nombres d'écoutes), nominales (artistes, type d'albums) et continues (fréquence).</p>

<p>Hypothèses :</p>

<ul>

<li>On suppose que d'avoir une fréquence plus élevée de publication de titres est liée à la popularité d'un artiste. Ceci repose sur l'hypothèse que le simple fait de publier donne de l'engouement naturel à un artiste : surtout qu'ils communiquent autour de leurs publication généralement.</li>

<li>Le format des single cherche plus à apporter de l'engouement pour un artiste en règle générale : peut-être que si un artiste publie souvent des singles, il aura plus d'écoutes ?</li>

</ul>

<p><strong>10. Quels sont les effets d'un 'feat' sur un titre ?</strong></p>

<p>Un 'featuring' en musique indique dans le titre de la chanson que celle-ci est une collaboration entre l'auteur et l'artiste featuré.</p>

<p>Variables : 'Streams', 'Views', 'track', 'Artist'</p>

<p>Objectif : Relation avec valeurs discrètes (nombres d'écoutes) et nominales (track, artistes).</p>

<p>Hypothèses :</p>

<ul>

<li>On s'attend à ce qu'en général, les titres avec des 'feat' soient plus populaires que ceux sans, surtout au sein des chansons d'un même artiste.</li>

</ul>

<p><strong>11. Y-a-t-il un lien entre les valeurs des différents attributs comme 'danceability' et 'energy' ?</strong></p>

<p>Variables : attributs</p>

<p>Objectif : Relation + Comparaison avec valeurs continues (attributs).</p>

<p>Hypothèses :</p>

<ul>

<li>On s'attend à ce qu'il y ai des liens plus forts entre certains attributs qu'avec d'autres.</li>

</ul>

<p><strong>12. comment est-ce que la durée des différentes chanson a évoluée avec le temps </strong></p>
<p>Variables : année, durée</p>
<p>Objectif : comparaison + évolution (attributs).</p>
<p>Hypothèses :</p>
de manière générale , il  est facile de se rendre compte que les chasons qui qui sortaient au paravant étaient deux fois plus longues
que celles qui sortent actuellement d'ailleurs la longueur des chanson se réduit de plus en plus. En effet , les chansons allaient jusqu'à 7 minutes
et maintenant elles tournnent autour de 3 minutes. 
<ul>
  <li>on s'attend donc à une visualisation sur laquelle on pourra remarqué que pour les décénies , les plus éloignée on aura beaucoup plus de chanson avec 
    une durée relativement forte , tandis que avec l'évolution du temps , la répartition changera et on aura beaucoups plus de chanson de faible durée.</li>
</ul>


<foot>Proposition de Dataset - IF36 - Zoé Boutin, Brian Diffo Diffo, Hanxiao Sun, He Huang</foot>
