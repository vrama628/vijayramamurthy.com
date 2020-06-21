Uses OCaml to generate [vijayramamurthy.me](http://vijayramamurthy.me),
which is hosted as a GitHub Pages site from [vrama628.github.io](http://vrama628.github.io).

The [vrama628.github.io repo](https://github.com/vrama628/vrama628.github.io) is a
git submodule of this one, so use `git clone --recurse-submodules` to clone this repo.

To generate the website, run `make`.
Generating the website happens in two steps:
first `dune build` builds the js files,
then `dune exec ./main.exe` writes the html files
and puts everything into `./vrama628.github.io`.
