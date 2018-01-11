#
# Copyright (C) 2017 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

TARGET_BOOTLOADER_BOARD_NAME := taimen
DEFAULT_LOW_PERSISTENCE_MODE_BRIGHTNESS := 0x0000008c

include device/google/wahoo/BoardConfig.mk

BOARD_BOOTIMAGE_PARTITION_SIZE := 41943040
TARGET_BOARD_PLATFORM := msm8998

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a73

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73

ifeq ($(TARGET_DEVICE),taimen )
BOARD_KERNEL_CMDLINE += androidboot.hardware=$(TARGET_BOOTLOADER_BOARD_NAME)
BOARD_KERNEL_CMDLINE += androidboot.console=ttyMSM0,115200,n8 earlycon=msm_serial_dm,0xc1b0000
BOARD_KERNEL_CMDLINE += enforcing=0 androidboot.selinux=permissive lpm_levels.sleep_disabled=1
BOARD_KERNEL_CMDLINE += user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 service_locator.enable=1
BOARD_KERNEL_CMDLINE += swiotlb=2048 firmware_class.path=/vendor/firmware loop.max_part=7 raid=noautodetect
endif

KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin
KERNEL_TOOLCHAIN_PREFIX := aarch64-linux-android-
TARGET_KERNEL_SOURCE := kernel/google/taimen
TARGET_KERNEL_CONFIG := custom_defconfig
TARGET_KERNEL_ARCH := arm64
BOARD_KERNEL_IMAGE_NAME := Image.lz4-dtb


BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
ifeq ($(filter-out walleye_kasan, muskie_kasan, $(TARGET_PRODUCT)),)
BOARD_KERNEL_OFFSET      := 0x80000
BOARD_KERNEL_TAGS_OFFSET := 0x02500000
BOARD_RAMDISK_OFFSET     := 0x02700000
BOARD_MKBOOTIMG_ARGS     := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
else
BOARD_KERNEL_TAGS_OFFSET := 0x01E00000
BOARD_RAMDISK_OFFSET     := 0x02000000
endif

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2684354560
BOARD_SYSTEMIMAGE_JOURNAL_SIZE := 0
BOARD_SYSTEMIMAGE_EXTFS_INODE_COUNT := 4096
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_USERDATAIMAGE_PARTITION_SIZE := 26503790080
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_USERIMAGES_USE_EXT4 := true

TARGET_COPY_OUT_VENDOR := vendor

# Skip API checks.
WITHOUT_CHECK_API := true
# Don't try to build and run all tests by default. Several tests have
# dependencies on the framework.
ANDROID_NO_TEST_CHECK := true

# Install odex files into the other system image
BOARD_USES_SYSTEM_OTHER_ODEX := false

BOARD_ROOT_EXTRA_FOLDERS := persist firmware metadata
TARGET_ANDROID_FILESYSTEM_CONFIG_H := device/google/wahoo/android_filesystem_config.h

QCOM_BOARD_PLATFORMS += msm8998
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/google/wahoo/bluetooth

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
  ifeq ($(WITH_DEXPREOPT),)
    WITH_DEXPREOPT := true
    WITH_DEXPREOPT_PIC := true
    ifneq ($(TARGET_BUILD_VARIANT),user)
      # Retain classes.dex in APK's for non-user builds
      DEX_PREOPT_DEFAULT := nostripping
    endif
  endif
endif

# Camera
TARGET_USES_AOSP := true
BOARD_QTI_CAMERA_32BIT_ONLY := true
CAMERA_DAEMON_NOT_PRESENT := true
TARGET_USES_ION := true
TARGET_USES_EASEL := true
BOARD_USES_EASEL := true

# GPS
TARGET_NO_RPC := true
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
BOARD_VENDOR_QCOM_LOC_PDK_FEATURE_SET := true

# RenderScript
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so

# wlan
BOARD_WLAN_DEVICE := qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_HOSTAPD_DRIVER := NL80211
WIFI_DRIVER_DEFAULT := qca_cld3
WPA_SUPPLICANT_VERSION := VER_0_8_X
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP  := "ap"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_HIDL_FEATURE_AWARE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
USE_XML_AUDIO_POLICY_CONF := 1
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_SND_MONITOR := true
AUDIO_FEATURE_ENABLED_USB_TUNNEL := true
BOARD_ROOT_EXTRA_SYMLINKS := /vendor/lib/dsp:/dsp

# Include whaoo modules
USES_DEVICE_GOOGLE_WAHOO := true

# Graphics
TARGET_USES_GRALLOC1 := true
TARGET_USES_HWC2 := true

VSYNC_EVENT_PHASE_OFFSET_NS := 2000000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 6000000

# Display
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := false
TARGET_USES_COLOR_METADATA := true

# Charger Mode
BOARD_CHARGER_ENABLE_SUSPEND := true

# Vendor Interface Manifest
DEVICE_MANIFEST_FILE := device/google/wahoo/manifest.xml
DEVICE_MATRIX_FILE := device/google/wahoo/compatibility_matrix.xml

BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

BOARD_VNDK_VERSION := current

# sepolicy
BOARD_SEPOLICY_DIRS += device/google/taimen/sepolicy
BOARD_SEPOLICY_DIRS += device/google/wahoo/sepolicy/vendor
BOARD_PLAT_PUBLIC_SEPOLICY_DIR := device/google/wahoo/sepolicy/public
BOARD_PLAT_PRIVATE_SEPOLICY_DIR := device/google/wahoo/sepolicy/private
BOARD_SEPOLICY_DIRS += device/google/wahoo/sepolicy/verizon

# Testing related defines
BOARD_PERFSETUP_SCRIPT := platform_testing/scripts/perf-setup/wahoo-setup.sh

BOARD_LISA_TARGET_SCRIPTS := device/google/wahoo/lisa/

# Rounded corners recovery UI. 105px = 30dp * 3.5 density, where 30dp comes from
# rounded_corner_radius in overlay/frameworks/base/packages/SystemUI/res/values/dimens.xml.
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 105

# Custom taimen AVB parameters

# Android Verified Boot (AVB):
#   Builds a special vbmeta.img that disables AVB verification.
#   Otherwise, AVB will prevent the device from booting the generic system.img.
#   Also checks that BOARD_AVB_ENABLE is not set, to prevent adding verity
#   metadata into system.img.

BOARD_AVB_ENABLE := true
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
TARGET_NO_BOOTLOADER ?= true
TARGET_NO_RECOVERY := true
BOARD_USES_RECOVERY_AS_BOOT := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := device/google/wahoo/recovery.wipe
TARGET_RECOVERY_FSTAB := device/google/wahoo/fstab.hardware
