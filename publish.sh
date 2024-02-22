#!/usr/bin/env zsh
set -euo pipefail
source env
export LC_ALL=C
TIME=`date +"%Y-%m-%d-%H.%M.%S"`
if ! [[ -v TARGET ]]
then
  TARGET=${FILE}${TIME}
fi
PROGRESS=$(rsync --version | sed -n "1s/^.*version 3.[1-9].*$/--info=progress2/g;1p")
rsync\
  -a ${PROGRESS}\
  -e "ssh -p ${SSH_PORT} ${JUMP_HOST:+-J} ${JUMP_HOST:+"${JUMP_HOST}"}"\
  ${PWD}/bin/keter\
  ${USER}@${SERVER}:${TARGET}
ssh \
  -p ${SSH_PORT}\
  ${JUMP_HOST:+-J} ${JUMP_HOST:+"${JUMP_HOST}"}\
  ${SSH_USER}@${SERVER}\
  "chown -R ${USER}:${GROUP} ${TARGET}\
 && rm -f ${FILE}\
 && ln -s ${TARGET} ${FILE}"
