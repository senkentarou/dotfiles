.PHONY: all install setup link

all: install setup link

install:
	sh ./scripts/install.sh

setup:
	sh ./scripts/setup.sh
	sh ./scripts/link.sh

link:
	sh ./scripts/link.sh
