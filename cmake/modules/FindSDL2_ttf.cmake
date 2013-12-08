# Locate SDL2_ttf library
# This module defines
# SDL2TTF_LIBRARY, the name of the library to link against
# SDL2TTF_FOUND, if false, do not try to link to SDL
# SDL2TTF_INCLUDE_DIR, where to find SDL/SDL.h
#
# $SDL2DIR is an environment variable that would
# correspond to the ./configure --prefix=$SDL2DIR
# used in building SDL2.
#
# Created by Eric Wing. This was influenced by the FindSDL.cmake 
# module, but with modifications to recognize OS X frameworks and 
# additional Unix paths (FreeBSD, etc).


FIND_PATH(SDL2TTF_INCLUDE_DIR SDL_ttf.h
  PATHS
  $ENV{SDL2TTFDIR}
  $ENV{SDL2DIR}
  NO_DEFAULT_PATH
  PATH_SUFFIXES include
)

FIND_PATH(SDL2TTF_INCLUDE_DIR SDL_ttf.h
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

FIND_LIBRARY(SDL2TTF_LIBRARY 
  NAMES SDL2_ttf
  PATHS
  $ENV{SDLTTFDIR}
  $ENV{SDLDIR}
  NO_DEFAULT_PATH
    PATH_SUFFIXES lib64 lib
)

FIND_LIBRARY(SDL2TTF_LIBRARY 
  NAMES SDL2_ttf
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

SET(SDL2TTF_FOUND "NO")
IF(SDL2TTF_LIBRARY AND SDL2TTF_INCLUDE_DIR)
  SET(SDL2TTF_FOUND "YES")
ENDIF(SDL2TTF_LIBRARY AND SDL2TTF_INCLUDE_DIR)

