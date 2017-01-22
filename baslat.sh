#!/bin/bash
version=$(curl -s test.fozbek.com/oyun/version.php)
file="oyun_$version.sh"
if [ ! -f $file ]; then
  echo "Yeni sürüm: $version"
  echo "İndirme başlatılıyor..."
  sleep 1
  curl -s test.fozbek.com/oyun/version/$file -o $file
  echo "İndirme tamamlandı!"
  chmod +x $file
  sleep 1
fi
./$file $1