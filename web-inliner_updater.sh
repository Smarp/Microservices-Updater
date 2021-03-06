# Author: Alberto Vaccari

if [[ $# -eq 0 ]] ; then
    printf 'Enter exact web-inliner version. \nUsage: web-inliner_updater <VERSION>\n'
    exit 1
fi

DOCKER="web-inliner"
VERSION=$1

printf '========================================\n'
printf "# Updating to $VERSION...\n"
printf '========================================\n'

# Stopping and removing old container
printf '# Removing old container...\n'
docker rm -f $DOCKER
printf '# Old container removed!\n'
printf '========================================\n'

printf '# Pulling new image...\n'
docker pull smarp/$DOCKER:$VERSION
printf '# New image pulled!\n'
printf '========================================\n'

# Remove old image
printf '# Removing old image and starting new one...\n'
docker rmi $(docker images | grep $DOCKER | grep -v $VERSION | awk {'print $3'}) && docker run -d -p 17654:17654 -p 18765:18765 --name $DOCKER smarp/$DOCKER:$VERSION

printf '========================================\n'
printf "# Update to $VERSION complete!\n"

printf '========================================\n'
docker rmi $(docker images | awk {'print $3'})