# Author: Alberto Vaccari

if [[ $# -eq 0 ]] ; then
    printf 'Enter exact thumbor version. \nUsage: thumbor <VERSION>\n'
    exit 1
fi

DOCKER="thumbor"
VERSION=$1

printf '========================================\n'
printf "# Updating to $VERSION...\n"
printf '========================================\n'

# Stopping and removing old container
printf '# Removing old container...\n'
docker rm -f $DOCKER
printf '# Old container removed!\n'
printf '========================================\n'

# Remove old image
printf '# Removing old image...\n'
docker rmi $(docker images | grep $DOCKER | awk {'print $3'})
printf '# Old image removed!\n'
printf '========================================\n'

printf '# Pulling new image...\n'
docker pull smarp/$DOCKER:$VERSION
printf '# New image pulled!\n'
printf '========================================\n'

docker run -d -p 28765:28765 --name $DOCKER smarp/$DOCKER:$VERSION

printf '========================================\n'
printf "# Update to $VERSION complete!\n"

printf '========================================\n'
docker rmi $(docker images | awk {'print $3'})