set(SRCS main.cpp tablemodel.cpp)

qt5_add_resources(RESOURCES ../resources.qrc)

add_executable(galaxy-calculator ${SRCS} ${RESOURCES})
target_link_libraries(galaxy-calculator Qt5::Core Qt5::Qml)
