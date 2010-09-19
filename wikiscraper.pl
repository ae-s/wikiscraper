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
	system("co", "-l", $page->title);

	open (FILE, ">", $page->title);
	print FILE $_->text;
	close FILE;

	my $user = $_->contributor->id;
	if (!defined $user) {
	    $user = $_->contributor->ip;
	    $user =~ s/\./_/g;
	    $user = "ip_" . $user;
	} else {
	    $user = "id_" . $user;
	}
	my @command = ("ci",
		       "-t-" . $page->title,
		       "-d" . $_->timestamp,
		       ($_->comment ne "" ? "-m" . $_->comment : "-mNo message"),
		       "-r" . $_->id,
		       "-w" . $user,
		       $page->title,
	    );

	print join " ", @command, "\n";
	system(@command);
    }
}
