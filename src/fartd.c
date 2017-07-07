#include "fartd.h"

static Uint8 *buffer;
static Uint32 alen;

void wav_loaded(void *data, Uint8 *stream, int len);
void* playwav(const char* file) {
	
	if (SDL_Init(SDL_INIT_AUDIO) < 0) {
			return 1;
	}

	static Uint32 wav_length; 
	static Uint8 *wav_buffer; 

	SDL_AudioSpec wav_spec; 
	SDL_AudioSpec obtained_spec;
	
	
	/* Load the WAV */
	if( SDL_LoadWAV(file, &wav_spec, &wav_buffer, &wav_length) == NULL ){
		printf("BAD WAV\n");
	  return 1;
	}

	wav_spec.callback = wav_loaded;
	wav_spec.userdata = NULL;

	buffer = wav_buffer;
	alen = wav_length;
	
	if ( SDL_OpenAudio(&wav_spec, &obtained_spec) < 0 ){
	  fprintf(stderr, "Couldn't open audio: %s\n", SDL_GetError());
	  exit(-1);
	}
	
	SDL_PauseAudio(0);
	while ( alen>0) {
		SDL_Delay(100); 
	}
	
	SDL_CloseAudio();
	SDL_FreeWAV(wav_buffer);
}

void wav_loaded(void *data, Uint8 *stream, int len) {
	if (alen<=0) {
		return;
	}
	
	len = ( len > alen ? alen : len );
	SDL_memcpy (stream, buffer, len); 
	buffer += len;
	alen -= len;
}
