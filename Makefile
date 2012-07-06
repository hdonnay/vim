# Makefile for dotfiles (cf. https://github.com/pix/dotfiles)

DOT_FILE = vimrc gvimrc

all: install

install: $(foreach f, $(DOT_FILE), install-file-$(f))

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

.PHONY : clean

