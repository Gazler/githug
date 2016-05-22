pushd ${0%/*} >/dev/null
pushd ./git_hug >/dev/null
ruby ../bin/githug
popd >/dev/null
popd >/dev/null