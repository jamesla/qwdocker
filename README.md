#Quakeworld server for Docker

##How to use
```
1. Clone this repository
git clone https://github.com/jamesla/qwdocker
cd qwdocker
2. Edit the config files in config/ktx
3. Build and run 
docker build -t "qw" . && docker run -d -p 28501:28501/udp --name "qw" -t qw
```
