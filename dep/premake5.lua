workspace "Multirole"
    location "build"
    language "C++"
    objdir "obj"

    configurations { "Release", "Debug" }

    filter "configurations:Release"
        optimize "Speed"
        defines "NDEBUG"
        targetdir "bin/release"

    filter "configurations:Debug"
        symbols "On"
        defines "_DEBUG"
        targetdir "bin/debug"

    include "src/premake5.lua"
    include "src/premake5-hornet.lua"
