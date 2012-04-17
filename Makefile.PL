use inc::Module::Install;
name 'Color-Convert-ANSIColor';
all_from 'lib/Color/Convert/ANSIColor.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires (
    'Test::More' => 0,
    'Test::Most' => 0,
);
auto_set_repository;
auto_include;
WriteAll;
