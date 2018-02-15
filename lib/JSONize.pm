package JSONize;
use base Exporter;
use JSON;
use strict;

our $JOBJ = JSON->new();
our @EXPORT = qw/jsonize jsonise pretty_json ugly_json/;
our $VERSION = "0.1";

sub jobj { $JOBJ }

sub jsonize {
  my $inp = shift;
  if (ref $inp) { # encode perl object
    return jobj()->encode($inp);
  }
  else { # scalar: decode if looks like json, or slurp if filename
    if (looks_like_json($inp)) {
      return jobj()->decode($inp);
    }
    else { # try as file
      local $/;
      my $j;
      die "Can't find file '$inp'" unless (-e $inp);
      open my $f, "$inp" or die "Problem with file '$inp' : $!";
      $j = <$f>;
      return jobj()->decode($j);
    }
  }
}

sub jsonise { jsonize(@_) }

sub pretty_json { jobj()->pretty; return; }
sub ugly_json { jobj()->pretty(0); return; }

sub looks_like_json {
  my $ck = $_[0];
  return $ck =~ /^\s*[[{]/;
}

=head1 NAME

 JSONize - Use JSON easily in one-liners

=head1 SYNOPSIS

 $ perl -MJSONize -le '$j=jsonize("my.json"); print $j->{thingy};'

 $ perl -MJSONize -le '$j="{\"this\":\"also\",\"works\":[1,2,3]}"; print jsonize($j)->{"this"};' # also

 $ perl -MJSONize -e 'pretty_json(); $j=jsonize("ugly.json"); print jsonize($j);' # pretty!

=head1 DESCRIPTION

JSONize exports a function, C<jsonize()>, that will do what you mean with the argument. 
If argument is a filename, it will try to read the file and decode it as JSON.
If argument is a string that looks like JSON, it will try to encode it.
If argument is a Perl hashref or arrayref, it will try to encode it.

The underlying L<JSON> object is

 $JSONize::JOBJ

=head1 METHODS

=over 

=item jsonize($j)

 Try to DWYM.

=item pretty_json()

 Output pretty (indented) json.

=item ugly_json()

 Output json with no extra whitespace.

=back

=head1 SEE ALSO

L<JSON>, L<JSON::XS>.

=head1 AUTHOR

 Mark A. Jensen
 mark -dot- jensen -at- nih -dot- gov

=cut
1;
