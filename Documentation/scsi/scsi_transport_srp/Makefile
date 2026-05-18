# BoardConfig.mk for samurai (Realme X2 Pro) - Android 16 (Baklava)
BOARD_VNDK_VERSION := current
PRODUCT_SHIPPING_API_LEVEL := 36
BOARD_API_LEVEL := 202504
BOARD_KERNEL_PAGESIZE := 16384
TARGET_NO_BIONIC_64K_INTEROP := true
BOARD_AVB_ENABLE := false
TARGET_USES_VULKAN := true
TARGET_USES_ION := true
BOARD_USES_ADRENO := true
TARGET_SCREEN_DENSITY := 480
BOARD_SEPOLICY_DIRS += device/samurai/samurai/sepolicy

# Product Configuration & Maintainer Signature
PRODUCT_BUILD_PROP_FLAGS += ro.rom.maintainer=Samurai-Minhaz
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 16384
PRODUCT_NO_BIONIC_64K_INTEROP := true

# System Properties - Performance, Display, Camera, and Audio
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=4000 \
    ro.surface_flinger.set_touch_timer_ms=200 \
    ro.vendor.perf.scroll_opt=1 \
    windowsmgr.max_events_per_sec=150 \
    persist.vendor.camera.HAL3.enabled=1 \
    persist.vendor.camera.eis.enable=1 \
    persist.vendor.camera.privapp.list=com.google.android.GoogleCamera,com.google.android.GoogleCamera.BSG,com.google.android.GoogleCamera.LMC \
    persist.vendor.audio.hifi=true \
    ro.vendor.audio.sdk.fluencetype=none \
    ro.vendor.api_level=202504 \
    dalvik.vm.dex2oat64-threads=8 \
    ro.vendor.lib64.16kb_aligned=true

# Play Integrity & Device Spoofing (Pixel 9 Pro XL)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.model=Pixel 9 Pro XL \
    ro.product.brand=google \
    ro.product.manufacturer=Google \
    ro.build.fingerprint=google/komodo/komodo:15/AP3A.241005.015/12533533:user/release-keys \
    ro.build.description=komodo-user 15 AP3A.241005.015 12533533 release-keys

# Kernel Defconfig Optimizations (samurai_defconfig)
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_ZRAM=y
CONFIG_LZ4_COMPRESSION=y
CONFIG_ARM64_16K_PAGES=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_CFI_CLANG=y

# AIDL HALs Migration for Android 16
PRODUCT_PACKAGES += \
    android.hardware.health-service.samurai \
    android.hardware.power-service.samurai \
    android.hardware.vibrator-service.samurai \
    android.hardware.lights-service.samurai \
    android.hardware.biometrics.fingerprint-service.samurai

# Build Rules for State Diagrams
all: rport_state_diagram.svg rport_state_diagram.png

rport_state_diagram.svg: rport_state_diagram.dot
	dot -Tsvg -o $@ $<

rport_state_diagram.png: rport_state_diagram.dot
	dot -Tpng -o $@ $<