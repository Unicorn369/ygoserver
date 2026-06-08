# File: Android.mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := lzma
LOCAL_MODULE_FILENAME := liblzma

LOCAL_SRC_FILES := \
    src/liblzma/check/crc32_fast.c \
    src/liblzma/common/common.c \
    src/liblzma/common/filter_common.c \
    src/liblzma/common/filter_buffer_encoder.c \
    src/liblzma/common/filter_encoder.c \
    src/liblzma/common/filter_flags_encoder.c \
    src/liblzma/common/filter_buffer_decoder.c \
    src/liblzma/common/filter_decoder.c \
    src/liblzma/common/filter_flags_decoder.c \
    src/liblzma/lzma/lzma_encoder_presets.c \
    src/liblzma/lzma/lzma_encoder.c \
    src/liblzma/lzma/lzma_encoder_optimum_fast.c \
    src/liblzma/lzma/lzma_encoder_optimum_normal.c \
    src/liblzma/lzma/lzma_decoder.c \
    src/liblzma/lzma/fastpos_table.c \
    src/liblzma/lz/lz_encoder.c \
    src/liblzma/lz/lz_encoder_mf.c \
    src/liblzma/lz/lz_decoder.c \
    src/liblzma/rangecoder/price_table.c

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/src/common \
    $(LOCAL_PATH)/src/liblzma/api \
    $(LOCAL_PATH)/src/liblzma/common \
    $(LOCAL_PATH)/src/liblzma/check \
    $(LOCAL_PATH)/src/liblzma/lzma \
    $(LOCAL_PATH)/src/liblzma/lz \
    $(LOCAL_PATH)/src/liblzma/rangecoder \
    $(LOCAL_PATH)/src/liblzma/simple \
    $(LOCAL_PATH)/src/liblzma/delta

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

LOCAL_CFLAGS := \
    -DHAVE_INTTYPES_H=1 \
    -DHAVE_STDINT_H=1 \
    -DHAVE_STDBOOL_H=1 \
    -DHAVE_STRING_H=1 \
    -DHAVE_STDLIB_H=1 \
    -DHAVE_STDIO_H=1 \
    -DHAVE_CHECK_CRC32=1 \
    -DHAVE_ENCODERS=1 \
    -DHAVE_ENCODER_LZMA1=1 \
    -DHAVE_DECODERS=1 \
    -DHAVE_DECODER_LZMA1=1 \
    -DHAVE_MF_HC3=1 \
    -DHAVE_MF_HC4=1 \
    -DHAVE_MF_BT2=1 \
    -DHAVE_MF_BT3=1 \
    -DHAVE_MF_BT4=1 \
    -DHAVE_VISIBILITY=0

include $(BUILD_STATIC_LIBRARY)
