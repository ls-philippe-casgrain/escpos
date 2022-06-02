# escpos

A very simple app to send [escpos](https://www.epson-biz.com/modules/ref_escpos/) data to an Epson printer.

## Requirements

Xcode 13.2 or later, or the Xcode command-line tools.

## Usage

From the terminal:

    swift run escpos [printer IP address] [file name]

Example:

    swift run escpos 192.168.2.24 justification.escpos

The socket remains open until the connection times out _or_ you type `exit`.

## Files to use

* justification.escpos - prints a few lines of justified text
* fonts.escpos - test fonts
* printmodes.escpos - takes a long time to print
* underline.escpos - underline text
