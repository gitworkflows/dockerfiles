#!/usr/bin/env bash

# https://github.com/docker-library/official-images/blob/3e27b6eb7a12bc15e5e2dde52d2477c818863ce3/test/config.sh

imageTests+=(
	[docker-pkg/true]='true'

	# run containerd test on containerd-containing images :D
	[docker-pkg/containerd]='c8dind'
	[docker-pkg/docker-master]='c8dind'
	[docker-pkg/infosiftr-moby]='c8dind'
	[infosiftr/moby]='c8dind'

	# make sure our buildkit image works correctly with buildx
	[docker-pkg/buildkit]='buildkitd'

	# avoid: java.lang.UnsatisfiedLinkError: /opt/java/openjdk/lib/libfontmanager.so: libfreetype.so.6: cannot open shared object file: No such file or directory
	[docker-pkg/jenkins]='java-uimanager-font'
)

globalExcludeTests+=(
	# single-binary images
	[docker-pkg/sleeping-beauty_no-hard-coded-passwords]=1
	[docker-pkg/sleeping-beauty_utc]=1
	[docker-pkg/true_no-hard-coded-passwords]=1
	[docker-pkg/true_utc]=1
)

# run Docker tests on Docker images :D
testAlias+=(
	[docker-pkg/docker-master]='docker:dind'
	[docker-pkg/infosiftr-moby]='docker:dind'
	[infosiftr/moby]='docker:dind'
)
# the "docker-registry-push-pull" test isn't very good at detecting whether our custom image is dind or registry O:)
globalExcludeTests+=(
	[docker-pkg/docker-master_docker-registry-push-pull]=1
	[docker-pkg/infosiftr-moby_docker-registry-push-pull]=1
	[infosiftr/moby_docker-registry-push-pull]=1
)

# Cygwin looks like Unix, but fails in cute ways (host timezone instead of "UTC" because Windows, can't scrape "/etc/passwd" because --user)
globalExcludeTests+=(
	[docker-pkg/cygwin_no-hard-coded-passwords]=1
	[docker-pkg/cygwin_utc]=1
)
