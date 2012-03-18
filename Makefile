# Make file for viewing/editing an encrypted file
GPGID = henry@addhen.org
FILEPLAIN = <foo.txt>
FILECRYPT = $(FILEPLAIN).gpg

GPG = gpg
RM = /bin/rm -i
VI = vim

all:
        @echo ""
        @echo "usage:"
        @echo ""
        @echo "* make view -- to see $(FILEPLAIN)"
        @echo "* make edit -- to edit $(FILEPLAIN)"
        @echo ""

edit:
        @umask 0077;\
          $(GPG) --output $(FILEPLAIN) --decrypt $(FILECRYPT)
        @$(VI) $(FILEPLAIN)
        @umask 0077;\
          $(GPG) --encrypt --recipient $(GPGID) $(FILEPLAIN)
        @$(RM) $(FILEPLAIN)

view:
        @umask 0077; $(GPG) --decrypt $(FILECRYPT) | less
