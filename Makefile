fmt:
	echo "===> Formatting"
	stylua lua/ --config-path=.stylua.toml

lint:
	echo "===> Linting"
	luacheck lua/ --globals vim

test:
	echo "===> Testing"
	nvim \
		--headless \
		--noplugin \
		-u lua/csvlens/tests/minimal_init.lua \
		-c "PlenaryBustedDirectory lua/csvlens/tests/ { minimal_init = 'lua/csvlens/tests/minimal_init.lua' }"

clean:
	echo "===> Cleaning"
	rm -rf /tmp/toggleterm.nvim 
	rm -rf /tmp/plenary.nvim

all:
	make fmt lint test clean
