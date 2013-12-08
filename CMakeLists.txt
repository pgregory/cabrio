set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules")
cmake_minimum_required ( VERSION 2.6 )

project (CabrioFE)

set(DATA_DIR "${CMAKE_SOURCE_DIR}/data" CACHE PATH "The Cabrio data directory")

find_package(OpenGL REQUIRED)
find_package(SDL2 REQUIRED)
find_package(SDL2_ttf REQUIRED)
find_package(SDL2_image REQUIRED)
find_package(SDL2_mixer REQUIRED)
find_package(LibXml2 REQUIRED)
find_package(FFMPEG REQUIRED)

set(LIBS ${LIBS} ${OPENGL_LIBRARIES})
list(APPEND LIBS ${SDL2_LIBRARY})
list(APPEND LIBS ${SDL2TTF_LIBRARY})
list(APPEND LIBS ${SDL2MIXER_LIBRARY})
list(APPEND LIBS ${SDL2IMAGE_LIBRARY})
list(APPEND LIBS ${LIBXML2_LIBRARIES})
list(APPEND LIBS ${FFMPEG_LIBRARIES})

set(source
  bg.c
  category.c
  config.c
  control.c
  emulator.c
  event.c
  focus.c
  font.c
  frame.c
  game.c
  game_sel.c
  hint.c
  key.c
  location.c
  lookup.c
  main.c
  media.c
  menu.c
  ogl.c
  packet.c
  platform.c
  sdl_ogl.c
  sdl_wrapper.c
  setup.c
  snap.c
  sound.c
  submenu.c
  video.c 
)

set(headers
  include/bg.h
  include/category.h
  include/config.h
  include/control.h
  include/emulator.h
  include/event.h
  include/focus.h
  include/font.h
  include/frame.h
  include/game.h
  include/game_sel.h
  include/hint.h
  include/key.h
  include/location.h
  include/lookup.h
  include/media.h
  include/menu.h
  include/ogl.h
  include/packet.h
  include/platform.h
  include/sdl_ogl.h
  include/sdl_wrapper.h
  include/setup.h
  include/snap.h
  include/sound.h
  include/submenu.h
  include/video.h
)

include_directories(${CMAKE_SOURCE_DIR}/include)
include_directories(${SDL2_INCLUDE_DIR} ${SDL2TTF_INCLUDE_DIR} ${SDL2IMAGE_INCLUDE_DIR} ${SDL2MIXER_INCLUDE_DIR})
include_directories(${OPENGL_INCLUDE_DIR})
include_directories(${LIBXML2_INCLUDE_DIR})
include_directories(${FFMPEG_INCLUDE_DIR})
add_definitions(-DDATA_DIR="${DATA_DIR}")
  
add_executable(cabrio ${source} ${headers})
source_group(Headers FILES ${headers})
source_group(Source FILES ${shared_srcs})

target_link_libraries(cabrio ${LIBS})


install(TARGETS cabrio RUNTIME DESTINATION .)
#install(FILES ${CMAKE_CURRENT_BINARY_DIR}/serverSystemImage DESTINATION .)

