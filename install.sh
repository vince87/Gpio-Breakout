#!/bin/sh
########################################################
## Script per l'installazione del driver gpio
##
## Version 0.2
#########################################################

dialog --title "Script installazione Gpio Breakout" --msgbox "Attenzione verranno ora installati i driver per il corretto funzionamento della Gpio Breakout.
\n \nSe stai usando un immagine custom, non scaricata da retropie.org.uk, accertati di aver disattivato tutti gli script che usano i GPIO." 14 60

cd ~
sudo apt-get update
sudo apt-get install -y git libjpeg-dev dialog

	printf "\033[1;31m download GPIO Driver \033[0m\n"
	git clone https://github.com/vince87/Gpio-Breakout.git
	
##install jammapi joystick driver
	printf "\033[1;31m Install GPIO Joystick driver \033[0m\n"
	cd mk_arcade_joystick/
	mkdir /usr/src/mk_arcade_joystick_rpi-0.1.5/
	cp -a * /usr/src/mk_arcade_joystick_rpi-0.1.5/
	cd ~
	rm -R mk_arcade_joystick/
	dkms build -m mk_arcade_joystick_rpi -v 0.1.5
	dkms install -m mk_arcade_joystick_rpi -v 0.1.5
	modprobe mk_arcade_joystick_rpi map=1,2
	mv /etc/modules /etc/modules.bak
	mv modules /etc/
	rm /etc/modprobe.d/mk_arcade_joystick.conf
	echo "options mk_arcade_joystick_rpi map=1,2" >> mk_arcade_joystick.conf
	mv mk_arcade_joystick.conf /etc/modprobe.d/

#reboot
fi	