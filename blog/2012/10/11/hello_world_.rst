Welcome!
========

.. highlight:: bash

The blog is powered by `Tinkerer <http://tinkerer.me>`_, a lightweight
and elegant static blog generator. To install Tinkerer locally
execute::

    easy_install -U Tinkerer


Customization
~~~~~~~~~~~~~

To customize the blog, go to the ``blog`` directory in your OpenShift
site repository and edit ``conf.py``. You'll likely want to modify
*project*, *tagline* and *author* settings. Next execute::

    git commit -m "Modified blog settings" -a
    git push;

Posting
~~~~~~~
Create a new post::

    tinker --post 'Title of your post'

Edit the post file. To preview the post, execute::

    tinker --build

and point your browser to the generated local version of the
blog. When you are satisfied with the post::

    git add year/month/day/post;
    git commit -m "New blog post" -a
    git push;

Do not add generated files to the git repository, deploy scripts
regenerate them on the server.

Finally, you probably want to remove the introductory post your are
reading now. Remove an appropriate entry from the ``master.rst`` file
and execute::

   git rm 2012/10/11/hello_world_.rst;
   git push;

Documentation
~~~~~~~~~~~~~

For more Tinkerer commands see
`the documentation <http://tinkerer.me/pages/documentation.html>`_.

.. author:: default
.. categories:: none
.. tags:: none
.. comments::
