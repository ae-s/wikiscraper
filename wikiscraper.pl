#!/usr/bin/perl

# MediaWiki -> RCS scraper

use warnings;
use strict;

require MediaWiki::API;

my $api_url = shift @ARGV;
# http://wikiti.brandonw.net/api.php

my $page = shift @ARGV;
# 83Plus:Ports:57

my $name = shift @ARGV;
my $password = shift @ARGV;

my $mw = MediaWiki::API->new( { api_url => $api_url } );
$mw->login( { lgname => $name,
	      lgpassword => $password } )
    || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

