# Linux Hardening Script

## Over dit project
Een simpel Bash-script om je Linux-systeem te beveiligen met basismaatregelen. Dit script helpt beginnende Linux-gebruikers om snel een aantal essentiële beveiligingsinstellingen toe te passen.

**Belangrijk:** Dit script is geen complete beveiligingsoplossing, maar biedt een goede eerste stap richting een veiliger Linux-systeem.

## Functionaliteiten
✅ **Firewall configureren** (UFW inschakelen en OpenSSH toestaan)  
✅ **SSH beveiligen** (Poort wijzigen en root-login uitschakelen)  
✅ **Automatische updates inschakelen**  
✅ **Eenvoudig terugdraaien van wijzigingen** als er iets misgaat  

## Installatie en gebruik
1. **Download het script:**  
   ```bash
   git clone https://github.com/d3nkers/linux-hardening.git
   cd linux-hardening
   ```
2. **Maak het script uitvoerbaar:**  
   ```bash
   chmod +x hardening-script.sh
   ```
3. **Voer het script uit als root:**  
   ```bash
   sudo ./hardening-script.sh
   ```

## Menu-opties
Bij het starten van het script krijg je een eenvoudig menu met keuzes:
```bash
1) Firewall instellen
2) SSH beveiligen
3) Automatische updates inschakelen
4) Wijzigingen terugdraaien
5) Stoppen
```
Kies een optie door het bijbehorende nummer in te voeren.

## Terugdraaien van wijzigingen
Als je de instellingen wilt **herstellen naar de standaardwaarden**, kies je in het menu optie **4 - Wijzigingen terugdraaien**.

## Ondersteunde distributies
✔️ Ubuntu/Debian-gebaseerde systemen  
✔️ Andere Linux-distributies met UFW en OpenSSH (aanpassing kan nodig zijn)  

## Licentie
Dit project valt onder de MIT-licentie en is ontwikkeld door **d3nkers solutions**.  
Meer informatie: [https://d3nkers-solutions.nl](https://d3nkers-solutions.nl)

