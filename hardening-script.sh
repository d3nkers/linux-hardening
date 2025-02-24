#!/bin/bash
# Linux hardening script - simpel en praktisch
# Gemaakt door D3nkers Solutions

# Kleurcodes voor output
kleur_groen="\e[32m"
kleur_rood="\e[31m"
kleur_reset="\e[0m"

# Check of script als root wordt uitgevoerd
if [[ "$EUID" -ne 0 ]]; then
  echo -e "${kleur_rood}Dit script moet als root worden uitgevoerd!${kleur_reset}"
  exit 1
fi

# Zoek SSH-configuratiebestand
ssh_config="/etc/ssh/sshd_config"
if [[ ! -f "$ssh_config" ]]; then
  echo -e "${kleur_rood}Kan SSH-configuratiebestand niet vinden. OpenSSH lijkt niet geïnstalleerd.${kleur_reset}"
  read -p "Wil je OpenSSH installeren? (y/n) " install_ssh
  if [[ "$install_ssh" == "y" ]]; then
    apt update && apt install -y openssh-server
    if [[ ! -f "$ssh_config" ]]; then
      echo -e "${kleur_rood}Installatie voltooid, maar geen configuratiebestand gevonden.${kleur_reset}"
      exit 1
    fi
    systemctl enable ssh
    systemctl start ssh
  else
    exit 1
  fi
fi

# Firewall instellen
firewall() {
  echo -e "${kleur_groen}Firewall inschakelen...${kleur_reset}"
  ufw allow OpenSSH
  ufw enable
  echo -e "${kleur_groen}Firewall is ingeschakeld.${kleur_reset}"
}

# SSH beveiliging
beveilig_ssh() {
  echo -e "${kleur_groen}SSH configureren...${kleur_reset}"
  sed -i 's/^#Port 22/Port 2222/' "$ssh_config"
  sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' "$ssh_config"
  systemctl restart sshd 2>/dev/null || service ssh restart
  echo -e "${kleur_groen}SSH draait nu op poort 2222 en root login is uitgeschakeld.${kleur_reset}"
}

# Automatische updates inschakelen
auto_updates() {
  echo -e "${kleur_groen}Automatische updates activeren...${kleur_reset}"
  apt install -y unattended-upgrades
  echo -e "${kleur_groen}Automatische updates zijn ingeschakeld.${kleur_reset}"
}

# Terugdraaien van wijzigingen
reset_beveiliging() {
  echo -e "${kleur_rood}Wijzigingen terugdraaien...${kleur_reset}"
  ufw disable
  sed -i 's/^Port 2222/#Port 22/' "$ssh_config"
  sed -i 's/^PermitRootLogin no/#PermitRootLogin yes/' "$ssh_config"
  systemctl restart sshd 2>/dev/null || service ssh restart
  apt remove -y unattended-upgrades
  echo -e "${kleur_rood}Alles teruggezet naar standaardinstellingen.${kleur_reset}"
}

# Menu
echo -e "${kleur_groen}Linux Beveiligingsscript${kleur_reset}"
echo "1) Firewall inschakelen"
echo "2) SSH beveiligen"
echo "3) Automatische updates activeren"
echo "4) Wijzigingen terugdraaien"
echo "5) Afsluiten"
read -p "Kies een optie: " keuze

case $keuze in
  1) firewall ;;
  2) beveilig_ssh ;;
  3) auto_updates ;;
  4) reset_beveiliging ;;
  5) exit 0 ;;
  *) echo -e "${kleur_rood}Ongeldige keuze!${kleur_reset}" ;;
esac

