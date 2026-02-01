/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdint.h>

extern "C" {

int InitializeTarget(...) { return 0; }
int Shutdown(...) { return 0; }
int OpenEdenModel(...) { return 0; }
int OpenEdenModelFromMemory(...) { return 0; }
int CloseModel(...) { return 0; }
int ExecuteEdenModel(...) { return 0; }
int AllocateInputBuffers(...) { return 0; }
int AllocateOutputBuffers(...) { return 0; }
int LoadInputBuffers(...) { return 0; }
int LoadOutputBuffers(...) { return 0; }
int FreeBuffers(...) { return 0; }
int GetInputBufferShape(...) { return 0; }
int GetOutputBufferShape(...) { return 0; }
int _ZN4eden2rt19RunGpuBoostDurationEj(unsigned int) { return 0; }

}
