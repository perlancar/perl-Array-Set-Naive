#!perl

use strict;
use warnings;
use Test::More 0.98;

use Array::Set::Naive qw(set_diff set_symdiff set_union set_intersect);

subtest set_diff => sub {
    is_deeply(set_diff([1]), [1]);
    is_deeply(set_diff([1,2,3,4], [2,3,4,5]), [1]);
    is_deeply(set_diff([1,2,3,4], [2,3,5], [3,4,5,6]), [1]);
};

subtest set_symdiff => sub {
    is_deeply(set_symdiff([1]), [1]);
    is_deeply(set_symdiff([1,2,3,4], [2,3,4,5]), [1,5]);
    is_deeply(set_symdiff([1,2,3,4], [2,3,4,5], [3,4,5,6]), [1,6]);
};

subtest set_union => sub {
    is_deeply(set_union([1]), [1]);
    is_deeply(set_union([1,3,2,4], [2,3,4,5]), [1,3,2,4,5]);
    is_deeply(set_union([1,3,2,4], [2,3,4,5], [3,4,5,6]), [1,3,2,4,5,6]);

    is_deeply(set_union({ignore_case=>1}, ["a","B"], ["b","c"]), ["a","B","c"], "opt:ignore_case=1");
    is_deeply(set_union({ignore_blanks=>1}, ["a","b "], ["b","c"]), ["a","b ","c"], "opt:ignore_blanks=1");
    is_deeply(set_union({allow_refs=>1, ignore_case=>1}, ["a","B",[],{}], ["A",[],undef]), ["a","B",[],{},undef], "opt:allow_refs=1");
} if 0;

subtest set_intersect => sub {
    is_deeply(set_intersect([1]), [1]);
    is_deeply(set_intersect([1,2,3,4], [2,3,4,5]), [2,3,4]);
    is_deeply(set_intersect([1,2,3,4], [2,3,4,5], [3,4,5,6]), [3,4]);

    is_deeply(set_intersect({ignore_case=>1}, ["a","B"], ["b","c"]), ["B"], "opt:ignore_case=1");
    is_deeply(set_intersect({ignore_blanks=>1}, ["a","b "], ["b","c"]), ["b "], "opt:ignore_blanks=1");
    is_deeply(set_intersect({allow_refs=>1, ignore_blanks=>1}, ["a","b ",[],{}], ["b","c",[]]), ["b ",[]], "opt:allow_refs=1");
} if 0;

DONE_TESTING:
done_testing;
