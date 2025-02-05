#!/bin/bash -e

LILA_LOCATION=${LILA_LOCATION:-"../../lila"}
LILA_UI_LOCATION=${LILA_UI_LOCATION:-"../../lila/ui"}

# Build the ui if necessary
if [ ! -d "$LILA_UI_LOCATION/node_modules" ]
then
  "$LILA_UI_LOCATION"/build
fi

mongosh lichess < "$LILA_LOCATION"/bin/mongodb/indexes.js

"$LILA_LOCATION"/lila run
