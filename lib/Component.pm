use v5.40;
use experimental 'class';

use Component::Generic;
use Component::Resistor;
use Component::Capacitor;

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

    for my $row (@$rows) {
        die "Unknown component type.\n"
            unless exists TYPES->{ $row->{type} };

        my $class = TYPES->{ $row->{type} };
        my $obj = $class->new;
        $obj->populate($row);

        push @components, $obj;
    }
}
