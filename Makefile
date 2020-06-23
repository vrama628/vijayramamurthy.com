all:
	dune build && dune exec ./main.exe

serve: all
	cd vrama628.github.io && http-server
