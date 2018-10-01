include(vcpkg_common_functions)

if(VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    message("Box2D only supports building as a static library")
    set(VCPKG_LIBRARY_LINKAGE "static")
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO erincatto/Box2D
    REF a174dbac1bc32e05e790cd867d9e30fb37681d47
    SHA512 663b95ca173d343aafd71a53c0d502fa363bf8e7d5b2de9db99493830b3496325cdfcdb219f777d8e929cace1b88f61e5ca545b910bda5f7cab7011f2e65909b
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS_RELEASE -D_ITERATOR_DEBUG_LEVEL=0
)
vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH share/unofficial-box2d TARGET_PATH share/unofficial-box2d)

file(
    COPY ${SOURCE_PATH}/Box2D
    DESTINATION ${CURRENT_PACKAGES_DIR}/include
    FILES_MATCHING PATTERN "*.h"
)

vcpkg_copy_pdbs()

file(COPY ${SOURCE_PATH}/LICENSE ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/box2d)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/box2d/LICENSE ${CURRENT_PACKAGES_DIR}/share/box2d/copyright)
