package JSON::ize;
use base Exporter;
use JSON 2.00;
use strict;

our $JOBJ = JSON->new();
our $_last_out = "";

our @EXPORT = qw/jsonize jsonise J parsej pretty_json ugly_json/;
our $VERSION = "0.1";

sub jobj { $JOBJ }

sub jsonize (;$) {
  my $inp = shift;
  if (!defined $inp) {
    return $_last_out;
  }
  if (ref $inp) { # encode perl object
    return $_last_out = jobj()->encode($inp);
  }
  else { # scalar: decode if looks like json, or slurp if filename
    if (looks_like_json($inp)) {
      return $_last_out = jobj()->decode($inp);
    }
    else { # try as file
      local $/;
      my $j;
      die "'$inp' is not a existing filename, json string, or a reference" unless (-e $inp);
      open my $f, "$inp" or die "Problem with file '$inp' : $!";
      $j = <$f>;
      return $_last_out = jobj()->decode($j);
    }
  }
}

sub jsonise (;$) { jsonize($_[0]) }
sub J (;$) { jsonize($_[0]) }


sub parsej () {
  $_last_out = $JOBJ->incr_parse($_);
}

sub pretty_json { jobj()->pretty; return; }
sub ugly_json { jobj()->pretty(0); return; }

sub looks_like_json {
  my $ck = $_[0];
  return $ck =~ /^\s*[[{]/;
}

=head1 NAME

 JSON::ize - Use JSON easily in one-liners

=head1 SYNOPSIS

 $ perl -MJSON::ize -le '$j=jsonize("my.json"); print $j->{thingy};'

 $ perl -MJSON::ize -le 'J("my.json"); print J->{thingy};' # short

 $ cat my.json | perl -MJSON::ize -lne 'parsej; END{ print J->{thingy}}' # another way

 $ perl -MJSON::ize -le '$j="{\"this\":\"also\",\"works\":[1,2,3]}"; print jsonize($j)->{"this"};' # also

 $ perl -MJSON::ize -e 'pretty_json(); $j=jsonize("ugly.json"); print jsonize($j);' # pretty!

 $ cat t/sample/good.json | \
   perl -MJSON::ize -lne 'parsej;' -e 'END{ print J->{good} }'


=head1 DESCRIPTION

JSON::ize exports a function, C<jsonize()>, that will do what you mean with the argument. 
If argument is a filename, it will try to read the file and decode it as JSON.
If argument is a string that looks like JSON, it will try to encode it.
If argument is a Perl hashref or arrayref, it will try to encode it.

The underlying L<JSON> object is

 $JSON::ize::JOBJ

=head1 METHODS

=over 

=item jsonize($j), jsonise($j), J($j)

Try to DWYM.
If called without argument, return the last value returned. Use this to retrieve
after L</parsej>.

=item parsej

Parse a piped-in stream of json. Use jsonize() (without arg) to retrieve the object.
(Uses L<JSON/incr_parse>.)

=item pretty_json()

Output pretty (indented) json.

=item ugly_json()

Output json with no extra whitespace.

=back

=head1 SEE ALSO

L<JSON>, L<JSON::XS>.

=head1 AUTHOR

 Mark A. Jensen
 CPAN: MAJENSEN
 mark -dot- jensen -at- nih -dot- gov

=cut

1;
