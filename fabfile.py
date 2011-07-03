from fabric.api import run, abort, task, settings, hide, env, cd
from fabric.contrib.files import exists
from fabric import colors

env.dotfiles = '.dotfiles'
env.repo = 'git://github.com/empanda/dotfiles.git'

@task
def install():
    """Install these dotfiles on a host."""
    require_cmd('git')
    require_cmd('python')

    if exists(env.dotfiles):
        fail('This host already has a ~/%s directory. Maybe you just need to upgrade.' % env.dotfiles)

    run('git clone %s %s' % (env.repo, env.dotfiles))
    with cd(env.dotfiles):
        run('python install.py')

@task
def update():
    """Update these dotfiles on a host."""
    if not exists(env.dotfiles):
        fail('This host does not have a ~/%s directory. Maybe you need to install.' % env.dotfiles)

    with cd(env.dotfiles):
        run('python install.py')

@task
def all_hosts():
    """Set the hosts to all the hosts I have accounts on."""
    env.hosts = [
        'johann@orion.phyfus.com',
        'johann@acr.webcollective.coop',
        'johann@balle.webcollective.coop',
        'johannh@tekoa.webcollective.coop',
        'johannh@yacolt.webcollective.coop',
        'johannh@wapato.webcollective.coop',
        'johannh@moxee.webcollective.coop',
        'johannh@zillah.webcollective.coop',
        'johann@ci.webcollective.coop',
    ]


# Helpers

def fail(msg):
    """Abort with a message in red."""
    abort(colors.red(msg))

def get_return_code(cmd):
    """Get the return code for a command."""
    with settings(hide('warnings'), warn_only=True):
        result = run(cmd)
    return result.succeeded

def test_cmd(cmd):
    """Return whether a command is available."""
    return get_return_code('command -v %s' % cmd)

def require_cmd(cmd):
    """Ensures that a command is available."""
    if not test_cmd(cmd):
        fail('The "%s" command is required on the remote host.' % cmd)
