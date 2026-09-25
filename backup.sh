#!/bin/bash
src="/home/jaswanth/projects"
dest="/home/jaswanth/backups"
archive="$dest/project_$(date +%F).tar.gz"
log="$dest/backup.log"

# Backup
rsync -av $src $dest/temp
tar -czvf $archive $dest/temp
rm -rf $dest/temp

# Disk check
usage=$(df -h / | awk 'NR==2 {print $5}')
echo "Backup completed at $(date). Disk usage: $usage" >> $log

# Alert if usage > 80%
if [[ ${usage%\%} -gt 80 ]]; then
  echo "Warning: Disk usage high ($usage)" >> $log
fi

