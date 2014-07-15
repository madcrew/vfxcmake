SET(Alembic_FOUND FALSE)

if (NOT DEFINED ALEMBIC_ROOT)
    if (NOT DEFINED ENV{ALEMBIC_ROOT})
        message(FATAL_ERROR "Please set ALEMBIC_ROOT.")
    endif()
    set(ALEMBIC_ROOT $ENV{ALEMBIC_ROOT})
endif()

if (NOT IS_DIRECTORY "${ALEMBIC_ROOT}")
    message(FATAL_ERROR "ALEMBIC_ROOT does not point to a valid directory")
endif()

find_path(ALEMBIC_INCLUDE_DIR
    NAMES Alembic/Abc/IObject.h
    PATHS ${ALEMBIC_ROOT}/include
)

foreach(_alembic_lib    
    AbcWFObjConvert
    AlembicAbc
    AlembicAbcCollection
    AlembicAbcCoreAbstract
    AlembicAbcCoreFactory
    AlembicAbcCoreHDF5
    AlembicAbcCoreOgawa
    AlembicAbcGeom
    AlembicAbcMaterial
    AlembicAbcOpenGL
    AlembicOgawa
    AlembicUtil)
    find_library(ALEMBIC_${_alembic_lib}_LIBRARY ${_alembic_lib}
        PATHS
            ${ALEMBIC_ROOT}/lib
            ${ALEMBIC_ROOT}/lib/static
        NO_CMAKE_SYSTEM_PATH)    
    list(APPEND _alembic_LIB_VARS ALEMBIC_${_alembic_lib}_LIBRARY)
endforeach()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Alembic DEFAULT_MSG
    _alembic_LIB_VARS ALEMBIC_INCLUDE_DIR)

