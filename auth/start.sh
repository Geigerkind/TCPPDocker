echo "Waiting for eventual lock..."
sleep 5s

while [[ -f "/auth/bnetserver.lock" ]]; do
    echo "Waiting for copy to finish..."
    sleep 1s
done

cd /auth
echo "Running Bnetserver..."
screen -d -m -S auth
screen -S auth -X -p 0 stuff $'./bnetserver --config ./bnetserver.conf\n'
while true; do sleep 1m; done
echo "Bnetserver exited..."
