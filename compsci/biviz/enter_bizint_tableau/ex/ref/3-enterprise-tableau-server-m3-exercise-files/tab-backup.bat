
tabadmin stop
tabadmin ziplogs -l -n -f c:\tableau-backups\logs.zip
tabadmin backup c:\tableau-backups\benstableau.tsbak -d
tabadmin cleanup
tabadmin start
tabadmin cleanup

exit