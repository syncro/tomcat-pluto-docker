# Pluto Portal Tomcat docker pack 

## Building
Put your war's into deployments folder

**/deployments/teststruts-1.0-SNAPSHOT.war**

and pluto discributon build from source 

**docker/pluto-2.1.0-M3-bundle.tar.bz2**

**docker/pluto-3.1.1-SNAPSHOT-bundle.tar.bz2**

ensure docker files uses local distribution or try to go with downloaded from github

To build image with pluto2 (currently not working) run (try with sudo if no luck)
```
docker build .
```
To go with pluto3:
```
docker build -f Dockerfile.pluto3 .
```
Successful logs will provide you with image id.
To run builded container:
```
docker run -it -p 8080:8080 -d ${imageId}
```