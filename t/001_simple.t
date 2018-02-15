use Test::More;
use Test::Exception;
use File::Spec;
use strict;
use lib '../lib';
use JSONize; # import jsonize

my $tdir = (-d 't') ? 't/sample' : 'sample';

is ref jsonize('{ "this":"hash"}'), 'HASH';
is ref jsonize('["is","array"]'), 'ARRAY';
is ref jsonize(File::Spec->catfile($tdir,"good.json")), 'HASH';

is jsonize("{\"this\":\"also\",\"works\":[1,2,3]}")->{"this"}, 'also';
dies_ok { jsonize('{ "whoa":}') };
dies_ok { jsonize('this does not work') };
dies_ok { jsonize(File::Spec->catfile($tdir,"bad.json")) };

done_testing();
