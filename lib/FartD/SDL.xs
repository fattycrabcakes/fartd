#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#undef seed

#include <SDL2/SDL.h>

static Uint8 *buffer;
static Uint32 alen;

void wav_loaded(void *data, Uint8 *stream, int len);
void* playwav(const char* file) {
	
	// Initialize SDL.
	if (SDL_Init(SDL_INIT_AUDIO) < 0)
			return 1;

	// local variables
	static Uint32 wav_length; 
	static Uint8 *wav_buffer; 
	SDL_AudioSpec wav_spec; 
	SDL_AudioSpec obtained_spec;
	
	
	/* Load the WAV */
	// the specs, length and buffer of our wav are filled
	if( SDL_LoadWAV(file, &wav_spec, &wav_buffer, &wav_length) == NULL ){
		printf("BAD WAV\n");
	  return 1;
	}

	// set the callback function
	wav_spec.callback = wav_loaded;
	wav_spec.userdata = NULL;

	// set our global static variables
	buffer = wav_buffer; // copy sound buffer
	alen = wav_length; // copy file length
	
	/* Open the audio device */
	if ( SDL_OpenAudio(&wav_spec, &obtained_spec) < 0 ){
	  fprintf(stderr, "Couldn't open audio: %s\n", SDL_GetError());
	  exit(-1);
	}
	
	/* Start playing */
	SDL_PauseAudio(0);

	// wait until we're don't playing
	while ( alen>0) {
		SDL_Delay(100); 
	}
	
	// shut everything down
	SDL_CloseAudio();
	SDL_FreeWAV(wav_buffer);

}

void wav_loaded(void *data, Uint8 *stream, int len) {
	if (alen<=0) {
		return;
	}
	
	len = ( len > alen ? alen : len );
	SDL_memcpy (stream, buffer, len); 					// simply copy from one buffer into the other
	buffer += len;
	alen -= len;
}


MODULE = FartD::SDL  PACKAGE = FartD::SDL
PROTOTYPES: DISABLE

void*
playwav(filename);
	const char* filename
	CODE:
		RETVAL = playwav(filename);
	OUTPUT:
		RETVAL
