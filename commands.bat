@ECHO OFF
pushd %~dp0
pushd git_hug
ruby ../bin/githug %*
popd
popd