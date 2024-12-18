# EXAMPLES

set(EXAMPLES_FOLDER ${CMAKE_BINARY_DIR}/examples)

#test
add_executable(DEexample ${GUI_TYPE}
        "examples/main.cpp"
)

#All collections should be installed in this path if used collect_together
target_include_directories(DEexample PRIVATE ${COLLECTOR_BASE_INSTALL_PREFIX}/include)
target_link_directories(DEexample PRIVATE ${COLLECTOR_BASE_INSTALL_PREFIX}/lib)
target_include_directories(DEexample PRIVATE ${COLLECTOR_BASE_INSTALL_PREFIX}/SRCONLY/_glm.git)

add_dependencies(DEexample Dominique)

target_link_libraries(DEexample PRIVATE Dominique)

set_target_properties(DEexample PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${EXAMPLES_FOLDER})


### Add some usable files to examples folder
set(ExamplesRequiredExtras
        "res/icon.png"
        "res/WaterBottle.gltf"
        "res/shaders/baseFragment.glsl"
        "res/shaders/baseVertex.glsl"
        "res/textures/lava.png"
        # "res/models/Prop_Tree_Palm_3.obj"
)

get_target_property(EXAMPLES_BINARY_EXECUTABLE_OUTPUT DEexample RUNTIME_OUTPUT_DIRECTORY)

foreach (_file ${ExamplesRequiredExtras})
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
        list(APPEND extraFiles COMMAND "${CMAKE_COMMAND}" -E copy_if_different "${PROJECT_SOURCE_DIR}/${_file}" "${EXAMPLES_BINARY_EXECUTABLE_OUTPUT}/$<CONFIG>/")
    else ()
        list(APPEND extraFiles COMMAND "${CMAKE_COMMAND}" -E copy_if_different "${PROJECT_SOURCE_DIR}/${_file}" "${EXAMPLES_BINARY_EXECUTABLE_OUTPUT}/")
    endif ()
endforeach ()

add_custom_command(TARGET DEexample POST_BUILD
        ${extraFiles}
)