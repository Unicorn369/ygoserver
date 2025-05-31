-- default global settings

BUILD_LUA = true
LUA_LIB_NAME = "lua"

BUILD_EVENT = os.istarget("windows")
BUILD_FREETYPE = os.istarget("windows")
BUILD_SQLITE = os.istarget("windows")
BUILD_IRRLICHT = true

USE_AUDIO = true
AUDIO_LIB = "miniaudio"
MINIAUDIO_SUPPORT_OPUS_VORBIS = true
MINIAUDIO_BUILD_OPUS_VORBIS = os.istarget("windows")
IRRKLANG_PRO = false
IRRKLANG_PRO_BUILD_IKPMP3 = false

SERVER_MODE = true
SERVER_ZIP_SUPPORT = false
SERVER_PRO2_SUPPORT = false
SERVER_PRO3_SUPPORT = false
SERVER_TAG_SURRENDER_CONFIRM = false
USE_IRRKLANG = false

-- read settings from command line or environment variables

newoption { trigger = "build-lua", category = "YGOPro - lua", description = "" }
newoption { trigger = "no-build-lua", category = "YGOPro - lua", description = "" }
newoption { trigger = "lua-include-dir", category = "YGOPro - lua", description = "", value = "PATH" }
newoption { trigger = "lua-lib-dir", category = "YGOPro - lua", description = "", value = "PATH" }
newoption { trigger = "lua-lib-name", category = "YGOPro - lua", description = "", value = "NAME", default = LUA_LIB_NAME }
newoption { trigger = "lua-deb", category = "YGOPro - lua", description = "" }

newoption { trigger = "build-event", category = "YGOPro - event", description = "" }
newoption { trigger = "no-build-event", category = "YGOPro - event", description = "" }
newoption { trigger = "event-include-dir", category = "YGOPro - event", description = "", value = "PATH" }
newoption { trigger = "event-lib-dir", category = "YGOPro - event", description = "", value = "PATH" }

newoption { trigger = "build-freetype", category = "YGOPro - freetype", description = "" }
newoption { trigger = "no-build-freetype", category = "YGOPro - freetype", description = "" }
newoption { trigger = "freetype-include-dir", category = "YGOPro - freetype", description = "", value = "PATH" }
newoption { trigger = "freetype-lib-dir", category = "YGOPro - freetype", description = "", value = "PATH" }

newoption { trigger = "build-sqlite", category = "YGOPro - sqlite", description = "" }
newoption { trigger = "no-build-sqlite", category = "YGOPro - sqlite", description = "" }
newoption { trigger = "sqlite-include-dir", category = "YGOPro - sqlite", description = "", value = "PATH" }
newoption { trigger = "sqlite-lib-dir", category = "YGOPro - sqlite", description = "", value = "PATH" }

newoption { trigger = "build-irrlicht", category = "YGOPro - irrlicht", description = "" }
newoption { trigger = "no-build-irrlicht", category = "YGOPro - irrlicht", description = "" }
newoption { trigger = "irrlicht-include-dir", category = "YGOPro - irrlicht", description = "", value = "PATH" }
newoption { trigger = "irrlicht-lib-dir", category = "YGOPro - irrlicht", description = "", value = "PATH" }

newoption { trigger = "no-audio", category = "YGOPro", description = "" }
newoption { trigger = "audio-lib", category = "YGOPro", description = "", value = "miniaudio, irrklang", default = AUDIO_LIB }

newoption { trigger = "miniaudio-support-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
newoption { trigger = "no-miniaudio-support-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
newoption { trigger = "build-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
newoption { trigger = "no-build-opus-vorbis", category = "YGOPro - miniaudio", description = "" }
newoption { trigger = "opus-include-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "opus-lib-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "opusfile-include-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "opusfile-lib-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "vorbis-include-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "vorbis-lib-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "ogg-include-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }
newoption { trigger = "ogg-lib-dir", category = "YGOPro - miniaudio", description = "", value = "PATH" }

newoption { trigger = "use-irrklang", category = "YGOPro - irrklang", description = "Deprecated, use audio-lib=irrklang" }
newoption { trigger = "no-use-irrklang", category = "YGOPro - irrklang", description = "Deprecated, use no-audio" }
newoption { trigger = "irrklang-include-dir", category = "YGOPro - irrklang", description = "", value = "PATH" }
newoption { trigger = "irrklang-lib-dir", category = "YGOPro - irrklang", description = "", value = "PATH" }

newoption { trigger = "irrklang-pro", category = "YGOPro - irrklang - pro", description = "" }
newoption { trigger = "no-irrklang-pro", category = "YGOPro - irrklang - pro", description = "" }
newoption { trigger = "irrklang-pro-release-lib-dir", category = "YGOPro - irrklang - pro", description = "", value = "PATH" }
newoption { trigger = "irrklang-pro-debug-lib-dir", category = "YGOPro - irrklang - pro", description = "", value = "PATH" }
newoption { trigger = 'build-ikpmp3', category = "YGOPro - irrklang - ikpmp3", description = "" }

newoption { trigger = "winxp-support", category = "YGOPro", description = "" }
newoption { trigger = "mac-arm", category = "YGOPro", description = "Cross compile for Apple Silicon" }

newoption { trigger = "server-mode", category = "YGOPro - server", description = "" }
newoption { trigger = "server-zip-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-pro2-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-pro3-support", category = "YGOPro - server", description = "" }
newoption { trigger = "server-tag-surrender-confirm", category = "YGOPro - server", description = "" }

boolOptions = {
    "compat-mycard",
    "no-lua-safe",
    "message-debug",
    "no-side-check",
    "enable-debug-func",
    "log-lua-memory-size",
    "log-in-chat",
}

for _, boolOption in ipairs(boolOptions) do
    newoption { trigger = boolOption, category = "YGOPro - options", description = "" }
end

numberOptions = {
    "default-duel-rule",
    "max-deck",
    "min-deck",
    "max-extra",
    "max-side",
    "lua-memory-size",
}

for _, numberOption in ipairs(numberOptions) do
    newoption { trigger = numberOption, category = "YGOPro - options", description = "", value = "NUMBER" }
end

function GetParam(param)
    return _OPTIONS[param] or os.getenv(string.upper(string.gsub(param,"-","_")))
end

function ApplyBoolean(param)
    if GetParam(param) then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) }
    end
end

function ApplyNumber(param)
    local value = GetParam(param)
    if not value then return end
    local numberValue = tonumber(value)
    if numberValue then
        defines { "YGOPRO_" .. string.upper(string.gsub(param,"-","_")) .. "=" .. numberValue }
    end
end

function FindHeaderWithSubDir(header, subdir)
    local result = os.findheader(header)
    if result and subdir then
        result = path.join(result, subdir)
    end
    return result
end

if GetParam("build-lua") then
    BUILD_LUA = true
elseif GetParam("no-build-lua") then
    BUILD_LUA = false
end
if not BUILD_LUA then
    -- at most times you need to change this if you change BUILD_LUA to false
    -- make sure your lua lib is built with C++ and version >= 5.3
    LUA_LIB_NAME = GetParam("lua-lib-name")
    LUA_INCLUDE_DIR = GetParam("lua-include-dir") or os.findheader("lua.h")
    LUA_LIB_DIR = GetParam("lua-lib-dir") or os.findlib(LUA_LIB_NAME)
end

if GetParam("lua-deb") then
    BUILD_LUA = false
    local lua_versions = { "5.4", "5.3" }
    local lua_version = nil
    for _, version in ipairs(lua_versions) do
        local lua_lib_dir = os.findlib("lua" .. version .. "-c++")
        if lua_lib_dir then
            print("Found lua " .. version .. " at " .. lua_lib_dir)
            lua_version = version
            LUA_LIB_DIR = lua_lib_dir
            break
        end
    end
    if not lua_version then
        error("Lua library not found. Please install lua by command 'sudo apt -y install liblua5.4-dev'")
    end
    LUA_LIB_NAME = "lua" .. lua_version .. "-c++"
    LUA_INCLUDE_DIR = path.join("/usr/include", "lua" .. lua_version)
end

if GetParam("build-event") then
    BUILD_EVENT = true -- only on windows for now
elseif GetParam("no-build-event") then
    BUILD_EVENT = false
end
if not BUILD_EVENT then
    EVENT_INCLUDE_DIR = GetParam("event-include-dir") or os.findheader("event2/event.h")
    EVENT_LIB_DIR = GetParam("event-lib-dir") or os.findlib("event")
end

if GetParam("build-freetype") then
    BUILD_FREETYPE = true
elseif GetParam("no-build-freetype") then
    BUILD_FREETYPE = false
end
if not BUILD_FREETYPE then
    FREETYPE_INCLUDE_DIR = GetParam("freetype-include-dir") or FindHeaderWithSubDir("freetype2/ft2build.h", "freetype2")
    FREETYPE_LIB_DIR = GetParam("freetype-lib-dir") or os.findlib("freetype")
end

if GetParam("build-sqlite") then
    BUILD_SQLITE = true
elseif GetParam("no-build-sqlite") then
    BUILD_SQLITE = false
end
if not BUILD_SQLITE then
    SQLITE_INCLUDE_DIR = GetParam("sqlite-include-dir") or os.findheader("sqlite3.h")
    SQLITE_LIB_DIR = GetParam("sqlite-lib-dir") or os.findlib("sqlite3")
end

if GetParam("build-irrlicht") then
    BUILD_IRRLICHT = true
elseif GetParam("no-build-irrlicht") then
    BUILD_IRRLICHT = false
end
if not BUILD_IRRLICHT then
    IRRLICHT_INCLUDE_DIR = GetParam("irrlicht-include-dir") or os.findheader("irrlicht.h")
    IRRLICHT_LIB_DIR = GetParam("irrlicht-lib-dir") or os.findlib("irrlicht")
end

USE_AUDIO = not SERVER_MODE and not GetParam("no-audio")
if GetParam("no-audio") then
    USE_AUDIO = false
elseif GetParam("no-use-miniaudio") then
    print("Warning: --no-use-miniaudio is deprecated, use --no-audio")
    USE_AUDIO = false
elseif GetParam("use-miniaudio") then
    print("Warning: --use-miniaudio is deprecated, use --audio-lib=miniaudio")
    USE_AUDIO = true
    AUDIO_LIB = "miniaudio"
elseif GetParam("no-use-irrklang") then
    print("Warning: --no-use-irrklang is deprecated, use --no-audio")
    USE_AUDIO = false
elseif GetParam("use-irrklang") then
    print("Warning: --use-irrklang is deprecated, use --audio-lib=irrklang")
    USE_AUDIO = true
    AUDIO_LIB = "irrklang"
end

if USE_AUDIO then
    AUDIO_LIB = GetParam("audio-lib") or AUDIO_LIB
    if AUDIO_LIB == "miniaudio" then
        if GetParam("miniaudio-support-opus-vorbis") then
            MINIAUDIO_SUPPORT_OPUS_VORBIS = true
        elseif GetParam("no-miniaudio-support-opus-vorbis") then
            MINIAUDIO_SUPPORT_OPUS_VORBIS = false
        end
        if MINIAUDIO_SUPPORT_OPUS_VORBIS then
            if GetParam("no-build-opus-vorbis") then
                MINIAUDIO_BUILD_OPUS_VORBIS = false
            elseif GetParam("build-opus-vorbis") then
                MINIAUDIO_BUILD_OPUS_VORBIS = true
            end
            if not MINIAUDIO_BUILD_OPUS_VORBIS then
                OPUS_INCLUDE_DIR = GetParam("opus-include-dir") or FindHeaderWithSubDir("opus/opus.h", "opus")
                OPUS_LIB_DIR = GetParam("opus-lib-dir") or os.findlib("opus")
                OPUSFILE_INCLUDE_DIR = GetParam("opusfile-include-dir") or FindHeaderWithSubDir("opus/opusfile.h", "opus")
                OPUSFILE_LIB_DIR = GetParam("opusfile-lib-dir") or os.findlib("opusfile")
                VORBIS_INCLUDE_DIR = GetParam("vorbis-include-dir") or os.findheader("vorbis/vorbisfile.h")
                VORBIS_LIB_DIR = GetParam("vorbis-lib-dir") or os.findlib("vorbis")
                OGG_INCLUDE_DIR = GetParam("ogg-include-dir") or os.findheader("ogg/ogg.h")
                OGG_LIB_DIR = GetParam("ogg-lib-dir") or os.findlib("ogg")
            end
        end
    elseif AUDIO_LIB == "irrklang" then
        print("Warning: irrKlang is deprecated and may be removed in future, please consider switching to miniaudio")
        IRRKLANG_INCLUDE_DIR = GetParam("irrklang-include-dir") or "../irrklang/include"
        if os.istarget("windows") then
            IRRKLANG_LIB_DIR = "../irrklang/lib/Win32-visualStudio"
        elseif os.istarget("linux") then
            IRRKLANG_LIB_DIR = "../irrklang/bin/linux-gcc-64"
            IRRKLANG_LINK_RPATH = "-Wl,-rpath=./irrklang/bin/linux-gcc-64/"
        elseif os.istarget("macosx") then
            IRRKLANG_LIB_DIR = "../irrklang/bin/macosx-gcc"
        end
        IRRKLANG_LIB_DIR = GetParam("irrklang-lib-dir") or IRRKLANG_LIB_DIR
        if GetParam("irrklang-pro") and os.istarget("windows") then
            IRRKLANG_PRO = true
        elseif GetParam("no-irrklang-pro") then
            IRRKLANG_PRO = false
        end
        if IRRKLANG_PRO then
            -- irrklang pro can't use the pro lib to debug
            IRRKLANG_PRO_RELEASE_LIB_DIR = GetParam("irrklang-pro-release-lib-dir") or "../irrklang/lib/Win32-vs2019"
            IRRKLANG_PRO_DEBUG_LIB_DIR = GetParam("irrklang-pro-debug-lib-dir") or "../irrklang/lib/Win32-visualStudio-debug"
        end
        IRRKLANG_PRO_BUILD_IKPMP3 = GetParam("build-ikpmp3") or IRRKLANG_PRO
    else
        error("Unknown audio library: " .. AUDIO_LIB)
    end
end

if GetParam("winxp-support") and os.istarget("windows") then
    WINXP_SUPPORT = true
end

IS_ARM=false

function spawn(cmd)
    local handle = io.popen(cmd)
    if not handle then
        return nil
    end
    local result = handle:read("*a")
    handle:close()
    if result and #result > 0 then
        return result
    else
        return nil
    end
end
if GetParam("server-mode") then
    SERVER_MODE = true
end
if GetParam("server-zip-support") then
    SERVER_ZIP_SUPPORT = true
end
if GetParam("server-pro2-support") then
    SERVER_PRO2_SUPPORT = true
    SERVER_ZIP_SUPPORT = true
    SERVER_TAG_SURRENDER_CONFIRM = true
end
if GetParam("server-pro3-support") then
    SERVER_PRO3_SUPPORT = true
    SERVER_ZIP_SUPPORT = true
    SERVER_TAG_SURRENDER_CONFIRM = true
end
if GetParam("server-tag-surrender-confirm") then
    SERVER_TAG_SURRENDER_CONFIRM = true
end

if SERVER_MODE then
    BUILD_FREETYPE = false
    BUILD_IKPMP3 = false
    USE_IRRKLANG = false
    IRRKLANG_PRO = false
    if not SERVER_ZIP_SUPPORT then
        BUILD_IRRLICHT = false
    else
        BUILD_IRRLICHT = true
    end
end

function isRunningUnderRosetta()
    local rosetta_result=spawn("sysctl -n sysctl.proc_translated 2>/dev/null")
    return tonumber(rosetta_result) == 1
end

function IsRunningUnderARM()
    -- os.hostarch() is over premake5 beta3,
    if os.hostarch then
        local host_arch = os.hostarch()
        local possible_archs = { "ARM", "ARM64", "loongarch64", "armv5", "armv7", "aarch64" }
        for _, arch in ipairs(possible_archs) do
            if host_arch:lower():match(arch:lower()) then
                return true
            end
        end
    else
        -- use command 'arch' to detect the architecture on macOS or Linux
        local arch_result = spawn("arch 2>/dev/null")
        if arch_result then
            arch_result = arch_result:lower():gsub("%s+", "")
            if arch_result == "arm64" or arch_result == "aarch64" then
                return true
            elseif arch_result == "arm" or arch_result == "armv7" or arch_result == "armv5" then
                return true -- for ARMv5, ARMv7, etc.
            elseif arch_result == "loongarch64" then
                return true -- for loongarch64
            end
        end
    end
    return false
end

function isARM()
    if IsRunningUnderARM() then
        return true
    end
    if os.istarget("macosx") and isRunningUnderRosetta() then
        -- macOS under rosetta will report x86_64, but it is running on ARM
        print("Detected running under Rosetta on macOS, treating as ARM")
        return true
    end
    return false
end

IS_ARM=isARM() or GetParam("mac-arm") -- detect if the current system is ARM
MAC_ARM=os.istarget("macosx") and IS_ARM

workspace "YGOPro"
    location "build"
    language "C++"
    objdir "obj"    

    configurations { "Release", "Debug" }

    for _, numberOption in ipairs(numberOptions) do
        ApplyNumber(numberOption)
    end

    for _, boolOption in ipairs(boolOptions) do
        ApplyBoolean(boolOption)
    end

    filter "system:windows"
if not SERVER_PRO3_SUPPORT then
        entrypoint "mainCRTStartup"
end
        systemversion "latest"
        startproject "YGOPro"
        if WINXP_SUPPORT then
            defines { "WINVER=0x0501" }
            toolset "v141_xp"
        else
            defines { "WINVER=0x0601" } -- WIN7
        end
        if SERVER_PRO3_SUPPORT then
            architecture "x86_64"
        end

    filter "system:macosx"
        libdirs { "/usr/local/lib" }
        if MAC_ARM then
            buildoptions { "--target=arm64-apple-macos12" }
        end
if not SERVER_MODE then
        links { "OpenGL.framework", "Cocoa.framework", "IOKit.framework" }
end

    filter "system:linux"
        buildoptions { "-U_FORTIFY_SOURCE" }

    filter "configurations:Release"
        optimize "Speed"
        targetdir "bin/release"

    filter "configurations:Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    filter { "configurations:Release", "action:vs*" }
        if linktimeoptimization then
            linktimeoptimization "On"
        else
            flags { "LinkTimeOptimization" }
        end
        staticruntime "On"
        disablewarnings { "4244", "4267", "4838", "4996", "6011", "6031", "6054", "6262" }

    filter { "configurations:Release", "not action:vs*" }
        symbols "On"
        defines "NDEBUG"
        --if not IS_ARM then
        --    buildoptions "-march=native"
        --end
        if IS_ARM and not MAC_ARM then
            buildoptions {
                "-march=armv8-a",
                "-mtune=cortex-a72",
                "-Wno-psabi"
            }
            pic "On"
        end

    filter { "configurations:Debug", "action:vs*" }
        disablewarnings { "6011", "6031", "6054", "6262" }

    filter "action:vs*"
        cdialect "C11"
        if not WINXP_SUPPORT then
           conformancemode "On" 
        end
        vectorextensions "SSE2"
        buildoptions { "/utf-8" }
        defines { "_CRT_SECURE_NO_WARNINGS" }

    filter "not action:vs*"
        buildoptions { "-fno-strict-aliasing", "-Wno-multichar", "-Wno-format-security" }

if SERVER_PRO3_SUPPORT then
    filter "not action:vs*"
        pic "On"
end

    filter {}

    include "ocgcore"
    include "gframe"
    if BUILD_LUA then
        include "lua"
    end
    if BUILD_EVENT then
        include "event"
    end
    if BUILD_FREETYPE and not SERVER_MODE then
        include "freetype"
    end
    if BUILD_IRRLICHT and not SERVER_MODE then
        include "irrlicht"
    end
    if BUILD_IRRLICHT and SERVER_MODE and SERVER_ZIP_SUPPORT then
        include "irrlicht/premake5-only-zipreader.lua"
    end
    if BUILD_SQLITE then
        include "sqlite3"
    end
    if USE_AUDIO then
        if AUDIO_LIB=="miniaudio" then
            include "miniaudio"
        end
        if IRRKLANG_PRO_BUILD_IKPMP3 then
            include "ikpmp3"
        end
    end