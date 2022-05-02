# Install Docker and Docker Compose on Ubuntu 22.04

Uninstall old versions

``` sh
sudo apt remove docker docker-engine docker.io containerd runc
pip3 uninstall docker-compose
```

Install dependencies

``` sh
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg lsb-release
```

Add Dockers signing key

``` sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Add Dockers repository

``` sh
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable test" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Install Docker

``` sh
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
```

Install Docker Compose

``` sh
sudo curl -L -o ./docker-compose "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-"$(uname -m)
sudo chmod +x /usr/libexec/docker/cli-plugins/docker-compose
```

Test your installation

``` sh
docker version
docker compose version
docker run hello-world
```
