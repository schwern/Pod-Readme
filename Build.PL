use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'Pod::Readme',
     license => 'perl',
     requires => {
       'perl'             => '5.005',
       'Carp'             => 0,
       'IO::File'         => 0,
       'Pod::PlainText'   => 0,
     },
     recommends => {
     },
     build_requires => {
       'Test::More'     => 0,
     },
     script_files       => [
       'bin/pod2readme',
     ],
     create_readme      => 0,
     create_makefile_pl => 'traditional',
     dist_author        => 'Robert Rothenberg <rrwo at cpan.org>',
     sign               => 1,
);

$build->create_build_script;

