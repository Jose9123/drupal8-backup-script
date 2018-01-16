#! /bin/bash
# ------------------------------------------------------------------
# [Author] Title
#          Description
#
#          This script uses shFlags -- Advanced command-line flag
#          library for Unix shell scripts.
#          http://code.google.com/p/shflags/
#
# Dependency:
#     http://shflags.googlecode.com/svn/trunk/source/1.0/src/shflags
# ------------------------------------------------------------------
VERSION=0.1.0
SUBJECT=drupal8-backup-script
#USAGE="Usage: command -hv args"

# --- Option processing --------------------------------------------
#if [ $# == 0 ] ; then
#    echo $USAGE
#    exit 1;
#fi

#. ./shflags

#DEFINE_string 'aparam' 'adefault' 'First parameter'
#DEFINE_string 'bparam' 'bdefault' 'Second parameter'

# parse command line
#FLAGS "$@" || exit 1
#eval set -- "${FLAGS_ARGV}"

#shift $(($OPTIND - 1))

#param1=$1
#param2=$2

function get_date
{
	echo `date +%Y-%m-%d`
}


site_path="/usr/share/nginx/www/drupal8"
DATE=$(get_date)
echo "$DATE"
echo "$site_path"
# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/${SUBJECT}.lock

if [ -f "$LOCK_FILE" ]; then
echo "Script is already running"
exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE

# -- Body ---------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
#echo "Param A: $FLAGS_aparam"
#echo "Param B: $FLAGS_bparam"
#echo $param1
#echo $param2
# -----------------------------------------------------------------
cd "$site_path"
pwd
#echo "drupal-dir-backup-$DATE.tgz"
tar czf /data/drupal-dir-backup-$DATE.tgz /usr/share/nginx/www/drupal8/
drush sql-dump > /data/drupal-backup-$DATE.sql
