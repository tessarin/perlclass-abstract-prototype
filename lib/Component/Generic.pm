use v5.40;
use experimental 'class';

class Component::Generic :isa(Component);

field $name :reader;

method description { $name }

method populate ($row)
{
    $self->_populate($row);

    $name = $row->{data_a};
}
