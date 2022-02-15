#
# Copyright (C) 2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/samsung/exynos2100

# Inherit non-AB Device
$(call inherit-product, $(SRC_TARGET_DIR)/product/non_ab_device.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from the proprietary version
$(call inherit-product, vendor/samsung/exynos2100/exynos2100-vendor.mk)

# call common exynos2100 system debug props
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
$(call inherit-product, device/samsung/exynos2100/system_prop_debug.mk)
endif

# API
PRODUCT_SHIPPING_API_LEVEL := 30
BOARD_SHIPPING_API_LEVEL := 30

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@7.0-impl:32 \
    android.hardware.audio.service \
    android.hardware.audio.effect@7.0-impl:32 \
    android.hardware.soundtrigger@2.3-impl:32 \
    audio.bluetooth.default \
    android.hardware.bluetooth.audio-impl \
    audio.r_submix.default \
    audio.usbv2.default

TARGET_EXCLUDES_AUDIOFX := true

PRODUCT_PACKAGES += \
    audio_board_info.exynos2100 \
    audio_effects.exynos2100 \
    audio_policy_config.exynos2100

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_with_le_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_with_le_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl:64 \
    android.hardware.bluetooth@1.0-service \
    libbt-vendor:64

PRODUCT_PACKAGES += \
    android.hardware.bluetooth.prebuilt.xml \
    android.hardware.bluetooth_le.prebuilt.xml

$(call soong_config_set,brcm_libbt,custom_bt_config,//$(COMMON_PATH):exynos2100.txt)

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm-service.clearkey

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(COMMON_PATH)/overlay
PRODUCT_ENFORCE_RRO_TARGETS := *

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl:64 \
    android.hardware.gatekeeper@1.0-service

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-service.samsung \
    libkeymaster4_1support.vendor:64

$(call soong_config_set,samsungVars,target_keymaster4_library,//vendor/samsung/exynos2100:libskeymaster4device)

# Kernel
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := true
PRODUCT_ENABLE_UFFD_GC := true

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

# Light
PRODUCT_PACKAGES += \
    android.hardware.light-service.samsung

# Soong Namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(COMMON_PATH) \
    hardware/broadcom/libbt \
    hardware/google/interfaces \
    hardware/google/pixel \
    hardware/samsung

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors-service.samsung-multihal

PRODUCT_PACKAGES += \
    android.hardware.sensor.accelerometer.prebuilt.xml \
    android.hardware.sensor.barometer.prebuilt.xml \
    android.hardware.sensor.compass.prebuilt.xml \
    android.hardware.sensor.gyroscope.prebuilt.xml \
    android.hardware.sensor.hifi_sensors.prebuilt.xml \
    android.hardware.sensor.light.prebuilt.xml \
    android.hardware.sensor.proximity.prebuilt.xml \
    android.hardware.sensor.stepcounter.prebuilt.xml \
    android.hardware.sensor.stepdetector.prebuilt.xml

# Memtrack
PRODUCT_PACKAGES += \
    android.hardware.memtrack-service.samsung-mali

# Power
PRODUCT_PACKAGES += \
    android.hardware.power-service.pixel-libperfmgr

PRODUCT_PACKAGES += \
    powerhint.json.exynos2100

# RIL
PRODUCT_PACKAGES += \
    secril_config_svc \
    sehradiomanager

PRODUCT_PACKAGES += \
    android.hardware.telephony.gsm.prebuilt.xml \
    android.hardware.telephony.ims.prebuilt.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.telephony.satellite.xml

# Update
AB_OTA_UPDATER := false
PRODUCT_SOONG_NAMESPACES += bootable/deprecated-ota

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.samsung \
    android.hardware.usb.gadget-service.samsung

$(call soong_config_set,samsungUsbGadgetVars,gadget_name,10e00000.usb)

PRODUCT_PACKAGES += \
    android.hardware.usb.accessory.prebuilt.xml \
    android.hardware.usb.host.prebuilt.xml

# Vendor service manager
PRODUCT_PACKAGES += \
    vndservicemanager

# Weaver
PRODUCT_PACKAGES += \
    android.hardware.weaver@1.0.vendor:64

# WiFi
PRODUCT_PACKAGES += \
    android.hardware.wifi-service \
    hostapd \
    WifiOverlay \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_PACKAGES += \
    p2p_supplicant_overlay.conf.exynos2100 \
    wpa_supplicant_overlay.conf.exynos2100

PRODUCT_PACKAGES += \
    android.hardware.wifi.direct.prebuilt.xml \
    android.hardware.wifi.passpoint.prebuilt.xml \
    android.hardware.wifi.prebuilt.xml

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.aware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.aware.xml \
    frameworks/native/data/etc/android.hardware.wifi.rtt.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.rtt.xml
