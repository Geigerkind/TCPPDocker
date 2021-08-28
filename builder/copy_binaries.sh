touch /auth/bnetserver.lock
cp /TrinityCore/build/src/server/bnetserver/bnetserver /auth/
cp /TrinityCore/src/server/bnetserver/bnetserver.conf.dist /auth/bnetserver.conf
sed -i "s/127.0.0.1/trinity_db/g" /auth/bnetserver.conf
rm /auth/bnetserver.lock

touch /world/worldserver.lock
cp -r /TrinityCore/sql /world/
cp /TrinityCore/build/src/server/worldserver/worldserver /world/
cp /TrinityCore/src/server/worldserver/worldserver.conf.dist /world/worldserver.conf
sed -i "s/127.0.0.1/trinity_db/g" /world/worldserver.conf
sed -i 's/DataDir = "\."/DataDir = "\/data\/"/g' /world/worldserver.conf
sed -i "s/mmap\.enablePathFinding = 1/mmap\.enablePathFinding = 0/g" /world/worldserver.conf
rm /world/worldserver.lock
