#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/samsung/exynos2100

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# call common exynos2100 system debug props
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
$(call inherit-product, device/samsung/exynos2100/system_prop_debug.mk)
endif

# API
PRODUCT_SHIPPING_API_LEVEL := 30
BOARD_SHIPPING_API_LEVEL := 30

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl:64 \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor:64

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml

# init
PRODUCT_PACKAGES += \
    init.exynos2100 \
    init.usb.exynos2100 \
    init.ueventd.exynos2100 \
    init.recovery.exynos2100 \
    fstab.exynos2100.etc \
    fstab.exynos2100.vendor_ramdisk \
    fstab.exynos2100.ramdisk

PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/init/fstab.exynos2100:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.exynos2100

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager
