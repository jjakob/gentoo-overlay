This is an unofficial Gentoo overlay repository maintained by me (jjakob).

Packages:
- mail-mta/dma
	"Dragonfly Mail Agent", https://github.com/corecode/dma
	Version 9999 points to my fork https://github.com/jjakob/dma
	branch "rewriteheaderfrom".
	Other versions point to official releases.

	To install:
	  - echo "virtual/mta::gentoo" > /etc/portage/package.mask/mta
	  - echo "=mail-mta/dma-9999 **" >
	    /etc/portage/package.accept_keywords/dma
	      or, to use the official releases:
	    echo "mail-mta/dma ~amd64" >
	    /etc/portage/package.accept_keywords/dma
	  - emerge -a mail-mta/dma

- virtual/mta
	copy of virtual/mta::gentoo with added mail-mta/dma
