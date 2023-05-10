#!/bin/bash

set -e

cd `dirname "$(readlink -f "$0")"`
export COLLECTION_DIR_PATH=$PWD
export PROJECTS_DIR_PATH=$PWD/../..

cd $PROJECTS_DIR_PATH/paradicms/lib/py/ssg

poetry run $PROJECTS_DIR_PATH/directory-etl-action/action.py \
  --cache-directory-path $COLLECTION_DIR_PATH/.paradicms/cache \
  --input-directory-path $COLLECTION_DIR_PATH \
  --loaded-data-directory-path $COLLECTION_DIR_PATH/.paradicms/loaded \
  --pipeline-id Thinker-Doer \
  "$@"

poetry run $PROJECTS_DIR_PATH/ssg-action/action.py \
  --cache-directory-path $COLLECTION_DIR_PATH/.paradicms/cache \
  --data-path $COLLECTION_DIR_PATH/.paradicms/loaded \
  --dev \
  --pipeline-id Thinker-Doer
