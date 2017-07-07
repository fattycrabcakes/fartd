#include "fartd.h"

MODULE = FartD PACKAGE = FartD
PROTOTYPES: DISABLE

void*
playwav(filename);
	const char* filename
	CODE:
		RETVAL = playwav(filename);
	OUTPUT:
		RETVAL
