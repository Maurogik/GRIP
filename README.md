<pre>
								  __________________._____________ 
								 /  _____/\______   \   \______   \
								/   \  ___ |       _/   ||     ___/
								\    \_\  \|    |   \   ||    |    
								 \______  /|____|_  /___||____|    
								        \/        \/            
</pre>

### A propos
GNU Recursive Interpretation Processor.<br>
GRIP est un interpréteur de fonctions récursives primitives écrit en LUA

### Auteurs
Gwenn Aubert et Bastien Maureille

### Version
1.0

### Date
mai 2013


Installation
------------

Le seul pré-requis pour faire fonctionner GRIP est d'avoir LUA d'installé
sur votre système. Il se trouve généralement dans le paquet 'lua'.
Sous un système debian on pourra l'installer avec la commande :
>  $ sudo apt-get install lua
  
  
Exécution
---------

Vous pouvez éxécuter GRIP en éxécutant en ligne de commande le script shell 
GRIP fourni. Si vous lui passer un fichier en paramètre qui contient des
instructions GRIP valides alors GRIP les interprétera avant de lancer 
l'interpréteur en ligne de commande.

Vous pouvez également éxécuter GRIP grâce a la commande :
>  $ lua grip.lua [fichier]
  

Utilisation
-----------
les instructions valides pour GRIP sont détaillées en tapant la commande 
> grip# help

dans l'interpréteur. La commande 'exit' permet de sortir du programme.


### Known problems

- possibility to define a predicate with more than 1 '=' character :
  pred=rio=rio is a valid instruction

- possibility to call a predicate with more than one parenthesis pair
  pred()pred() is interpretated pred(")pred(")

- not only ',' is a separator in predicates' arguments



Forkez nous !
-------------

https://github.com/Maurogik/GRIP/






<pre>

  		 			                o o"o"o"o"o"ooo o
		        			 	   o M Mo"oM M Mo"o"o"o"o"ooo
			 			         oo"o"o"o"o"o"oM M Mo"oM Mo M M
			 			       oM M M"o"oM Mo"o"o"M M M M M M"o"oo
			 			     oM M Mo"o"o"o"o"o""o"o"o"o"oM Mo"o"o"oo
			 			    M M M M M"o"M "          " "o"o"o"M Mo"oo
			 			   M M Mo"oM M "                 "o"oM M M M M
			 			 o"M M"oo"o"o                       "o"oM M"o"o
			 			 o"o"o"o""o"                        "o"o"oM M"o"
			 			 M"o"M M""                            M M M M Mo
			 			                                       "oM Mo"o"o
			 			                                       M M M Mo"o
			 			                                       o"o"o"o"o"
 			 			                                       M"o"M M"o
 			 			         o                             Mo"oM M M
			 			M""M"""M M o                          "o"o"o"o"o"
			 			o"o"oM"o"o"o  o                     "o"M M M"oM
			 			 M"o"o"o"oM M                      M M M"o"o"o"
			 			M M M Mo"o"o"o"o                o"o"o"M M Mo"o
 			 			M"o"o"o"o"M M M"o"o o  o  o" oM M Mo"o"o"o"o
			 			M M M"o"M M M"o"oM Mo"o"o"M M"o"o"oM M M"o"
			 			 M"o"oM M M"o"o"o"o"o"M M M M Mo"o"o"oM M
			 			"o"oM M M M M M"o"o"oM M"o"M M M M"o"o"
 			 			M M M Mo   " M M"o"o"o"oM M Mo"oM "
 			  			"M M Mo        " ""o"o"o"" " "
 			 			   ""o"oo


</pre>
