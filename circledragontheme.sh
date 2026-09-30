cat << 'EOF' > igneel_theme.sh
#!/bin/bash
# Installer Theme Igneel Dragons - V4 (Ultimate System & Music Player Edition)
# Support: Termux, Ubuntu, Debian, CentOS, JuiceSSH, Termius

echo -e "\e[1;36m[+] Menyiapkan Theme Igneel Dragons V4...\e[0m"

# Backup .bashrc lama (jaga-jaga)
cp ~/.bashrc ~/.bashrc.backup.igneel 2>/dev/null

# Hapus config theme igneel lama mutlak dari akar biar ga numpuk
sed -i '/# === IGNEEL THEME START ===/,/# === IGNEEL THEME END ===/d' ~/.bashrc

# Inject Theme ke .bashrc
cat << 'BASHRC_EOF' >> ~/.bashrc
# === IGNEEL THEME START ===
clear

# ==========================================
# 1. CUSTOM COMMANDS & UNINSTALLER
# ==========================================

# Command uninstall mutlak tanpa looping!
function igneel-delete() {
    echo -e "\e[1;31m[!] Membumihanguskan Theme Igneel Dragons...\e[0m"
    sed -i '/# === IGNEEL THEME START ===/,/# === IGNEEL THEME END ===/d' ~/.bashrc
    
    # Kembalikan tampilan terminal secara real-time tanpa restart bash
    export PS1="\u@\h:\w\$ "
    clear
    echo -e "\e[1;32m[+] Theme berhasil dihapus BERSIH TANPA SISA! Terminal kembali ke default pabrik.\e[0m"
}

function igneel-update() {
    echo -e "\e[1;36m[*] Mengecek pembaruan dari GitHub...\e[0m"
    echo -e "\e[1;33m[!] Silakan pasang link raw GitHub lu di source file ini!\e[0m"
}

function igneel-thanksto() {
    echo -e "\e[1;35m"
    cat << 'THANKS_BOX'
 ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮
 ┃  Pengembang   : Igneel Dragons                                          ┃
 ┃  Supporter    : VeldoraJS                                               ┃
 ┃  Friends      : Nesinez                                                 ┃
 ┃  Supporter V2 : Kaishii Furry                                           ┃
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
THANKS_BOX
    echo -e "\e[0m"
}

# ==========================================
# 2. SISTEM MUSIK (REAL-TIME STREAMING)
# ==========================================

function igneel-sound() {
    echo -e "\e[1;36m╭━━━━━━━━━━━━━━🎵 DAFTAR SOUND 🎵━━━━━━━━━━━━━━╮\e[0m"
    echo -e "\e[1;33m Format command: igplay <namasound>\e[0m"
    echo -e "\e[1;36m┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\e[0m"
    echo -e " \e[1;32msound1\e[0m - Epic Cinematic Battle (6 Menit)"
    echo -e " \e[1;32msound2\e[0m - Lofi Chill Beats (7 Menit)"
    echo -e " \e[1;32msound3\e[0m - Phonk Drift Action (5 Menit)"
    echo -e "\e[1;36m╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯\e[0m"
    echo -e " Ketik \e[1;31migstop\e[0m untuk mematikan musik yang sedang berjalan."
    echo -e " \e[1;90m(Silakan edit ~/.bashrc untuk menambah link mp3/m4a tak terbatas!)\e[0m"
}

function igplay() {
    if [ -z "$1" ]; then
        echo -e "\e[1;31m[!] Masukkan nama sound. Contoh: igplay sound1\e[0m"
        return
    fi

    # Database Link Musik Tak Terbatas (Silakan tambah sound4, sound5, dst di bawah ini)
    local URL=""
    local TITLE=""
    case "$1" in
        sound1)
            URL="https://u.pone.rs/qyvnvloy.mp3"
            TITLE="Epic Cinematic Battle"
            ;;
        sound2)
            URL="https://files.catbox.moe/ahym50.mp3"
            TITLE="Lofi Chill Beats"
            ;;
        sound3)
            URL="https://files.catbox.moe/fdasop.m4a"
            TITLE="Phonk Drift Action"
            ;;
        *)
            echo -e "\e[1;31m[!] Sound '$1' tidak ditemukan! Cek list di 'igneel-sound'\e[0m"
            return
            ;;
    esac

    # Cek ketersediaan MPV (Engine Audio Universal)
    if ! command -v mpv &> /dev/null; then
        echo -e "\e[1;31m[!] Audio engine 'mpv' belum terinstall!\e[0m"
        echo -e "\e[1;33m[+] Jalankan command ini dulu: \e[1;32mapt install mpv\e[0m (Ubuntu/Debian/Termux)"
        return
    fi

    igstop > /dev/null 2>&1
    echo -e "\e[1;32m[▶] Memutar: $TITLE...\e[0m"
    nohup mpv --no-video "$URL" > /dev/null 2>&1 &
    echo -e "\e[1;36m[!] Musik berjalan di background. Lanjut ngetik command lu! Ketik 'igstop' buat berhenti.\e[0m"
}

function igstop() {
    if pkill -f mpv > /dev/null 2>&1; then
        echo -e "\e[1;31m[■] Musik berhasil dimatikan!\e[0m"
    fi
}

# ==========================================
# 3. 15 DATA OS (HARDCORE INFO GATHERING)
# ==========================================
RED='\e[1;31m'
WHITE='\e[1;37m'
RESET='\e[0m'
COLORS=('\e[1;32m' '\e[1;33m' '\e[1;34m' '\e[1;35m' '\e[1;36m' '\e[1;92m' '\e[1;93m' '\e[1;94m' '\e[1;95m' '\e[1;96m')
RAND_C1=${COLORS[$RANDOM % ${#COLORS[@]}]}
RAND_C2=${COLORS[$RANDOM % ${#COLORS[@]}]}

SYS_OS=$(grep -w "PRETTY_NAME" /etc/os-release 2>/dev/null | cut -d '"' -f 2 || uname -s)
SYS_HOST=$(cat /sys/devices/virtual/dmi/id/product_name 2>/dev/null || getprop ro.product.model 2>/dev/null || echo "Cloud/VPS Server")
SYS_KER=$(uname -r)
SYS_ARCH=$(uname -m)
SYS_UPT=$(uptime -p 2>/dev/null | sed 's/up //')
SYS_PKG=$(dpkg-query -f '.\n' -W 2>/dev/null | wc -l || rpm -qa 2>/dev/null | wc -l || echo "N/A")
SYS_USR=$(whoami 2>/dev/null || echo "user")
SYS_SHL=$(basename "$SHELL")
SYS_TERM=$TERM
SYS_CPU=$(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | cut -d: -f2 | sed 's/^[ \t]*//' || echo "Unknown CPU")
SYS_CORE=$(nproc 2>/dev/null || echo "1")
SYS_IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "127.0.0.1")
SYS_PUB=$(curl -s ifconfig.me 2>/dev/null || echo "Hidden")
SYS_MAC=$(ip link 2>/dev/null | awk '/ether/ {print $2}' | head -n 1 || echo "Virtual")
SYS_DATE=$(date +"%d %B %Y | %H:%M:%S")

if [ -n "$(command -v free)" ]; then
    RAM_T=$(free -m | awk '/^Mem:/{print $2}')
    RAM_U=$(free -m | awk '/^Mem:/{print $3}')
    [ "$RAM_T" -gt 0 ] && RAM_PCT=$(( 100 * RAM_U / RAM_T )) || RAM_PCT=0
    RAM_INFO="${RAM_U}MB / ${RAM_T}MB"
else
    RAM_PCT=0
    RAM_INFO="Unknown"
fi

DISK_T=$(df -h / 2>/dev/null | awk 'NR==2 {print $2}')
DISK_U=$(df -h / 2>/dev/null | awk 'NR==2 {print $3}')
DISK_PCT=$(df -h / 2>/dev/null | awk 'NR==2 {print $5}' | sed 's/%//')
DISK_INFO="${DISK_U} / ${DISK_T}"

function get_bar() {
    local pct=$1; [ -z "$pct" ] && pct=0
    local fill=$(( pct / 10 )); local empty=$(( 10 - fill ))
    local bar=$(printf "%${fill}s" | tr ' ' '█'); local space=$(printf "%${empty}s" | tr ' ' '▒')
    echo -n "${bar}${space}"
}

# ==========================================
# 4. ASCII NAGA & HEADER TEXT
# ==========================================
echo -e "${RED}"
cat << 'DRAGON_TOP'
                                      ..                     ...                                    
                                 .-+#*.                        :##=:.                               
                             .-%@@@%:                           .=@@@@*..                           
                          -*@@@@@@=                               .#@@@@@%+:                        
                       :%@@@@@@@@-                                  #@@@@@@@@*.                     
                    .*@@@@@%@@@@*.             .=.                  .%@@@%@@@@@%=.                  
                  :%@@@@@@#@@@@@:            .*-.-*###*=.            =@@@@%#@@@@@@*.                
               .:%@@@@@@@*@@@@@@           :*@@@+.                   -@@@@@%%@@@@@@@+.              
              .#@@@@@@@@*@@@@@@@.       .+@@@@@@@@@:                 -@@@@@@+@@@@@@@@@+.            
            .+@@@@@@@@@%*@@@@@@@+.    .+%@@@@@@@@@@@%:              .#@@@@@@@=@@@@@@@@@%:           
           :%@@@@@@@@@@-@@@@@@@@@+    .##-:%=.:#@@@@@@+.           :%@@@@@@@@%+@@@@@@@@@@*.         
         .+@@@@@@@@@@@-+@@@@@@@@@@@#-.....    .#@@@@@@@%-.  ....:=@@@@@@@@@@@@-%@@@@@@@@@@@.        
        .#@@@@@@@@@@@*.%@@@@@@@@@@@@@@@@@@#*=+*%@@@@@@@@@#*#@@@@@@@@@@@@@@@@@@+:@@@@@@@@@@@@+.      
       -@@@@@@@@@@@@@-:@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#.+@@@@@@@@@@@@*.     
      -@@@%+-:. ..-*#.-@@@%*++*@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%*+*#@@@#..#=:.  .:=*@@@%:    
     =@#.             -@=.      -@@@@@@@%@@@@@@@@@@@@@@@@@@@@%@@@@@@@.      .##.            .=@%:   
DRAGON_TOP

echo -e "${WHITE}"
cat << 'DRAGON_BOT'
   .-=.               ::        .****%@@#@@@@@@@@@@@@@@@@@@@@%@@#***-        .:.               :+.  
                                      .#*@@@@*@@@@@@@@@@%@@@@#-.                                 .  
                                        =%@@@=@@@@@@@@@%@@@@#:                                      
                                        .#@=..=@@@@@@@@%::*@+                                       
                                        .-.   .*@@@@@@@%:  .=                                       
                                               .=@@@@@@@:                .:::--.                    
                                            :.   -%@@@@@-    ...:-:-=: *-.    .-                    
                                            .-    -@@@@@*   .-.-+++=:+:::::-.-:.                    
                                           .=.     =@@@@@. :::-...:-:==.++-=:                       
                                          -#:       %@@@@--..==*-.===---..                          
                                        .**         #@@@@+-..:.:.                                   
                                       .#%.         #@@@@-                                          
                                       =@*.         @@@@@.                                          
                                       *@#.       .#@@@@+                                           
                                       :@@#.     -%@@@@*.                                           
                                        -@@@@#%@@@@@@@=                                             
                                         .+@@@@@@@@#-.                                              
                                             .--.                                                   
DRAGON_BOT

echo -e "${RAND_C1}"
cat << 'CIRCLE_TXT'
  /$$$$$$  /$$$$$$ /$$$$$$$   /$$$$$$  /$$       /$$$$$$$$       /$$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$  /$$   /$$
 /$$__  $$|_  $$_/| $$__  $$ /$$__  $$| $$      | $$_____/      | $$__  $$| $$__  $$ /$$__  $$ /$$__  $$| $$$ | $$
| $$  \__/  | $$  | $$  \ $$| $$  \__/| $$      | $$            | $$  \ $$| $$  \ $$| $$  \ $$| $$  \__/| $$  \ $$| $$$$| $$
| $$        | $$  | $$$$$$$/| $$      | $$      | $$$$$         | $$  | $$| $$$$$$$/| $$$$$$$$| $$ /$$$$| $$  | $$| $$ $$ $$
| $$        | $$  | $$__  $$| $$      | $$      | $$__/         | $$  | $$| $$__  $$| $$__  $$| $$|_  $$| $$  | $$| $$  $$$$
| $$    $$  | $$  | $$  \ $$| $$    $$| $$      | $$            | $$  | $$| $$  \ $$| $$  | $$| $$  \ $$| $$  | $$| $$\  $$$
|  $$$$$$/ /$$$$$$| $$  | $$|  $$$$$$/| $$$$$$$$| $$$$$$$$      | $$$$$$$/| $$  | $$| $$  | $$|  $$$$$$/|  $$$$$$/| $$ \  $$
 \______/ |______/|__/  |__/ \______/ |________/|________/      |_______/ |__/  |__/|__/  |__/ \______/  \______/ |__/  \__/
CIRCLE_TXT

# ==========================================
# 5. CREDITS & ULTRA 15-SYSTEM INFORMATION
# ==========================================
echo -e "${RAND_C2}"
cat << 'INFO_BOX'
 ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮
 ┃  Pengembang   : Igneel Dragons                                          ┃
 ┃  Supporter    : VeldoraJS | Nesinez | Kaishii Furry                     ┃
 ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯
INFO_BOX

echo -e " ${WHITE}Hardware & OS Information (${RED}Full Data${WHITE}):${RAND_C2}"
echo -e " ╭━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╮"
echo -e " ┃  01. OS Platform : ${WHITE}${SYS_OS}${RAND_C2}"
echo -e " ┃  02. Host/Model  : ${WHITE}${SYS_HOST}${RAND_C2}"
echo -e " ┃  03. OS Kernel   : ${WHITE}${SYS_KER}${RAND_C2}"
echo -e " ┃  04. System Arch : ${WHITE}${SYS_ARCH}${RAND_C2}"
echo -e " ┃  05. System Up   : ${WHITE}${SYS_UPT}${RAND_C2}"
echo -e " ┃  06. Total Pkgs  : ${WHITE}${SYS_PKG} Packages${RAND_C2}"
echo -e " ┃  07. Active User : ${WHITE}${SYS_USR}${RAND_C2}"
echo -e " ┃  08. Base Shell  : ${WHITE}${SYS_SHL}${RAND_C2}"
echo -e " ┃  09. Term Env.   : ${WHITE}${SYS_TERM}${RAND_C2}"
echo -e " ┃  10. CPU Model   : ${WHITE}${SYS_CPU} (${SYS_CORE} Cores)${RAND_C2}"
echo -e " ┃  11. Local IPv4  : ${WHITE}${SYS_IP}${RAND_C2}"
echo -e " ┃  12. Public IPv4 : ${WHITE}${SYS_PUB}${RAND_C2}"
echo -e " ┃  13. Mac Address : ${WHITE}${SYS_MAC}${RAND_C2}"
echo -e " ┃  14. Date & Time : ${WHITE}${SYS_DATE}${RAND_C2}"
echo -e " ┃  15. Mem (RAM)   : ${WHITE}[$(get_bar $RAM_PCT)] ${RAM_PCT}% (${RAM_INFO})${RAND_C2}"
echo -e " ┃  16. Disk (Root) : ${WHITE}[$(get_bar $DISK_PCT)] ${DISK_PCT}% (${DISK_INFO})${RAND_C2}"
echo -e " ╰━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╯"

# ==========================================
# 6. FOOTER & PROMPT SETUP
# ==========================================
echo -e " ${WHITE}Terimakasih Telah menggunakan Theme ini"
echo -e " ${WHITE}Theme Version : ${RED}V4 (Music Edition)${RESET}"
echo -e " ${WHITE}Main Commands : ${RAND_C1}igneel-delete ${WHITE}| ${RAND_C1}igneel-update ${WHITE}| ${RAND_C1}igneel-sound${RESET}\n"

export PS1="\n\[\e[1;36m\]╭━━〔Time : \D{%H:%M} | date : \D{%d-%m-%Y} - By Igneel 〕─[\[\e[1;32m\]\u@\h\[\e[1;36m\]]─[\[\e[1;33m\]\w\[\e[1;36m\]]\n╰━━━━━━━━━━━━━ > \[\e[1;37m\]\\$ \[\e[0m\] "
# === IGNEEL THEME END ===
BASHRC_EOF

echo -e "\e[1;32m[+] Theme Igneel Dragons V4 sukses dipasang!\e[0m"
source ~/.bashrc 2>/dev/null
EOF

bash igneel_theme.sh
