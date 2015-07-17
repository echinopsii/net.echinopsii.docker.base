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

```
./ariane.buildenv $ARIANE_BUILD_HOME "distpkgr 0.6.2"
```

```
./ariane.buildenv $ARIANE_BUILD_HOME "pluginpkgr ariane.community.plugin.rabbitmq 0.2.2 0.6.2"
```
