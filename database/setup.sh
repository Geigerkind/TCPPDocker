get_latest_release() {
  curl --silent "https://api.github.com/repos/The-Cataclysm-Preservation-Project/TrinityCore/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}

LATEST_RELEASE=$(get_latest_release)

mkdir setup_files
cd setup_files
curl --silent "https://raw.githubusercontent.com/The-Cataclysm-Preservation-Project/TrinityCore/${LATEST_RELEASE}/sql/create/create_mysql.sql" > 00_create_mysql.sql
sed -i "s/'localhost' WITH GRANT OPTION/'%' IDENTIFIED BY 'trinity'/g" 00_create_mysql.sql

echo "USE auth;\n" > 01_auth_database.sql
curl --silent "https://raw.githubusercontent.com/The-Cataclysm-Preservation-Project/TrinityCore/${LATEST_RELEASE}/sql/base/auth_database.sql" >> 01_auth_database.sql

echo "USE characters;\n" > 02_characters_database.sql
curl --silent "https://raw.githubusercontent.com/The-Cataclysm-Preservation-Project/TrinityCore/${LATEST_RELEASE}/sql/base/characters_database.sql" >> 02_characters_database.sql

WORLD_DB_ARCHIVE=$(curl --silent "https://github.com/The-Cataclysm-Preservation-Project/TrinityCore/releases/tag/${LATEST_RELEASE}" | grep -Po "TDB_full_434.[0-9_]+.7z" | head -n 1)
curl --silent -L "https://github.com/The-Cataclysm-Preservation-Project/TrinityCore/releases/download/${LATEST_RELEASE}/${WORLD_DB_ARCHIVE}" > world_db.7z
7z x world_db.7z
rm world_db.7z

echo "USE hotfixes;" > 03_hotfixes.sql
HOTFIXES_FILE=$(ls | grep TDB_full_hotfixes)
cat ${HOTFIXES_FILE} >> 03_hotfixes.sql
rm ${HOTFIXES_FILE}

echo "USE world;" > 04_world.sql
WORLD_FILE=$(ls | grep TDB_full_world)
cat ${WORLD_FILE} >> 04_world.sql
rm ${WORLD_FILE}
