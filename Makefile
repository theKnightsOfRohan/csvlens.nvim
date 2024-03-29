fmt:
	echo "===> Formatting"
	stylua lua/ --config-path=.stylua.toml

lint:
	echo "===> Linting"
	luacheck lua/ --globals vim

test:
	echo "===> Testing"
	nvim --headless --noplugin -u lua/csvlens/tests/minimal_init.lua -c "PlenaryBustedDirectory lua/csvlens/tests/ { minimal_init = 'lua/csvlens/tests/minimal_init.lua' }"

clean:
	echo "===> Cleaning testing dependencies"
	rm -rf /tmp/csvlens_test/toggleterm.nvim 
	rm -rf /tmp/csvlens_test/plenary.nvim
	rm -rf /tmp/csvlens_test/installer_test

all:
	make fmt lint test clean
