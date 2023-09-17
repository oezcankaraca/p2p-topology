Erstellung von Dockerfile
docker build -t p2p-image .
Erstellung von YAML Datei
sudo containerlab deploy -t containerlab-topology.yml
sudo containerlab inspect -a
sudo containerlab destroy -t containerlab-topology.yml
