use Test::More;
use Test::Exception;
use File::Spec;
use strict;
use lib '../lib';
use JSON::ize; # import jsonize

my $tdir = (-d 't') ? 't/sample' : 'sample';
my $dta;
my %tf = (
 gjf => File::Spec->catfile($tdir,"good.json"),
 gyf =>  File::Spec->catfile($tdir,"good.yaml"),
 bjf => File::Spec->catfile($tdir,"bad.json"),
 byf => File::Spec->catfile($tdir,"bad.yaml"),
);

lives_ok {
  jsonize($tf{gjf})
} "good json";
is_deeply J()->{and}, [1,2,3,4], "read it";
lives_ok {
  jsonize($tf{gyf})
} "good yaml";
is_deeply J()->{but}, [qw/it could be better/], "read it";

dies_ok {
  jsonize( $tf{bjf} )
} "bad json" ;

like $@, qr/^JSON decode barfed/, "interpreted as JSON";

dies_ok {
  jsonize( $tf{byf} )
} "bad yaml" ; 

like $@, qr/^Both JSON and YAML/, "towel thrown in";
done_testing;
