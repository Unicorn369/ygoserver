# File: Android.mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := zlib
LOCAL_MODULE_FILENAME := libz

LOCAL_SRC_FILES := \
    zlib.h \
    adler32.c \
    compress.c \
    crc32.h \
    crc32.c \
    deflate.h \
    deflate.c \
    inffast.h \
    inffast.c \
    inflate.h \
    inflate.c \
    inftrees.h \
    inftrees.c \
    trees.h \
    trees.c \
    uncompr.c \
    zutil.h \
    zutil.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)

#LOCAL_EXPORT_C_INCLUDES := $(LOCAL_C_INCLUDES)

include $(BUILD_STATIC_LIBRARY)
