wwwhisper-openshift
===================

These configuration files allow to easily setup your own
[wwwhisper](https://github.com/wrr/wwwhisper) authorized web
server(nginx) on the [OpenShift](https://openshift.redhat.com/app/)
platform. To give you some useful applications for a start, the
scripts setup a [Gollum](https://github.com/github/gollum) wiki, a
[Tinkerer](http://tinkerer.me/) blog and a directory for bulk
files. Initially only you are allowed access to these locations, but
you can use wwwhisper to grant access to other people. [Mozilla
Persona](https://login.persona.org/about) is used to authenticate
visitors and prove that they own allowed emails; no site-specific
passwords are created and stored.

Preview
-------

Visit [a demo site](https://io-mixedbit.rhcloud.com/). The site is
configured to allow everyone access. If you want
to see the demo but don't want to create a real Persona account,
sign-in with an address like: PutAnythingHere@mockmyid.com (Such
addresses use [mock Persona id](https://mockmyid.com/) and should not
be used for anything important).

You can also check [a demo version of the admin
UI](http://mixedbit.org/admin_demo/).

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
        git remote add upstream -m master git://github.com/wrr/wwwhisper-openshift.git;
        git pull -s recursive -X theirs upstream master;

5. Edit `./etc/site.conf` and enter your email address as
   `INITIAL_ADMIN_EMAIL`. Commit the change:

        git commit -m "Set initial admin email" -a;

6. Push configuration files to OpenShift:

        git push origin master;

   The first push will take up to 15 minutes; a build script executed
   on OpenShift needs to download, compile and install many
   dependencies (nginx, wwwhisper, Tinkerer and Gollum that requires
   tons of gems).


When the push finishes point your browser to
*https://your_app_name-your_namespace.rhcloud.com*. You should see
a login screen like this:

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
