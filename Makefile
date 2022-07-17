all: install setup link reboot

install:
	sh ./scripts/install.sh

setup:
	sh ./scripts/setup.sh
	sh ./scripts/link.sh

link:
	sh ./scripts/link.sh

reboot:
	sh ./scripts/reboot_shell.sh
