#!/usr/bin/perl

# MediaWiki -> RCS scraper

use warnings;
use strict;

require LWP::UserAgent;

my $wiki = shift @ARGV;
