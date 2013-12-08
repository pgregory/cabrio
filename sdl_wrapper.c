#include <stdio.h>
#include "config.h"
#include "sdl_wrapper.h"

#include <SDL2/SDL.h>
#ifdef __WIN32__
#define _WINCON_H 1 /* Avoid inclusion of wincon.h */
#endif
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_opengl.h>

static SDL_Window *screen = NULL;
static SDL_Renderer *renderer = NULL;

static const int SDL_SCREEN_BPP = 32;
static const int MAX_FRAME_RATE = 100;
static const char *title = "Cabrio";
static int milliPeriod;
static Uint32 lastTick;
static int frame_rate = 0;

int sdl_init( void ) {
	int mode = SDL_WINDOW_OPENGL;
	const struct config *config = config_get();
	
	if( SDL_Init(SDL_INIT_EVERYTHING) < 0 ) {
		fprintf(stderr, "Error: Unable to initialise SDL: %s\n", SDL_GetError());
		return 1;
	}
	SDL_ShowCursor(SDL_DISABLE);
	SDL_GL_SetAttribute( SDL_GL_DOUBLEBUFFER, 1 );
	if( config->iface.full_screen )
		mode |= SDL_WINDOW_FULLSCREEN;
	screen = SDL_CreateWindow("My Game Window",
														SDL_WINDOWPOS_UNDEFINED,
														SDL_WINDOWPOS_UNDEFINED,
														config->iface.screen_width, config->iface.screen_height,
														mode);
	renderer = SDL_CreateRenderer(screen, -1, 0);
	if( screen == NULL ) {
		fprintf(stderr, "Error: Unable to set video mode: %s\n", SDL_GetError());
		return 1;
	}
	frame_rate = config->iface.frame_rate;
	if( frame_rate < 0 ) {
		frame_rate = 0;
		fprintf( stderr, "Warning: Negative frame rate, setting to 0 (unlimited)\n" );
	}
	if( frame_rate > MAX_FRAME_RATE ) {
		frame_rate = MAX_FRAME_RATE;
		fprintf( stderr, "Warning: Frame rate above maximum allowed (%d) setting to maximum\n", MAX_FRAME_RATE );
	}
	if( frame_rate ) {
		//calculate the frame rate period
		double period = 1.0 / (double)frame_rate;
		period = period * 1000;
		milliPeriod = (int)period;
		lastTick = SDL_GetTicks();
	}
	//SDL_WM_SetCaption( title, NULL );
	
	return 0;
}

void sdl_free( void ) {
	//if( config_get()->iface.full_screen )
	//	SDL_SetVideoMode( saved_video.current_w, saved_video.current_h, saved_video.vfmt->BitsPerPixel, SDL_FULLSCREEN );
	SDL_Quit();
}

void sdl_begin_frame(void) {
	lastTick = SDL_GetTicks();
}

void sdl_frame_delay( void ) {
	int sleep;
	Uint32 currentTick;

	if( frame_rate ) {
		currentTick = SDL_GetTicks();

		//wait the appropriate amount of time
		sleep = milliPeriod - (currentTick - lastTick);
		if(sleep < 0) { 
			sleep = 0; 
		}
		SDL_Delay(sleep);
	}
}

void sdl_swap( void ) {
	//SDL_GL_SwapBuffers();
	SDL_RenderPresent(renderer);
}

int sdl_hat_dir_value( int direction ) {
	switch( direction ) {
		case SDL_HAT_CENTERED:
			break;
		case SDL_HAT_UP:
			return DIR_UP;
			break;
		case SDL_HAT_DOWN:
			return DIR_DOWN;
			break;
		case SDL_HAT_LEFT:
			return DIR_LEFT;
			break;
		case SDL_HAT_RIGHT:
			return DIR_RIGHT;
			break;
		default:
			fprintf( stderr, "Warning: Bogus hat direction %d\n", direction );
			break;
	}
	return 0;
}

