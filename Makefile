all: install

install:
	@dotter --force --noconfirm

format: format-json format-lua format-fish

format-json:
	$(eval tempfile = $(shell mktemp))

	@jq --sort-keys . code/settings.json > $(tempfile)
	@mv $(tempfile) code/settings.json

	@jq --sort-keys . zed/settings.json > $(tempfile)
	@mv $(tempfile) zed/settings.json

	@prettier -w --log-level warn **/*.json

format-lua:
	@stylua .

format-fish:
	@fish_indent -w **/*.fish

.PHONY: all install format format-json format-lua format-fish
