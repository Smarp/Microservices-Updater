# Author: Alberto Vaccari

if [[ $# -eq 0 ]] ; then
    printf 'Enter exact web-inliner version. \nUsage: web-inliner_updater <VERSION>\n'
    exit 1
fi

DOCKER="web-inliner"
VERSION=$1

printf "# Updating to $VERSION...\n"

# Stopping and removing old container
printf '# Removing old container...\n'
docker rm -f $DOCKER
printf '# Old container removed!\n'

# Remove old image
printf '# Removing old image...\n'
docker rmi $(docker images | grep $DOCKER | awk {'print $3'})
printf '# Old image removed!\n'

printf '# Pulling new image...\n'
docker pull smarp/$DOCKER:$VERSION
printf '# New image pulled!\n'

docker run -d -p 17654:17654 -p 18765:18765 --name $DOCKER smarp/$DOCKER:$VERSION

printf "# Update to $VERSION complete!\n"

docker rmi $(docker images | awk {'print $3'})