# NAME

    JSONize - Use JSON easily in one-liners

# SYNOPSIS

    $ perl -MJSONize -le '$j=jsonize("my.json"); print $j->{thingy};'

    $ perl -MJSONize -e '$j={"this":"also","works":[1,2,3]}; print jsonize($j);'

    $ perl -MJSONize -e 'pretty_json(); $j=jsonize("ugly.json"); print jsonize($j);'

# DESCRIPTION

JSONize exports a function, `jsonize()`, that will do what you mean with the argument. 
If argument is a filename, it will try to read the file and decode it as JSON.
If argument is a string that looks like JSON, it will try to encode it.
If argument is a Perl hashref or arrayref, it will try to encode it.

The underlying [JSON](https://metacpan.org/pod/JSON) object is

    $JSONize::JOBJ

# METHODS

- jsonize($j)

        Try to DWYM.

- pretty\_json()

        Output pretty (indented) json.

- ugly\_json()

        Output json with no extra whitespace.

# SEE ALSO

[JSON](https://metacpan.org/pod/JSON), [JSON::XS](https://metacpan.org/pod/JSON::XS).

# AUTHOR

    Mark A. Jensen
    majensen -at- cpan -dot- org
