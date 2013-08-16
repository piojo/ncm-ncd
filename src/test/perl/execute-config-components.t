# -*- mode: cperl -*-
use strict;
use warnings;
use Test::More;
use Test::Quattor qw(execute-config-components);
use NCD::ComponentProxyList;
use NCD::ComponentProxy;
use CAF::Application;
use Test::MockModule;

my $mock = Test::MockModule->new("NCD::ComponentProxy");

$mock->mock("executeConfigure", 1);

our $this_app = CAF::Application->new('app');
$this_app->{CONFIG}->define("nodeps");
$this_app->{CONFIG}->set('nodeps', 0);

my $cfg = get_config_for_profile('cmplist');

my @cmps = (NCD::ComponentProxy->new('acomponent', $cfg));

my $cl = NCD::ComponentProxyList->new($cfg, undef, "acomponent");

$cl->{_CLIST} = \@cmps;

my $err = $cmp->executeConfigComponents();

is($err->{ERRORS}, 0, "No errors reported");

done_testing();
