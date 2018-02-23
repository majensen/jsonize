use Module::Build;
my $build = Module::Build->new(
  dist_name => 'JSONize',
  dist_abstract => 'Use JSON easily in one-liners',
  dist_author => 'Mark A. Jensen',
  dist_version_from => 'lib/JSON/ize.pm',
  module_requires => {
    'JSON' => 0
   },
  build_requires => {
    'Test::More' => 0,
    'Test::Exception' => 0
   },
  configure_requires => {
    'Module::Build' => 0
   }
 );

$build->create_build_script;










