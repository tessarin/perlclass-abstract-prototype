use v5.40;
use experimental 'class';

class Component; # :abstract;

use constant DB_TABLE => 'components';
use constant TYPES => {
    0 => 'Component::Generic',
    1 => 'Component::Resistor',
    2 => 'Component::Capacitor',
};

field $id       :reader;
field $type     :reader;

method is_new { ! defined $id }

method _populate ($row)
{
    $id = $row->{id};
}

# abstract methods
method description {}
method populate ($row) {}

sub GetAll ($class, $rows)
# XXX: Instead of $rows, a database handle would
# be passed to actually query a proper database.
{
    my @components;
    my @rows_filtered = $class eq 'Component'
            ? @$rows
            : grep { TYPES->{ $_->{type} } eq $class } @$rows;

    for my $row (@rows_filtered) {
        die "Unknown component type.\n"
            unless exists TYPES->{ $row->{type} };

        my $class = TYPES->{ $row->{type} };
        _load_class($class);
        my $obj = $class->new;
        $obj->populate($row);

        push @components, $obj;
    }

    @components;
}

sub _load_class ($class)
{
    try {
        my $file = $class;
        $file =~ s|::|/|g;
        require "$file.pm";
    } catch ($e) {
        die "Could not load `$class`: $e\n";
    }
}
