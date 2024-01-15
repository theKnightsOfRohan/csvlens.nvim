fmt:
	echo "===> Formatting"
	stylua lua/ --config-path=.stylua.toml

lint:
	echo "===> Linting"
	luacheck lua/ --globals vim

test:
	echo "===> Testing"
	nvim --headless -c "PlenaryBustedDirectory lua/csvlens/tests/"

all:
	make fmt lint test
