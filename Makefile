.PHONY: all install setup link deploy

all: install setup link

install:
	sh ./scripts/install.sh

setup:
	sh ./scripts/setup.sh

link:
	sh ./scripts/link.sh

deploy:
	sh ./scripts/setup.sh
	sh ./scripts/link.sh
