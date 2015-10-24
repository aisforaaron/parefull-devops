#!/bin/bash
### BEGIN INIT INFO
# If you wish the Daemon to be lauched at boot / stopped at shutdown :
#
#    On Debian-based distributions:
#      INSTALL : update-rc.d scriptname defaults
#      (UNINSTALL : update-rc.d -f  scriptname remove)
#
#    On RedHat-based distributions (CentOS, OpenSUSE...):
#      INSTALL : chkconfig --level 35 scriptname on
#      (UNINSTALL : chkconfig --level 35 scriptname off)
#
# chkconfig:         2345 90 60
# Provides:          /app/bear-app/server.js
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: forever running /app/bear-app/server.js
# Description:       /app/bear-app/server.js
### END INIT INFO
#
# initd a node app
# Based on a script posted by https://gist.github.com/jinze at https://gist.github.com/3748766
#

if [ -e /lib/lsb/init-functions ]; then
  # LSB source function library.
  . /lib/lsb/init-functions
fi;

USER="{{ansible_user_id}}"
APPDIR="{{pfl_webapp_dir}}"
NODEAPP="{{pfl_webapp_app}}"
COMMAND="{{pfl_webapp_command}}"
APPENV="{{app_env}}"

LOGDIR="{{pfl_webapp_log_dir}}"
PIDFILE="$LOGDIR/pfl-webapp.pid"
LOGFILE="$LOGDIR/pfl-webapp.log"
ERRORLOG="$LOGDIR/pfl-webapp-err.log"

start() {
   echo "Starting $APPDIR/$NODEAPP"
   # Notice that we change the PATH because on reboot
   # the PATH does not include the path to node.
   # Launching forever with a full path
   # does not work unless we set the PATH.
   # We run the nofr commands in a subshell so we can
   # temporarily change the user.
   PATH=/usr/local/bin:$PATH
   export NODE_ENV=$APPENV
   (su - $USER -c "cd $APPDIR; forever start -a --pidFile $PIDFILE -l $LOGFILE -e $ERRORLOG -c '$COMMAND' $NODEAPP")
   RETVAL=$?
}

restart() {
  echo -n "Restarting $APPDIR/$NODEAPP"
    (su - $USER -c "cd $APPDIR; forever restart $NODEAPP")
  RETVAL=$?
}

stop() {
  echo -n "Shutting down $APPDIR/$NODEAPP"
    (su - $USER -c "cd $APPDIR; forever stop $NODEAPP")
   RETVAL=$?
}

status() {
   echo -n "Forever Status"
   (su - $USER -c "cd $APPDIR; forever stop $NODEAPP")
   RETVAL=$?
}

case "$1" in
   start)
        start
        ;;
    stop)
        stop
        ;;
   status)
        status
       ;;
   restart)
    restart
        ;;
  *)
       echo "Usage:  {start|stop|status|restart}"
       exit 1
        ;;
esac
exit $RETVAL
