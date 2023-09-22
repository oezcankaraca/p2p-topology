#Data senden zwischen Peers
sudo docker cp /home/ozcankaraca/Desktop/containerlab/p2p-topology/mydocument.pdf p2p-containerlab-topology-peer1:/workspace/
sudo docker exec -it p2p-containerlab-topology-peer1 /bin/sh
sudo docker exec -it p2p-containerlab-topology-peer2 /bin/sh, sudo docker exec -it p2p-containerlab-topology-peer2 /bin/sh
sudo docker exec -it p2p-containerlab-topology-peer1 /bin/sh, nc p2p-containerlab-topology-peer2 12345 < mydocument.pdf

