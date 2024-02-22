#!/usr/bin/env zsh
source env
TIME=`date +"%Y-%m-%d-%H.%M.%S"`
if ! [[ -v TARGET ]]
then
  TARGET=${FILE}${TIME}
fi
PROGRESS=$(rsync --version | sed -n "1s/^.*version 3.[1-9].*$/--info=progress2/g;1p")
rsync -a ${PROGRESS} -e "ssh -p ${SSH_PORT}" ${PWD}/bin/keter ${USER}@${SERVER}:${TARGET} \
    && ssh -p ${SSH_PORT} ${SSH_USER}@${SERVER} "chown -R ${USER}:${GROUP} ${TARGET}\
 && rm -f ${FILE}\
 && ln -s ${TARGET} ${FILE}"
