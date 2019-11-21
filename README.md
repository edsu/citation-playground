*citation-playground* contains some utilities for extracting citation metadata
from journal articles using the [AnyStyle](https://github.com/inukshuk/anystyle)
Ruby library. The idea is that you can do citation analysis on a corpus of
articles by dropping the PDFs in a directory and then running a program to pull
the citation data out of them, rather than laboriously copying this data out
yourself.

## Install

1. install Ruby
2. gem install bundler
3. git clone git@github.com:edsu/citation-playground.git
4. cd citation-playground
5. bundle install

## Setup

You can extract the csl-json from articles PDFs by placing them in the docs
subfolder. It helps for tracking the source of citations to name the PDF using
the DOI, substituting a '-' for any '/' in the DOI.

In addition you can place text files (.txt) in the docs subfolder. These text
files should only contain citations, one per line. This can be useful if you
have found sources that don't parse well by AnyStyle, and you converted the pdf
to text, and removed all the text around the citations.

## Run

To run the citation extraction you will want to:

    ruby process.rb

This will look for any PDF of text files that need to have citations extracted
from them and write each set of citations out alongside the original file, with
a .json extension. The type of JSON that AnyStyle creates is
[csl-json](https://citeproc-js.readthedocs.io/en/latest/csl-json/markup.html).

If you wish you can also convert all the JSON files into a single CSV file.

    ruby convert.rba

## Credits 

citation-playground was developed in collaboration with Victoria Scrimer at
MITH.
