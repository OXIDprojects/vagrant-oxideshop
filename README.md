Vagrant OXID eShop CE
=====================

OXID eShop Community Edition development configuration for Vagrant together with LAMP environment.

Ver: 0.1

Installation:
-------------

Download and Install [VirtualBox](http://www.virtualbox.org/)

Install [vagrant](http://vagrantup.com/)

Register your vm to known host names by adding this line to your hosts file:

    47.47.47.47 oxideshop local.dev

Clone this repository.

    $ git clone https://github.com/tomasliubinas/vagrant-oxideshop.git

Go to the repository folder (the one where your Vagrantfile is located) and launch the box

    $ cd [your vagrant dir]
    $ vagrant up

That's it your OXID eShop is ready under http://oxideshop/ !    
    
     
What's inside:
--------------

Installed software:

* OXID eShop CE
* Apache
* MySQL
* php
* phpMyAdmin
* Xdebug with Webgrind
* zsh with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* git, subversion
* mc, vim, screen, tmux, curl
* [MailCatcher](http://mailcatcher.me/)
* [Composer](http://getcomposer.org/)
* [Drush](http://drupal.org/project/drush)

Notes
-----

### VM

By default vm is accessible from your machine on IP 47.47.47.47. You can access it over HTTP:

http://oxideshop/ or http://local.dev/

You can SSH to it over port 2222:

    $ ssh vagrant@127.0.0.1:2222

SSH login: vagrant:vagrant

Or simply by the command in your vagrant dir:

    $ vagrant ssh


### OXID eShop CE

OXID eShop is fully installed on:

    http://oxideshop/

Admin area:

    http://oxideshop/admin/

Admin login: admin:admin

The OXID eShop source code is available on your host machine:
    
    [vagrant dir]/public/oxideshop/

TODO:
- Possibility to run Unit tests
- Possibility to configure default shop language from the chef cookbook.
- Possibility to configure default shop language from the chef cookbook.


### Apache virtual hosts

You can add virtual hosts to apache by adding a file to the `data_bags/sites`
directory. A docroot will be created automatically in the `public` folder, or 
you may specify a docroot explicitly by adding a docroot key in the json file.  

### phpMyAdmin

phpMyAdmin is available on every domain. For example:

    http://oxideshop/phpmyadmin

### XDebug and webgrind

XDebug is configured to connect back to your host machine on port 9000 when 
starting a debug session from a browser running on your host. A debug session is 
started by appending GET variable XDEBUG_SESSION_START to the URL (if you use an 
integrated debugger like Eclipse PDT, it will do this for you).

XDebug is also configured to generate cachegrind profile output on demand by 
adding GET variable XDEBUG_PROFILE to your URL. For example:

    http://oxideshop/index.php?XDEBUG_PROFILE

Webgrind is available on each domain. For example:

    http://oxideshop/webgrind

It looks for cachegrind files in the `/tmp` directory, where xdebug leaves them.

**Note:** xdebug uses the default value for xdebug.profiler_output_name, which 
means the output filename only includes the process ID as a unique part. This 
was done to prevent a real need to clean out cachgrind files. If you wish to 
configure xdebug to always generate profiler output 
(`xdebug.profiler_enable = 1`), you *will* need to change this setting to 
something like
 
    xdebug.profiler_output_name = cachegrind.out.%t.%p
    
so your call to webgrind will not overwrite the file for the process that 
happens to serve webgrind. 

### Mailcatcher

PHP is configured to send mail via MailCatcher, so you can see the emails that 
the vagrant box generates. The Web frontend for MailCatcher is running on port 
1080 and also available on every domain:

    http://oxideshop:1080

### Composer

Composer binary is installed globally (to `/usr/local/bin`), so you can simply call `composer` from any directory.