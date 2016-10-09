Docker container to build ariane core and plugins

* Build

sudo docker build -t echinopsii/ariane.buildenv .


* Run 

An helper script is provided here : https://github.com/echinopsii/net.echinopsii.docker.base/tree/master/ariane.buildenv/ariane.buildenv

```
$ ./ariane.buildenv  
Usage : ./ariane.buildenv [LOCAL ARIANE SOURCE DIR] [DISTRIB COMMAND]
```

** Example [ARIANE_BUILD_HOME=LOCAL ARIANE SOURCE DIR]

```
./ariane.buildenv $ARIANE_BUILD_HOME -h
```

*** Snapshots : 

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr SNAPSHOT mno"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr SNAPSHOT mms"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr SNAPSHOT frt"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.rabbitmq SNAPSHOT SNAPSHOT"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.procos SNAPSHOT SNAPSHOT"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.docker SNAPSHOT SNAPSHOT"
```

*** Last releases : 

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr 0.8.1 mno"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr 0.8.1 mms"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr 0.8.1 frt"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.rabbitmq 0.2.7 0.8.1"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.procos 0.1.4 0.8.1"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.docker 0.1.3 0.8.1"
```
