#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#undef seed
#include <SDL2/SDL.h>

void wav_loaded(void *data, Uint8 *stream, int len);
void* playwav(const char* file);


