wwwhisper-openshift
===================

Work in progress, please come back in few days.

These scripts allow to easily setup your own wwwhisper authorized web
server(nginx) on the OpenShift plaftorm. To give you some useful
applications for a start, the scripts setup a Gollum wiki, a Tinkerer
blog and a directory for bulk files. Initially only you will be able
to access these locations, but you can use wwwhisper admin interface
to specify emails of other users that should be allowed
access. Mozilla Persona is used to authenticate visitors and prove
that they own allowed emails; no site-specific passwords are created
and stored.

Installation
------------

1. [Create a free OpenShift account](https://openshift.redhat.com/app/).

2. [Install OpenShift client
tools](https://openshift.redhat.com/community/get-started)
On many platforms it is just a matter of:

    sudo gem install rhc;
    rhc setup;

3. Choose some name for your application and create it:

    YOUR_APP_NAME="io";
    rhc app create -t diy-0.1 -a $YOUR_APP_NAME;

4. Pull configuration scripts

    cd $YOUR_APP_NAME;
    git remote add upstream -m master git://github.com/wrr/wwwhisper-openshift.git
    git pull -s recursive -X theirs upstream master

5. Edit ''etc/site.conf`` and enter your email address as INITIAL_ADMIN_EMAIL

6. Push configuration files to OpenShift:

    git push

   The first push will take upto 15 minutes; the scripts need
   to download, compile and install many dependencies (nginx, tinkerer
   and especially gollum that requires tons of gems). When the push
   finishes point your browser to:
   https://your_app_name-your_namespace.rhcloud.com

You should be welcome with a login screen like this:

![Login prompt](https://raw.github.com/wrr/www/master/mixedbit.org/wwwhisper_screens/login_required.png)

Sign-in with your email. The welcome page contains links to installed
applications and short instructions how to modify the site.


Troubleshooting
---------------

If build script failed because one of dependencies failed to download, reexecute it with:

    ./misc/rebuild;

If this does not help, remove what was downloaded and rebuild from scratch:

    ./misc/start_over;
    ./misc/rebuild;
