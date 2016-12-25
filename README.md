#Quakeworld server for Docker

##How to use
```
git clone https://github.com/jamesla/qwdocker
```
```
docker build -t "qw" . && docker run -d -p 28501:28501/udp --name "qw" -t qw
```
