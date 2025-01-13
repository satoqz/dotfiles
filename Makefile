all: install

install:
	@dotter --force --noconfirm

format: format-json format-fish

format-json:
	$(eval tempfile = $(shell mktemp))

	@jq --sort-keys . code/settings.json > $(tempfile)
	@mv $(tempfile) code/settings.json

	@prettier -w --log-level warn **/*.json

format-fish:
	@fish_indent -w **/*.fish

.PHONY: all install format format-json format-fish
