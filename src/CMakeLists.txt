set (CONFIG_FILE ${CMAKE_CURRENT_BINARY_DIR}/Config.vala)
configure_file (${CMAKE_SOURCE_DIR}/Config.vala.cmake ${CONFIG_FILE})

vala_precompile (VALA_C ${CMAKE_PROJECT_NAME}
    Classes/VirtualMachine.vala
    Dialogs/Preferences.vala
    Views/NoVboxView.vala
    Views/AllVmsView.vala
    Views/RunningVmsView.vala
    Utils/VboxCommands.vala
    Widgets/VirtualMachineRow.vala
    Settings.vala
    MainWindow.vala
    Application.vala
PACKAGES
    granite
    gtk+-3.0
    glib-2.0
    gmodule-2.0
OPTIONS
    --vapidir=${CMAKE_SOURCE_DIR}/vapi
    --target-glib=2.32
    --thread
)

add_executable (${CMAKE_PROJECT_NAME} ${VALA_C})
target_link_libraries (${CMAKE_PROJECT_NAME} ${DEPS_LIBRARIES})

# Installation
install (TARGETS ${CMAKE_PROJECT_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_FULL_BINDIR})
