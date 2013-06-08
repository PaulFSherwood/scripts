#!/usr/bin/perl
use warnings;
use strict;

use SDL;
use SDLx::App;
use SDL::Rect;
use SDL::Color;

# User defined pen-nib size.
my $nib_size = 3;

# Create the SDL App
my $app = SDLx::App->new(width  => 640,height => 480,depth  => 16,title  => "Hello, World!");

# our nib will be white
my $nib_color = SDL::Color->new(0,0,0);

# and our nib will be represented by a rectangle
# (Alternatively, you could use an image, which would allow
# for pretty anti-aliasing if you created it in GIMP with
# antialiasing)
my $nib = SDL::Rect->new(
	0, 0, 50, 4
);

# now draw a sine wave (wthout covering up previously drawn rectangles)
my $t = 0;
my $t_step = 2**-4;
for($t = 0; $t < 50; $t += $t_step) {
	$nib->x( $t * 8 );
	$nib->y( sin($t) * 80 + 240 );

	$app->fill( $nib, $nib_color );
}

# Generally use the update command, but if you want to update the whole
# surface, use flip
$app->flip();

sleep(5);
