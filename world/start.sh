echo "Waiting for eventual lock..."
sleep 5s

while [[ -f "/auth/worldserver.lock" ]]; do
    echo "Waiting for copy to finish..."
    sleep 1s
done

cd /world
mkdir /TrinityCore
cp -r /world/sql /TrinityCore/

echo "Running Worldserver..."
screen -d -m -S world
screen -S world -X -p 0 stuff $'./worldserver --config ./worldserver.conf\n'
while true; do sleep 1m; done
echo "Worldserver exited..."
