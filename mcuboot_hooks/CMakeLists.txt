# Only contribute sources when we are compiling into the mcuboot image and
# hooks are enabled. CONFIG_MCUBOOT is defined inside the mcuboot build only.
if(CONFIG_MCUBOOT AND CONFIG_BOOT_IMAGE_ACCESS_HOOKS)
  zephyr_library()
  zephyr_library_sources(src/boot_hooks.c)

  # MCUboot's bootutil headers are not on the
  # default include path for Zephyr modules. Add them explicitly.
  zephyr_library_include_directories(
    ${ZEPHYR_MCUBOOT_MODULE_DIR}/boot/bootutil/include
    ${ZEPHYR_MCUBOOT_MODULE_DIR}/boot/zephyr/include
  )
endif()
