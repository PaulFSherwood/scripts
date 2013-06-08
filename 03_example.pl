use strict;
use warnings;
use Cwd;
use Carp;
use File::Spec;
use threads;
use threads::shared;
use SDL;
use SDL::Event;
use SDL::Events;
use SDL::Audio;
use SDL::Mixer;
use SDL::Mixer::Music;
use SDL::Mixer::Effects;
use SDLx::App;
my $app = SDLx::App->new(
	init => SDL_INIT_AUDIO | SDL_INIT_VIDEO,
	width => 800,
	height => 600,
	depth => 32,
	title => "Sound Event Demo",
	eoq => 1,
	dt => 0.2,
);
# Initialize the Audio
unless ( SDL::Mixer::open_audio( 44100, AUDIO_S16, 2, 1024 ) == 0 ) {
	Carp::croak "Cannot open audio: " . SDL::get_error();
}

# Load our music files
my $data_dir = '.';
my @songs = glob '../../../Music/youtube/*.ogg';

my @stream_data : shared;
#
Music Effect to pull Stream Data
sub music_data {
	my ( $channel, $samples, $position, @stream ) = @_;
	{
		lock(@stream_data);
		push @stream_data, @stream;
	}
	return @stream;
}
sub done_music_data { }

my $music_data_effect_id =
SDL::Mixer::Effects::register( MIX_CHANNEL_POST, "main::music_data",
"main::done_music_data", 0 );

my $lines = $ARGV[0] || 50;

#
Music Playing Callbacks
my $current_song = 0;
my $current_music_callback = sub {
my ( $delta, $app ) = @_;
$app->draw_rect( [ 0, 0, $app->w(), $app->h() ], 0x000000FF );
$app->draw_gfx_text(
[ 5, $app->h() - 10 ],

[ 255, 0, 0, 255 ],
"Playing Song: " . $songs[ $current_song - 1 ]
);
my @stream;
{
lock @stream_data;
@stream
= @stream_data;
@stream_data = ();
}
# To show the right amount of lines we choose a cut of the stream
# this is purely for asthetic reasons.
my $cut = @stream / $lines;
# The width of each line is calculated to use.
my $l_wdt = ( $app->w() / $lines ) / 2;
for ( my $i = 0 ; $i < $#stream ; $i += $cut ) {
#
In stereo mode the stream is split between two alternating streams
my $left
= $stream[$i];
my $right = $stream[ $i + 1 ];
#
For each bar we calculate a Y point and a X point
my $point_y = ((($left)) * $app->h() / 4 / 32000 ) + ( $app->h / 2 );
my $point_y_r = ((($right)) * $app->h() / 4 / 32000 ) + ( $app->h / 2 );
my $point_x = ( $i / @stream ) * $app->w;
# Using the parameters
# Surface, box coordinates and color as RGBA
SDL::GFX::Primitives::box_RGBA(
	$app,
	$point_x - $l_wdt,
	$app->h() / 2,
	$point_x + $l_wdt,
	$point_y, 40, 0, 255, 128
);
SDL::GFX::Primitives::box_RGBA(
	$app,
	$point_x - $l_wdt,
	$app->h() / 2,
	$point_x + $l_wdt,
	$point_y_r, 255, 0, 40, 128);
}
$app->flip();
};

my $cms_move_callback_id;
my $pns_move_callback_id;
my $play_next_song_callback;
sub music_finished_playing {
SDL::Mixer::Music::halt_music();
$pns_move_callback_id = $app->add_move_handler($play_next_song_callback)
if ( defined $play_next_song_callback );
}
$play_next_song_callback = sub {
return $app->stop() if $current_song >= @songs;
my $song = SDL::Mixer::Music::load_MUS( $songs[ $current_song++ ] );
SDL::Mixer::Music::play_music( $song, 0 );
$app->remove_move_handler($pns_move_callback_id)

if defined $pns_move_callback_id;
};

$app->add_move_handler(
sub {
my $music_playing = SDL::Mixer::Music::playing_music();
music_finished_playing() unless $music_playing;
}
)

$app->add_show_handler($current_music_callback);
$pns_move_callback_id = $app->add_move_handler($play_next_song_callback);

$app->add_event_handler(
	sub {
		my ($event, $app) = @_;
		if( $event->type == SDL_KEYDOWN && $event->key_sym == SDLK_DOWN)
		{
			#Indicate that we are done playing the music_finished_playing
			music_finished_playing();
		}
	}
);

$app->run();

SDL::Mixer::Effects::unregister( MIX_CHANNEL_POST, $music_data_effect_id );
SDL::Mixer::Music::hook_music_finished();
SDL::Mixer::Music::halt_music();
SDL::Mixer::close_audio();


