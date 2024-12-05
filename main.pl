#!/usr/bin/env 	perl

use v5.40;
use lib 'lib';

use Component;
use Component::Resistor;

my $rows = [
    { id => 0, type => 0, data_a => 'Crystal oscillator', data_b => undef   },
    { id => 1, type => 1, data_a => undef,                data_b => 1e3     },
    { id => 2, type => 2, data_a => undef,                data_b => 1e-3    },
    { id => 3, type => 1, data_a => undef,                data_b => 1e6     },
];

my @inventory = Component->GetAll($rows);

say 'found ', scalar @inventory, ' components.';
say 'component #2 is a ', $inventory[1]->description, '.';
say 'found ', scalar Component::Resistor->GetAll($rows), ' resistors.';

