cmake_minimum_required( VERSION 3.14 )

project( md5fort )
enable_language( Fortran )

find_package( OpenSSL REQUIRED )

add_library( md5 md5.f90 c_md5.c )

target_include_directories( md5 PUBLIC ${OPENSSL_INCLUDE_DIR} )
target_link_libraries( md5 PUBLIC ${OPENSSL_LIBRARIES} )

add_executable( example example.f90 )

target_link_libraries( example md5 )
