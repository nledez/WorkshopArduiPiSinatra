WorkshopArduiPiSinatra
======================

Prérequis
---------

Installer un Raspbery π tout frais avec une http://www.raspberrypi.org/downloads[Raspbian].
Savoir se connecter en SSH sur une machine.

    ssh pi@ip-de-mon-raspberypi

Ça marche aussi en direct sur la console. Mais c'est moins facile de faire de copier/coller (certains comprendons).

Vérifier 2/3 trucs
------------------

Quelques commandes à taper pour voir si tout marche :

    pi@raspberrypi ~ $ which ruby
    /usr/bin/ruby
    pi@raspberrypi ~ $ which gem
    /usr/bin/gem
    pi@raspberrypi ~ $ ruby -v
    ruby 1.9.3p194 (2012-04-20 revision 35410) [arm-linux-eabihf]
    pi@raspberrypi ~ $ gem -v
    1.8.23

Faire la mise à jour de tout ça avant de démarrer
-------------------------------------------------

    sudo apt-get update
    sudo apt-get dist-upgrade

Comment installer tout ça
-------------------------

Mettre au début du fichier "~/.bashrc" (juste avant "[ -z "$PS1" ] && return") :

    export PATH="$HOME/.gem/ruby/1.9.1/bin:/usr/lib/rubies/ruby-2.0.0/bin:$PATH"
    export GEM_HOME=$HOME/.gem/ruby/1.9.1

Créer un fichier "~/.gemrc" avec :

    gem: --no-rdoc --no-ri

Les deux fichiers sont fournis en exemple.

Se déconnecter puis se reconnecter (pour recharger le fichier .bashrc)

Exécuter :

    gem install bundler
    git clone https://github.com/nledez/WorkshopArduiPiSinatra.git
    cd WorkshopArduiPiSinatra
    bundle

Maintenant, pour lancer le serveur :

    bundle exec ruby 01-get-temp.rb

Pour connaitre, les arguments acceptés par le serveur :

    bundle exec ruby 00-hello.rb -h

Donc par exemple, pour que le serveur soit accessible par son adresse IP "externe" :

    bundle exec ruby 00-hello.rb -o 0.0.0.0

Ou :

    RACK_ENV=production bundle exec ruby 01-get-temp.rb

À chaque fois que l'un des fichiers "Gemfile*" change, il faut prendre en compte les modifications avec la commande :

    bundle install
    
Ou son raccourci :

    bundle

Pour fonctionner avec Nginx
---------------------------

    apt-get install nginx
    /etc/init.d/nginx start
    cd /etc/nginx/sites-enabled/
    rm default
    ln -s /home/pi/WorkshopArduiPiSinatra/WorkshopArduiPiSinatra-site-nginx.conf .
    /etc/init.d/nginx restart
    bundle exec unicorn -c /home/pi/WorkShopArduiPiSinatra/config/unicorn.rb -E production -D

Pour l'autentification
----------------------

    apt-get install -y apache2-utils
    htpasswd -cb /home/pi/htpasswd temp temp
    htpasswd -b /home/pi/htpasswd temp tempo
