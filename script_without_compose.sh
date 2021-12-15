# Creating the networks
sudo docker network create -d bridge --subnet=172.1.1.0/24 MyBridgedNetwork
sudo docker network create -d bridge --subnet=172.2.2.0/24 BCNetwork

# Part of the web server
sudo docker run -d -it --network MyBridgedNetwork --name web nginx 

# Part for mongo
sudo docker volume create bdd
sudo docker run -d -it --network MyBridgedNetwork --mount source=bdd,destination=/bdd --name bdd mongo:4.2.2

# Part for the ether node
sudo docker volume create blockchain
sudo docker build -t geth ./eth-node
sudo docker run -d -it --network BCNetwork --mount source=blockchain,destination=/blockchain --name geth geth