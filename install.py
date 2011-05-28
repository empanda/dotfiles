#!/usr/bin/env python
import os
import logging

console = logging.StreamHandler()
console.setLevel(logging.DEBUG)
console.setFormatter(logging.Formatter('%(asctime)s %(message)s'))

log = logging.getLogger(__name__)
log.setLevel(logging.DEBUG)
log.addHandler(console)

def run(command):
    log.debug(command)
    os.system(command)

def update():
    log.info('updating the dotfiles with git')
    run('git pull')
    run('git submodule init')
    run('git submodule update')
    run('git submodule foreach git submodule init')
    run('git submodule foreach git submodule update')

def install_bash():
    log.info('installing bash dotfiles')
    backup_file('bash_profile')
    backup_file('profile')
    install_file('bashrc')

def install_git():
    log.info('installing git dotfiles')
    install_file('gitconfig')
    install_file('gitignore')

def install_file(filename):
    log.info('installing the %s file', filename)
    filepath = os.path.expanduser('~/.dotfiles/%s' % filename)
    dotfile = os.path.expanduser('~/.%s' % filename)
    backup_dotfile(dotfile)
    run('ln -svf %s %s' % (filepath, dotfile))

def backup_dotfile(dotfile):
    if os.path.isfile(dotfile) and not os.path.islink(dotfile):
        log.info('backing up the %s file', dotfile)
        run('mv -vf %s %s.old' % (dotfile, dotfile))

def backup_file(filename):
    dotfile = os.path.expanduser('~/.%s' % filename)
    backup_dotfile(dotfile)


def main():
    update()
    install_bash()
    install_git()

if __name__ == '__main__':
    main()
