This is an unofficial Gentoo overlay repository maintained by me (jjakob).

To use:
- mask all packages in this overlay:
  echo "*/*::jjakob" > /etc/portage/package.mask/overlay_jjakob
- eselect repository enable jjakob
- unmask the packages you need, for example:
  echo -e "net-im/gomuks::jjakob\ndev-libs/olm::jjakob"\
      > /etc/portage/package.unmask/overlay_jjakob
- sync and install packages as usual

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

- net-p2p/monero-gui
	copy of net-p2p/monero-gui::booboo
	updated version, fixed issues preventing a successful build

- net-libs/webkit-gtk
	copy of ::lanodanOverlay
	fixed 2.33.1 build issues
