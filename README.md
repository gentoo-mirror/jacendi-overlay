# Jacendi's overlay [![ebuilds 8](https://img.shields.io/badge/ebuilds-8-639ee5.svg)](https://bitbucket.org/jacendi/jacendi-overlay/)
This is my personal Gentoo Linux overlay, which i use to maintain ebuilds for software that i'm interested in.

**Please note** that the ebuilds presented here are of experimental quality, so use it at your own risk and don't bite me if shit happens ;)

## How to add this overlay:
You can create`/etc/portage/repos.conf/jacendi-overlay.conf` file with the following contents:  


```ini
[jacendi-overlay]
location = <your path>
sync-type = git
sync-uri = https://bitbucket.org/jacendi/jacendi-overlay
auto-sync = true
```
and overlay will be added after tree sync.

#### Also you can use [eselect-repository](https://wiki.gentoo.org/wiki/Eselect/Repository)
```
eselect repository enable jacendi-overlay
```
