sudo apt update
sudo apt install -y docker.io docker-compose
sudo usermod -aG docker ${USER}
echo ""
echo "Done! Exit the instance and login again, please!"