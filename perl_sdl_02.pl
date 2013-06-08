use strict;
use warnings;
use SDL;
use SDLx::App;

my $app = SDLx::App->new(
w => 500,
h => 500,
d => 32,
title => 'Pretty Flowers' );

# Add the blue skies
$app->draw_rect( [ 0, 0, 500, 500 ], [ 20, 50, 170, 255 ] );

# Draw a green field
$app->draw_rect( [ 0, 400, 500, 100 ], [ 50, 170, 20, 100 ] );

# Make a surface for the flower
my $flower = SDLx::Surface->new( width => 50, height => 100 );

# With a black background
$flower->draw_rect( [ 0, 0, 50, 100 ], [ 0, 0, 0, 0 ] );

# Draw a pretty green stem
$flower->draw_rect( [ 23, 30, 4, 100 ], [ 0, 255, 0, 255 ] );

# And a simple flower bud
$flower->draw_circle_filled( [ 25, 25 ], 10, [ 150, 0, 0, 255 ] );
$flower->draw_circle( [ 25, 25 ], 10, [ 255, 0, 0, 255 ] );

# Draw flower on $app
$flower->blit( $app, [ 0, 0, 50, 100 ] );

$app->update();

sleep(2);
