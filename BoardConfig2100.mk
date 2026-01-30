#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

TARGET_LINUX_KERNEL_VERSION := 5.4

TARGET_SOC_BASE := exynos2100

# Gralloc
BOARD_USES_ALIGN_RESTRICTION := true
BOARD_USES_EXYNOS_GRALLOC_VERSION := 4
BOARD_USES_GRALLOC_ION_SYNC := true
BOARD_EXYNOS_S10B_FORMAT_ALIGN := 64
BOARD_USES_EXYNOS_DATASPACE_FEATURE := true

# Codec2
BOARD_USE_CSC_FILTER := true
BOARD_USE_DEC_SW_CSC := false
BOARD_SUPPORT_MFC_ENC_RGB := true
BOARD_SUPPORT_MFC_ENC_BT2020 := true
BOARD_USE_BLOB_ALLOCATOR := true
BOARD_USE_QUERY_HDR2SDR := false

BOARD_USE_HEVC_HWIP := false
BOARD_HW_SUPPORT_FILMGRAIN := true

# HWComposer
BOARD_USES_EXYNOS_AFBC_FEATURE := true
BOARD_LIBHDR_PLUGIN := //vendor/samsung/exynos2100:vendor.samsung.libcolor.hardware
BOARD_LIBHDR10P_META_PLUGIN := //vendor/samsung/exynos2100:vendor.samsung.libcolor.hdr10plus

$(call soong_config_set, exynos_hwc, USES_VRR_WINCONFIG, true)

# VirtualDisplay
BOARD_USES_VIRTUAL_DISPLAY := true
BOARD_USES_DISABLE_COMPOSITIONTYPE_GLES := true
BOARD_USES_SECURE_ENCODER_ONLY := true

# SCALER
BOARD_DEFAULT_CSC_HW_SCALER := 4
BOARD_USES_SCALER_M2M1SHOT := true
BOARD_HAS_SCALER_ALIGN_RESTRICTION := true

# Acryl
BOARD_LIBACRYL_DEFAULT_SCALER := mscl_votf
$(call soong_config_set, sbwcwrapper, sbwcwrapper_priority, dpuMscl)

include hardware/samsung_slsi-linaro/config/BoardConfigCommon.mk
