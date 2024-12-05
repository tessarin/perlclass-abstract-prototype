use v5.40;
use experimental 'class';

class Component::Resistor :isa(Component);

field $resistance :reader;

method description { "resistor of $resistance ohms" }

method populate ($row)
{
    $self->_populate($row);

    $resistance = $row->{data_b};
}
