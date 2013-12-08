# Locate SDL2_image library
# This module defines
# SDL2IMAGE_LIBRARY, the name of the library to link against
# SDL2IMAGE_FOUND, if false, do not try to link to SDL
# SDL2IMAGE_INCLUDE_DIR, where to find SDL/SDL.h
#
# $SDLDIR is an environment variable that would
# correspond to the ./configure --prefix=$SDLDIR
# used in building SDL.
#
# Created by Eric Wing. This was influenced by the FindSDL.cmake 
# module, but with modifications to recognize OS X frameworks and 
# additional Unix paths (FreeBSD, etc).


FIND_PATH(SDL2IMAGE_INCLUDE_DIR SDL_image.h
  PATHS
  $ENV{SDL2IMAGEDIR}
  $ENV{SDLDIR}
  NO_DEFAULT_PATH
  PATH_SUFFIXES include
)

FIND_PATH(SDL2IMAGE_INCLUDE_DIR SDL_image.h
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local/include/SDL
  /usr/include/SDL
  /usr/local/include/SDL2
  /usr/include/SDL2
  /usr/local/include
  /usr/include
  /sw/include/SDL2 # Fink
  /sw/include
  /opt/local/include/SDL2 # DarwinPorts
  /opt/local/include
  /opt/csw/include/SDL2 # Blastwave
  /opt/csw/include 
  /opt/include/SDL2
  /opt/include
)

FIND_LIBRARY(SDL2IMAGE_LIBRARY 
  NAMES SDL2_image
  PATHS
  $ENV{SDL2IMAGEDIR}
  $ENV{SDLDIR}
  NO_DEFAULT_PATH
    PATH_SUFFIXES lib64 lib
)

FIND_LIBRARY(SDL2IMAGE_LIBRARY 
  NAMES SDL2_image
  PATHS
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw
  /opt/local
  /opt/csw
  /opt
    PATH_SUFFIXES lib64 lib
)

SET(SDL2IMAGE_FOUND "NO")
IF(SDL2IMAGE_LIBRARY AND SDL2IMAGE_INCLUDE_DIR)
  SET(SDL2IMAGE_FOUND "YES")
ENDIF(SDL2IMAGE_LIBRARY AND SDL2IMAGE_INCLUDE_DIR)
