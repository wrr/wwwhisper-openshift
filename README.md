wwwhisper-openshift
===================

These scripts allow to easily setup your own
[wwwhisper](https://github.com/wrr/wwwhisper) authorized web
server(nginx) on the [OpenShift](https://openshift.redhat.com/app/)
platform. To give you some useful applications for a start, the
scripts setup a [Gollum](https://github.com/github/gollum) wiki, a
[Tinkerer](http://tinkerer.me/) blog and a directory for bulk
files. Initially only you are allowed to access these locations, but
wwwhisper admin interface can be used to specify emails of other users
that should be allowed access. [Mozilla
Persona](https://login.persona.org/about) is used to authenticate
visitors and prove that they own allowed emails; no site-specific
passwords are created and stored.

Installation
------------

1. [Sign up](https://openshift.redhat.com/app/) for a free OpenShift account.

2. [Install](https://openshift.redhat.com/community/get-started)
   OpenShift client tools. On many platforms it is just a matter of:

        sudo gem install rhc;
        rhc setup;

3. Choose a name for your application and create the application:

         YOUR_APP_NAME="io";
         rhc app create -t diy-0.1 -a $YOUR_APP_NAME;

4. Pull configuration scripts:

         cd $YOUR_APP_NAME;
         git remote add upstream -m master git://github.com/wrr/wwwhisper-openshift.git
         git pull -s recursive -X theirs upstream master

5. Edit ''etc/site.conf`` and enter your email address as INITIAL_ADMIN_EMAIL.

6. Push configuration files to OpenShift:

         git push

   The first push will take up to 15 minutes; the script needs to
   download, compile and install many dependencies (nginx, wwwhisper,
   Tinkerer and Gollum that requires tons of gems). When
   the push finishes point your browser to:
   https://your_app_name-your_namespace.rhcloud.com

You should see a login screen like this:

![Login prompt](https://raw.github.com/wrr/www/master/mixedbit.org/wwwhisper_screens/login_required.png)

Sign-in with your email. The welcome page contains links to installed
applications and short instructions how to use the site and grant
access to other people.


Troubleshooting
---------------

If build script failed because one of dependencies failed to download,
retry it with:

    ./misc/rebuild;

If this does not help, remove what was downloaded and rebuild from scratch:

    ./misc/start_over;
    ./misc/rebuild;
