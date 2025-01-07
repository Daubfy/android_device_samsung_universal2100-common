#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/samsung/exynos2100',
    'hardware/samsung',
    'vendor/samsung/exynos2100'
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libuuid',
    ): lib_fixup_vendor_suffix,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libkeymaster_helper.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .sig_replace(
            '82 0C 80 52 24 00 80 52 E1 03 15 AA 08 00 40 F9 E3 03 14 AA',
            '82 0C 80 52 24 00 80 52 E1 03 15 AA 08 00 40 F9 03 00 80 D2'
        ),
    'vendor/lib64/libskeymaster4device.so': blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so')
        .add_needed('libshim_crypto.so'),
    (
        'vendor/lib/soundfx/libaudioeffectoffload.so',
        'vendor/lib/hw/audio.primary.exynos2100.so',
        'vendor/lib64/soundfx/libaudioeffectoffload.so'
    ): blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute_exynos2100.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_exynos2100.so'),
   (
       'vendor/lib/libaudioroute_exynos2100.so',
       'vendor/lib64/libaudioroute_exynos2100.so',
   ): blob_fixup()
        .replace_needed('libtinyalsa.so', 'libtinyalsa_exynos2100.so'),
   (
       'vendor/lib/libaudioproxy2.so',
       'vendor/lib64/libaudioproxy2.so',
   ): blob_fixup()
        .remove_needed('libhwbinder.so')
        .replace_needed('libaudioroute.so', 'libaudioroute_exynos2100.so')
        .replace_needed('libtinyalsa.so', 'libtinyalsa_exynos2100.so'),
   (
       'vendor/lib/hw/audio.primary.exynos2100.so',
       'vendor/lib/libaboxpcmdump.so',
       'vendor/lib/libaudioparamupdate.so',
       'vendor/lib64/libaudioparamupdate.so',
   ): blob_fixup()
        .replace_needed('libaudioroute.so', 'libaudioroute_exynos2100.so'),
    'vendor/bin/hermesd': blob_fixup()
        .binary_regex_replace(
            b'security.securehw.available',
            b'vendor.securehw.available\x00\x00'
        )
        .binary_regex_replace(
            b'security.securenvm.available',
            b'vendor.securenvm.available\x00\x00'
        ),
}  # fmt: skip

module = ExtractUtilsModule(
    'exynos2100',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
