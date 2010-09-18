#!/usr/bin/perl

# MediaWiki -> RCS scraper

use warnings;
use strict;

require MediaWiki::DumpFile::Pages;

my $dumpfile = MediaWiki::DumpFile::Pages->new(shift @ARGV);
# 83Plus:Ports:57

while (defined (my $page = $dumpfile->next))
{
    my @revs = $page->revision;

    foreach (@revs) {
	open (FILE, ">", $page->title);
	print FILE $_->text;
	close FILE;
	my @command = ("ci",
		       "-t-" . $page->title,
		       "-d" . $_->timestamp,
		       ($_->comment ne "" ? "-m" . $_->comment : "-mNo message"),
		       "-r" . $_->id,
		       "-w" . $_->contributor->astext,
		       "-l",
		       $page->title,
	    );

	system(@command);
	print join " ", @command, "\n";
    }
}
