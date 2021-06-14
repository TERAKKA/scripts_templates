!/bin/bash
#
cd /var/emptyFolder
DATE=$(date +%Y%m%d)
#
cd /mnt/backupSQL/base
#
DB=base
pg_dump -U postgres -Fc $DB > ./$DATE-$(date +%H_%M)-$DB.pgsql.backup
#
find . -mtime +4 -exec rm {} \;
exit 0
