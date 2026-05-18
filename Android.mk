# build.config.samurai
ARCH=arm64
CLANG_PREBUILT_BIN=prebuilts/clang/host/linux-x86/clang-r530567
CC=clang
LD=ld.lld
AR=llvm-ar
NM=llvm-nm
OBJCOPY=llvm-objcopy
OBJDUMP=llvm-objdump
STRIP=llvm-strip
FILES="
arch/arm64/boot/Image.lz4
arch/arm64/boot/dts/vendor/samurai.dtb
"
GKI_KERNEL=1
BUILD_GKI_CERTIFICATION_TOOLS=1

# samurai_defconfig
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_CGROUP_BPF=y
CONFIG_NET_CLS_BPF=y
CONFIG_NET_ACT_BPF=y
CONFIG_LRU_GEN=y
CONFIG_LRU_GEN_ENABLED=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_ZRAM=y
CONFIG_LZ4_COMPRESSION=y
CONFIG_ARM64_16K_PAGES=y

# include/uapi/linux/android/binder.h
#define BINDER_CURRENT_PROTOCOL_VERSION 8

# BoardConfig.mk
BOARD_VNDK_VERSION := current
PRODUCT_SHIPPING_API_LEVEL := 36
BOARD_API_LEVEL := 202504
BOARD_KERNEL_PAGESIZE := 16384
TARGET_NO_BIONIC_64K_INTEROP := true
TARGET_USES_VULKAN := true
TARGET_USES_ION := true
BOARD_AVB_ENABLE := false
PRODUCT_BUILD_PROP_FLAGS += ro.rom.maintainer=Samurai-Minhaz
DEVICE_MANIFEST_FILE := vendor/samurai/samurai/manifest.xml
DEVICE_MATRIX_FILE := vendor/samurai/samurai/compatibility_matrix.xml
BOARD_SYSTEMSDK_VERSIONS := 36

# device.mk
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 16384
PRODUCT_NO_BIONIC_64K_INTEROP := true
PRODUCT_PACKAGES += \
    android.hardware.health-service.samurai \
    android.hardware.power-service.samurai \
    android.hardware.vibrator-service.samurai \
    android.hardware.lights-service.samurai \
    android.hardware.biometrics.fingerprint-service.samurai
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.samurai:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.samurai \
    $(LOCAL_PATH)/rootdir/etc/init.samurai.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.samurai.rc

# manifest.xml
<manifest version="8.0" type="device" target-level="202504">
    <hal format="aidl">
        <name>android.hardware.health</name>
        <version>3</version>
        <interface>
            <name>IHealth</name>
            <instance>default</instance>
        </interface>
    </hal>
    <hal format="aidl">
        <name>android.hardware.power</name>
        <version>5</version>
        <interface>
            <name>IPower</name>
            <instance>default</instance>
        </interface>
    </hal>
    <hal format="aidl">
        <name>android.hardware.biometrics.fingerprint</name>
        <version>4</version>
        <interface>
            <name>IFingerprint</name>
            <instance>default</instance>
        </interface>
    </hal>
</manifest>

# fstab.samurai
/dev/block/by-name/userdata /data f2fs noatime,nosuid,nodev,discard,usrquota,grpquota wait,check,quota,latemount,resize,reservedsize=128M,checkpoint=fs,fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized,metadata_encryption=aes-256-xts,keydirectory=/metadata/vold/metadata_encryption
/dev/block/by-name/metadata /metadata ext4 noatime,nosuid,nodev,discard wait,check,formattable,first_stage_mount
/dev/block/by-name/misc /misc emmc defaults defaults

# init.samurai.rc
on early-init
    write /proc/sys/vm/max_map_count 262144
on boot
    chown system system /sys/class/backlight/panel0-backlight/brightness
    chmod 0664 /sys/class/backlight/panel0-backlight/brightness
service vendor.samurai-hal-1-0 /vendor/bin/hw/android.hardware.samurai-service
    class hal
    user system
    group system
    interface aidl android.hardware.samurai.ISamurai/default

# vendor.prop
ro.vendor.api_level=202504
ro.surface_flinger.set_idle_timer_ms=4000
ro.surface_flinger.set_touch_timer_ms=200
ro.vendor.perf.scroll_opt=1
windowsmgr.max_events_per_sec=150
persist.vendor.camera.HAL3.enabled=1
persist.vendor.camera.eis.enable=1
persist.vendor.camera.privapp.list=com.google.android.GoogleCamera,com.google.android.GoogleCamera.BSG,com.google.android.GoogleCamera.LMC
persist.vendor.audio.hifi=true
ro.vendor.audio.sdk.fluencetype=none
ro.vendor.lib64.16kb_aligned=true
ro.product.model=Pixel 9 Pro
ro.product.brand=google
ro.product.manufacturer=Google
ro.product.name=komodo
ro.product.device=komodo
ro.build.product=komodo
ro.build.description=komodo-user 15 AP3A.241005.015 12520224 release-keys
ro.build.fingerprint=google/komodo/komodo:15/AP3A.241005.015/12520224:user/release-keys
ro.opa.eligible_device=true

# Android.bp
cc_library_shared {
    name: "libvendor_samurai_ext",
    vendor: true,
    srcs: ["samurai_utils.cpp"],
    shared_libs: [
        "libbase",
        "libutils",
        "liblog",
    ],
    cflags: [
        "-Wall",
        "-Werror",
        "-fvisibility=hidden",
    ],
    16kb_page_size_compatible: true,
}