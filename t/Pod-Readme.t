#!/usr/bin/perl

use strict;

use Test::More;

my %L_ARGS = (
  'http://www.cpan.org/' => undef,
  'ftp://www.cpan.org/'  => undef,
  'news://www.cpan.org/' => undef,
  'Some::Module'         => undef,
  'Some::Module/section' => 'Some::Module',
  'Module'               => undef,
  'Module/section'       => 'Module',
  '/Section'             => 'Section',
  'Text|Module'          => 'Text',
  'Text|Module/section'  => 'Text',
  'Text|http://www.cpan.org/' => 'Text',
  'Text|ftp://www.cpan.org/'  => 'Text',
  'Text|news://www.cpan.org/' => 'Text',
);

plan tests => 10 + scalar(keys %L_ARGS);

use_ok("Pod::Readme");

my $p = Pod::Readme->new();
ok(defined $p, "new");

# TODO - test other document types than "readme"

{
  ok($p->{readme_type} eq "readme", "readme_type");
  ok(!$p->{README_SKIP}, "README_SKIP");

  # TODO - test output method

  $p->cmd_for("readme stop");
  ok($p->{README_SKIP}, "readme stop");
  $p->cmd_for("readme continue");
  ok(!$p->{README_SKIP}, "readme continue");

  $p->cmd_for("readme stop");
  ok($p->{README_SKIP}, "readme stop");
  $p->cmd_for("readme");
  ok(!$p->{README_SKIP}, "readme");

  $p->cmd_for("readme stop");
  ok($p->{README_SKIP}, "readme stop");
  $p->cmd_begin("readme");
  ok(!$p->{README_SKIP}, "begin readme");
}

# TODO - test for readme include

{
  foreach my $arg (sort keys %L_ARGS) {
    my $exp = $L_ARGS{$arg} || $arg;
    my $r   = $p->seq_l($arg);
    ok($r eq $exp, "L<$arg>");
    # print STDERR "\x23 $r\n";
  };
  
}
