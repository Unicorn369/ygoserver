project "hornet"
    kind "ConsoleApp"

    files {
        "DLOpen.cpp",
        "Hornet/main.cpp"
	}

    defines {
        "BOOST_DATE_TIME_NO_LIB", "NOMINMAX"
    }

    includedirs { "../include" }
    libdirs { "../lib" }
