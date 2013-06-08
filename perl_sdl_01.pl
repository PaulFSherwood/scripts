use strict;
use warnings;
my $color = 0xFFFFFFFF;
my $white = 255;
my $black = 0;
my $red = 255;;
my $green = 255;
my $blue = 0;
my $alpha = 255;
use SDL;
use SDLx::App;
# my $app = SDLx::App->new();
my $app = SDLx::App->new( width => 400, height => 400, title => 'Perl SDL Test' );
# my $color = [255, 255, 255, 255];
# my $x;
# my $y;
# $app->[$x][$y] = $color;
# draw a line
$app->draw_line( [400, 0], [0, 400], [$red, $green, $blue, 255] );
# draw a square
$app->draw_rect( [10, 20, 40, 40 ], [255, 255, 255,255] );
# draw a circle
$app->draw_circle( [100, 100], 20, [255, 0, 0, 255] );
# draw a circle filled in
$app->draw_circle_filled( [100, 100], 19, [0, 0, 255, 255] );
# update the screen
$app->update();

sleep(2);
