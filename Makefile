# Make file for viewing/editing an encrypted file
# Also to export and port brew installs
GPGID = henry@addhen.org
FILEPLAIN = <foo.txt>
FILECRYPT = $(FILEPLAIN).gpg

GPG = gpg
RM = /bin/rm -i
VI = vim
BREW = brew
CP = cp

MAC_INSTALL = ./install_dotfiles -p mac
LINUX_INSTALL = ./install_dotfiles -p mac
BREWFILE := ./Work.Brewfile
DAY := $(shell date +"%H-%M-%S-%d-%m-%Y")
BREWFILEBAK := $(BREWFILE).$(DAY)
UMASK := 0077

all:
	@echo ""
	@echo "usage:"
	@echo ""
	@echo "* make view -- to see $(FILEPLAIN)"
	@echo "* make edit -- to edit $(FILEPLAIN)"
	@echo "* make portlinux -- to install dot files on a Linux machine"
	@echo "* make portmac -- to install dot files on a Mac machine"
	@echo "* make brewexport -- to export brew installs on Mac machine"
	@echo "$ make brewimport -- to import brew install onto a Mac machine"
	@echo ""

edit:
	@umask $(UMASK);\
		$(GPG) --output $(FILEPLAIN) --decrypt $(FILECRYPT)
	@$(VI) $(FILEPLAIN)
	@umask $(UMASK);\
		$(GPG) --encrypt --recipient $(GPGID) $(FILEPLAIN)
	@$(RM) $(FILEPLAIN)

view:
	@umask $(UMASK); $(GPG) --decrypt $(FILECRYPT) | less

portlinux:
	@$(LINUX_INSTALL)

portmac:
	@$(MAC_INSTALL)

brewexport:
	@$(CP) $(BREWFILE) $(BREWFILEBAK)
	@$(RM) $(BREWFILE)
	@$(BREW) bundle dump --file=$(BREWFILE);

brewimport:
	@$(BREW) bundle install --file=$(BREWFILE);

