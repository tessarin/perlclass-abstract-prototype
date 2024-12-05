use v5.40;
use experimental 'class';

class Component::Capacitor :isa(Component);

field $capacitance :reader;

method description { "capacitor of $capacitance ohms" }

method populate ($row)
{
    $self->_populate($row);

    $capacitance = $row->{data_b};
}
