project "event"
    kind "StaticLib"

    includedirs { "include", "compat" }

    files { "buffer.c",
            "bufferevent.c",
            "bufferevent_filter.c",
            "bufferevent_pair.c",
            "bufferevent_ratelim.c",
            "bufferevent_sock.c",
            "event.c",
            "evmap.c",
            "evthread.c",
            "evutil.c",
            "evutil_rand.c",
            "evutil_time.c",
            "listener.c",
            "log.c",
            "signal.c" }

    filter "system:android"
        includedirs { "android" }
        files { "evthread_pthread.c", "epoll.c", "poll.c", "select.c", "strlcpy.c" }

    filter "system:bsd"
        includedirs { "bsd" }
        files { "evthread_pthread.c", "poll.c", "kqueue.c", "select.c" }

    filter "system:linux"
        includedirs { "linux" }
        files { "evthread_pthread.c", "epoll.c", "poll.c", "select.c", "strlcpy.c" }

    filter "system:macosx"
        includedirs { "macosx" }
        files { "evthread_pthread.c", "poll.c", "kqueue.c", "select.c" }

    filter "system:windows"
        includedirs { "Win32" }
        files { "buffer_iocp.c", "bufferevent_async.c", "event_iocp.c", "evthread_win32.c", "strlcpy.c", "win32select.c" }
