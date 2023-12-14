source version

# Process all Java dependencies
mvn package
docker build -t andrebaceti/hive-metastore-pumpwood:$VERSION .
