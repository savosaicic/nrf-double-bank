# Register bank1 as an external Zephyr image built under sysbuild.
ExternalZephyrProject_Add(
  APPLICATION bank1
  SOURCE_DIR  ${APP_DIR}/bank1
  BOARD       nrf9151dk/nrf9151 #TODO: build with /ns
)

# Add bank1 to the list sysbuild uses to propagate MCUboot image number
# configuration and to drive signing.
UpdateableImage_Add(APPLICATION bank1)

# Tell Partition Manager that bank1 is an app image. PM will assign it the
# mcuboot_primary_1 / mcuboot_secondary_1 slot pair from pm_static.yml.
set_property(GLOBAL APPEND PROPERTY PM_APP_IMAGES bank1)

# Force CONFIG_BOOTLOADER_MCUBOOT=y on bank1 build to enable image signing
# and ensure mcuboot_pad_1 header. Without this, bank1 builds an unsigned
# binary and the magic word at mcuboot_pad_1 stays 0xff, causing
# boot_go_hook to reject the image.
set_config_bool(bank1 CONFIG_BOOTLOADER_MCUBOOT y)

# Propagate the signing key path. sysbuild sets this automatically for
# DEFAULT_IMAGE only.
set_config_string(bank1 CONFIG_MCUBOOT_SIGNATURE_KEY_FILE
  "${ZEPHYR_MCUBOOT_MODULE_DIR}/root-ec-p256.pem")

# Inject the MCUboot hook module into the mcuboot build.
set(mcuboot_EXTRA_ZEPHYR_MODULES
    "${APP_DIR}/mcuboot_hooks"
    CACHE INTERNAL "Extra Zephyr modules for mcuboot image" FORCE)
