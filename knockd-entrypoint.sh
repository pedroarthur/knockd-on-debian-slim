#!/bin/bash -x

KNOCKD_VERBOSE="${KNOCKD_VERBOSE:=true}"
KNOCKD_DETECT_INTERFACE="${KNOCKD_DETECT_INTERFACE:=detect-interface.sh}"
KNOCKD_INTERFACE="${KNOCKD_INTERFACE:=$(detect-interface.sh)}"
KNOCKD_ARGUMENTS="${KNOCKD_XTRA_ARGS:=}"

knockd_args=( -c /etc/knockd.conf )

${KNOCKD_VERBOSE} && {
  knockd_args+=( "-D" )
  knockd_args+=( "-v" )
}

for word in ${KNOCKD_ARGUMENTS}
do
  knockd_args+=( "$word" )
done

# Drop to shell if $1 is bash or sh
if grep -qsP "^(sh|bash|knock)$" <(echo "$1")
then
  exec "${@}"
fi

exec knockd -i "$KNOCKD_INTERFACE" "${knockd_args[@]}" "${@}"

