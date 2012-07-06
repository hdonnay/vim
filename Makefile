# Makefile for dotfiles (cf. https://github.com/pix/dotfiles)

DIR =
DOT_FILE = vimrc

all: install

install: $(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
		 $(foreach f, $(DOT_FILE), install-file-$(f))

$(HOME)/.history:
	@echo "  MKDIR Creating ~/.history"
	@mkdir $(HOME)/.history 2>/dev/null

install-dir-%: %
	@echo "  LN  $< to ~/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

install-dotdir-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<
	@if [ -f "$</Makefile" ]; then cd $< && make; fi

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DIR), clean-$(f)) \
       $(foreach f, $(DOT_DIR), clean-.$(f)) \
       $(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

.PHONY : clean

