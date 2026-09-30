#!/usr/bin/env perl

$pdf_mode = 4;
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error -halt-on-error %O %S';
$bibtex = 'bibtex %O %B';
$out_dir = '.manuscript-build';
$max_repeat = 10;
