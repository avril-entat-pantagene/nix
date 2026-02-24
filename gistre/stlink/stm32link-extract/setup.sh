#!/bin/bash

thisdir=$(readlink -m $(dirname $0))

set -e
err_handler(){
	echo >&2 "Error installing stlink-server"
	exit 1
}

trap err_handler ERR
trap $thisdir/cleanup.sh EXIT

help() {
	echo "$0 usage:"
	echo "$0 [-f]"
	echo "   -f: do not check for downgrade"
}

# Ask user to agree on license
bash $thisdir/prompt_linux_license.sh
if [ $? -ne 0 ]
then
	exit 1
fi


stls_dir=/usr/bin
stls_abs_path=$stls_dir/stlink-server

# Arguments check
downgrade_check=1

case "$1" in
'')
	;;
-f)
	downgrade_check=
	;;
-h)
	help
	exit 0
	;;
*)
	help
	exit 1
	;;
esac

# Get version to be installed
set junk  $(./stlink-server 2>&1 -v)
tobe_installed_version_string=$3
# Below, strip off potential git describe string and 'v' prefix
tobe_installed_version=$(echo ${3%%-g*}|sed 's/^v//')
tobe_installed_timestamp=$4

echo "stlink-server $tobe_installed_version_string $tobe_installed_timestamp installation started."

if [ "$downgrade_check" -a -x $stls_abspath ] ; then
	# Check we do not downgrade already installed stlink-server
	downgrade_attempt=

	# Get already installed stlink-server version
	set junk  $($stls_abs_path 2>&1 -v)
	installed_version_string=$3
	# Below, strip off potential git describe string and 'v' prefix
	installed_version=$(echo ${3%%-g*}|sed 's/^v//')
	installed_timestamp=$4

	if [ "$installed_version" = "$tobe_installed_version" ]; then
		# If versions are the same then rely on timestamp
		newest_timestamp=$(
			(
				echo $installed_timestamp
				echo $tobe_installed_timestamp
			) |sort|tail -1
		)
		if [ "$newest_timestamp" = "$installed_timestamp" ]; then
			downgrade_attempt=yes
		fi
	else
		# Compare versions (without v prefix) sort -V (version-sort) not present on all linux so use sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n
		newest_version=$(
			(
				echo $installed_version
				echo $tobe_installed_version
			) |sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n|tail -1
		)
		if [ "$newest_version" = "$installed_version" ]; then
			downgrade_attempt=yes
		fi
	fi

	if [ "$downgrade_attempt" ]; then
		echo "Already installed version is newer or equal: $installed_version_string $installed_timestamp"
		echo "NOT downgrading. Aborting stlink-server installation."

		# This is not considered as a failure. Global installation must continue.
		exit 0
	fi

fi

# Finally, perform installation
echo "Stopping stlink-server (if any)..."
killall stlink-server -q || true
cp stlink-server $stls_dir
chmod 0755 $stls_abs_path
chown root:root $stls_abs_path

echo "Installation done."
exit 0
