include(ExternalProject)
message( STATUS "External library - DJI Advanced Sensing for stereo cameras" )

set(VERSION "2.0.0")
set(LIB_NAME advanced-sensing)
set(LIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/${LIB_NAME}-${VERSION})

# Work-around to multi-library projects configuration vs. execution times restrictions
set(ADVANCED_SENSING_INCLUDE_DIRS ${LIB_PATH}/inc)
set(ADVANCED_SENSING_LIBRARY ${LIB_PATH}/lib/libadvanced-sensing.a)

# Set appropriate branch name
set(BRANCH_NAME "${LIB_NAME}-${VERSION}-${TARGET_ARCH}")
if(NOT "${PROC_VERSION}" STREQUAL "")
  set(BRANCH_NAME "${BRANCH_NAME}${PROC_VERSION}")
endif()

ExternalProject_Add(
  ${LIB_NAME}
  GIT_REPOSITORY https://github.com/dji-sdk/Onboard-SDK-Resources.git
  BINARY_DIR AdvancedSensing
  GIT_TAG ${BRANCH_NAME}
  UPDATE_COMMAND ""
  PATCH_COMMAND ""
  CMAKE_COMMAND ""
  INSTALL_COMMAND ""
  )

ExternalProject_Get_Property(${LIB_NAME} source_dir)

add_custom_command(TARGET ${LIB_NAME} POST_BUILD 
  COMMAND ${CMAKE_COMMAND} -E make_directory ${LIB_PATH}
  )

add_custom_command(TARGET ${LIB_NAME} POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E tar xzf ${source_dir}/${LIB_NAME}-${VERSION}.tar.gz
  WORKING_DIRECTORY ${LIB_PATH}
  )
