# Jacendi's overlay

[![License](http://img.shields.io/:license-gpl-green.svg)](https://tldrlegal.com/license/gnu-general-public-license-v2) [![Repoman Status](https://travis-ci.org/Jacendi/jacendi-overlay.svg?branch=master)](https://travis-ci.org/Jacendi/jacendi-overlay)

Various ebuilds, mostly idTech 1 related

# How to use: 
With layman:   
```layman -f -o https://raw.githubusercontent.com/Jacendi/jacendi-overlay/master/repositories.xml -a jacendi-overlay```  
or ```layman -a jacendi-overlay```

With repos.conf:

```[jacendi-overlay]```  
```location = <your path>```  
```sync-type = git```  
```sync-uri = https://github.com/Jacendi/jacendi-overlay```  
```auto-sync = true```
