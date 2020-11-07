#!/bin/sh
set -e

TEMPLATE_FILE_NAME=${INPUT_TEMPLATEFILENAME:-"packer.json"}
VAR_LIST=${INPUT_VARLIST:-""}
VAR_FILE_NAME=${INPUT_VARFILENAME:-""}

# Set the working directory for the template
cd "${INPUT_WORKINGDIR:-.}"

# Verify files existence
if [[ ! -f "$TEMPLATE_FILE_NAME" ]] && [[ $TEMPLATE_FILE_NAME != *.json ]]; then
    echo "${TEMPLATE_FILE_NAME} does not exit in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

if [[ ! -f "$VAR_FILE_NAME" ]] && [[ $VAR_FILE_NAME != *.json ]]; then
    echo "${VAR_FILE_NAME} does not exit in the working directory (${INPUT_WORKINGDIR})"
    exit 1
fi

# Concatenate arguments list
for i in $(echo $VAR_LIST | tr "," "\n")
do
  VAR_ARGUMENTS="-var ${i} "$VAR_ARGUMENTS
done

# Add -var-file argument if exists
if [ ! -z "$VAR_FILE_NAME" ]
then
      VARFILE_ARGUMENTS="-var-file ${VAR_FILE_NAME}"
fi

CMD="packer build ${VAR_ARGUMENTS}${VARFILE_ARGUMENTS}${TEMPLATE_FILE_NAME}"

set +e
# Execute command
BUILD_OUTPUT=$(sh -c CMD 2>&1)
BUILD_SUCCESS=$?
echo "$BUILD_OUTPUT"
set -e

exit $BUILD_SUCCESS