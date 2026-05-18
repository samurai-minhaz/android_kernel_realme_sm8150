# Samurai-Minhaz Ultimate Optimization for Android 16 (Baklava)
# Target Device: samurai (Realme X2 Pro)

# Performance & Graphics Optimization
TARGET_USES_VULKAN := true
TARGET_USES_ION := true
BOARD_KERNEL_PAGESIZE := 16384
PRODUCT_MAX_PAGE_SIZE_SUPPORTED := 16384
PRODUCT_NO_BIONIC_64K_INTEROP := true

# Security & Boot Configuration
BOARD_AVB_ENABLE := false
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
BOARD_KERNEL_CMDLINE += androidboot.selinux=enforcing
PRODUCT_BUILD_PROP_FLAGS += ro.rom.maintainer=Samurai-Minhaz

# System Properties: Ultra-Smooth 90Hz & Lag Fix
PRODUCT_PROPERTY_OVERRIDES += \
    ro.surface_flinger.set_idle_timer_ms=4000 \
    ro.surface_flinger.set_touch_timer_ms=200 \
    ro.vendor.perf.scroll_opt=1 \
    windowsmgr.max_events_per_sec=150

# System Properties: Camera HAL3 & GCam Support
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.camera.HAL3.enabled=1 \
    persist.vendor.camera.eis.enable=1 \
    persist.vendor.camera.privapp.list=com.google.android.GoogleCamera,com.google.android.GoogleCamera.BSG,com.google.android.GoogleCamera.LMC

# System Properties: Premium Audio Stack
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.audio.hifi=true \
    ro.vendor.audio.sdk.fluencetype=none

# Play Integrity & Device Spoofing (Pixel 9 Pro - Baklava Ready)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.model=Pixel 9 Pro \
    ro.product.brand=google \
    ro.product.manufacturer=Google \
    ro.build.fingerprint=google/komodo/komodo:15/AP3A.241005.015/12534744:user/release-keys \
    ro.build.id=AP3A.241005.015 \
    ro.build.type=user \
    ro.build.tags=release-keys

# Kernel Defconfig Injections (Performance & Memory)
# CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_ZRAM=y
# CONFIG_LZ4_COMPRESSION=y
# CONFIG_LRU_GEN=y
# CONFIG_LRU_GEN_ENABLED=y

# Rules to convert a .h file to inline RST documentation
SRC_DIR=$(srctree)/Documentation/media
PARSER = $(srctree)/Documentation/sphinx/parse-headers.pl
UAPI = $(srctree)/include/uapi/linux
KAPI = $(srctree)/include/linux

FILES = audio.h.rst ca.h.rst dmx.h.rst frontend.h.rst net.h.rst video.h.rst \
	  videodev2.h.rst media.h.rst cec.h.rst lirc.h.rst

TARGETS := $(addprefix $(BUILDDIR)/, $(FILES))

gen_rst = \
	echo ${PARSER} $< $@ $(SRC_DIR)/$(notdir $@).exceptions; \
	${PARSER} $< $@ $(SRC_DIR)/$(notdir $@).exceptions

quiet_gen_rst = echo '  PARSE   $(patsubst $(srctree)/%,%,$<)'; \
	${PARSER} $< $@ $(SRC_DIR)/$(notdir $@).exceptions

silent_gen_rst = ${gen_rst}

$(BUILDDIR)/audio.h.rst: ${UAPI}/dvb/audio.h ${PARSER} $(SRC_DIR)/audio.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/ca.h.rst: ${UAPI}/dvb/ca.h ${PARSER} $(SRC_DIR)/ca.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/dmx.h.rst: ${UAPI}/dvb/dmx.h ${PARSER} $(SRC_DIR)/dmx.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/frontend.h.rst: ${UAPI}/dvb/frontend.h ${PARSER} $(SRC_DIR)/frontend.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/net.h.rst: ${UAPI}/dvb/net.h ${PARSER} $(SRC_DIR)/net.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/video.h.rst: ${UAPI}/dvb/video.h ${PARSER} $(SRC_DIR)/video.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/videodev2.h.rst: ${UAPI}/videodev2.h ${PARSER} $(SRC_DIR)/videodev2.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/media.h.rst: ${UAPI}/media.h ${PARSER} $(SRC_DIR)/media.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/cec.h.rst: ${UAPI}/cec.h ${PARSER} $(SRC_DIR)/cec.h.rst.exceptions
	@$($(quiet)gen_rst)

$(BUILDDIR)/lirc.h.rst: ${UAPI}/lirc.h ${PARSER} $(SRC_DIR)/lirc.h.rst.exceptions
	@$($(quiet)gen_rst)

# Media build rules

.PHONY: all html epub xml latex

all: $(IMGDOT) $(BUILDDIR) ${TARGETS}
html: all
epub: all
xml: all
latex: $(IMGPDF) all
linkcheck:

clean:
	-rm -f $(DOTTGT) $(IMGTGT) ${TARGETS} 2>/dev/null

$(BUILDDIR):
	$(Q)mkdir -p $@