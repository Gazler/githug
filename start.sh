echo ${0%/*}
pushd ${0%/*}
ruby bin/githug
popd