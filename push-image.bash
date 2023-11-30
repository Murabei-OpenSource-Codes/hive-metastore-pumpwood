source version
git add --all
git commit -m "Building a new version for Hive Metastore for Pumpwood ${VERSION}"
git tag -a ${VERSION} -m "Building a new version for Hive Metastore for Pumpwood ${VERSION}"
git push
git push origin ${VERSION}

docker push andrebaceti/hive-metastore-pumpwood:${VERSION}
