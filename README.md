# GmailExtractor

A small command line tool to extract emails from Google Mail (GMail).

## Usage

    $> gem install gmail_extractor
    $> gmail_extractor --help

## Examples

To download all emails within the label LABEL and the GMail account test123:

    $> gmail_extractor --user test123 --label LABEL

## Development

This gem is built ontop of the following gems:

* `gmail`
* `progressbar`
* `highline`

It has been tested on Ruby 1.9.3-p0!