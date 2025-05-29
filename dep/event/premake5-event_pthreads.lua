project "event_pthreads"
    kind "StaticLib"

    includedirs { "include", "compat" }

    files { "evthread_pthread.c" }
