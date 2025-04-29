git clone https://username: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@github.com/ysyyayyyayyay/SigVM
cd SigVM
pip install textual
sleep 2
python3 installer.py
docker build -t sigvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r SigVM/root/config/* Save

json_file="SigVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=SigVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=SigVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped sigvm
else
    docker run -d --name=SigVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=SigVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped sigvm
fi
clear
echo "SIGVM WAS INSTALLED SUCCESSFULLY! Check Port Tab"
