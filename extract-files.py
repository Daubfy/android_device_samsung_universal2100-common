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
    'device/samsung/universal2100-common',
    'hardware/samsung',
    'hardware/samsung_slsi-linaro/exynos',
    'hardware/samsung_slsi-linaro/graphics',
    'vendor/samsung/universal2100-common'
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
    (
        'vendor/lib64/libkeymaster_helper.so',
        'vendor/lib64/libskeymaster4device.so',
    ): blob_fixup()
        .replace_needed('libcrypto.so', 'libcrypto-v33.so'),
    'vendor/lib64/libexynoscamera_plugin.so': blob_fixup()
        .add_needed('libvpl.so'),
    'vendor/lib64/libsemseg.so': blob_fixup()
        .remove_needed('libeden_gpu_boost_stub_vendor.edensdk.samsung.so')
        .remove_needed('libeden_nn.so')
        .add_needed('libc++_shared.so')
        .add_needed('libshim_eden.so'),
    'vendor/lib64/libsec-ril.so': blob_fixup()
        .replace_needed(
            'libprotobuf-cpp-full-21.7.so',
            'libprotobuf-cpp-full-21.12.so'
        )
        .sig_replace(
            '80 0E 40 F9 E1 03 16 AA 82 0C 80 52 E3 03 15 AA',
            '80 0E 40 F9 E1 03 16 AA 82 0C 80 52 03 00 80 D2'
        ),
    'vendor/lib64/libVendorSemTelephonyProps.so': blob_fixup()
        .binary_regex_replace(
            b'persist.ril.supportNrModefromCp',
            b'vendor.ril.supportNrModefromCp\x00'
        ),
    'vendor/lib64/libsensorlistener.so': blob_fixup()
        .add_needed('libsensorndkbridge_shim.so')
        .add_needed('libutils-v32.so')
        .binary_regex_replace(
            b'_ZN7android6Thread3runEPKcim',
            b'_ZN7utils326Thread3runEPKcim'
        ),
    'vendor/lib/libwvhidl.so': blob_fixup()
        .replace_needed('libprotobuf-cpp-lite-3.9.1.so', 'libprotobuf-cpp-full-3.9.1.so')
        .add_needed('libcrypto_shim.so'),
    'vendor/lib64/libFilmGrainNoise.so': blob_fixup()
        .replace_needed('libOpenCL.so', 'libGLES_mali.so'),
    (
        'vendor/lib/soundfx/libaudioeffectoffload.so',
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
    'universal2100-common',
    'samsung',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
