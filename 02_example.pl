#!/usr/bin/perl
use warnings;
use strict;

use SDL;
use SDL::Rect;
use SDL::Color;

use SDL;
use SDLx::App;
# my $app = SDLx::App->new();
my $app = SDLx::App->new( width => 400, height => 400, title => 'Perl SDL Test' );

my $black = SDL::Color->new(0, 0, 0);
my $color = SDL::Color->new(255, 0, 0);
my $r = $color->r; # 255
my $g = $color->g; # 0
my $b = $color->b; # 0
$color->g(255);
$color->b(255);
# $color is now white

# update the screen
$app->update();

sleep(1);
