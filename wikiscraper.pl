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
print $api_url, "\n";
#$mw->login( { lgname => $name,
#	      lgpassword => $password } )
#    || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};

my $revs = $mw->api( 
    { action => 'query',
      prop => 'categorymembers',
      cmtitle => 'Category:68k',
      cmlimit => 'max',
    } );

print join('**', %$revs->{'warnings'}), "\n";

foreach (@{$revs}) {
    print "$_->{title}\n";
}
