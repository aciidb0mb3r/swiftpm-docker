# Ubuntu 14.04 Docker image for SwiftPM

* Clone the repo.

* Build the image:

        docker build -t swiftpm-docker .

* Create a shared volume to keep swiftpm builds:

        docker create -v /build --name spm-build swiftpm-docker /bin/true

* Build (and test) SwiftPM inside the shared volume:

        docker run -itv $(pwd):/swiftpm --volumes-from spm-build swiftpm-docker /swiftpm/Utilities/bootstrap test --build /build

* Run any other package using previously built SwiftPM:

        docker run -itv $(pwd):/pkg --volumes-from spm-build swiftpm-docker /build/debug/swift-build -C /pkg

* Delete all containers:

        docker rm $(docker ps -a -q)

* List images:

        docker images

* Delete images:

        docker rmi <id>

Note: Add `-d` to demonize a container, `--rm` to remove the container on exit.
