project "event"
    kind "StaticLib"

    includedirs { "include", "compat" }

    files {
        "buffer.c",
        "bufferevent.c",
        "bufferevent_filter.c",
        "bufferevent_pair.c",
        "bufferevent_ratelim.c",
        "bufferevent_sock.c",
        "epoll.c",
        "event.c",
        "evmap.c",
        "evthread.c",
        "evthread_pthread.c",
        "evutil.c",
        "evutil_rand.c",
        "evutil_time.c",
        "listener.c",
        "log.c",
        "poll.c",
        "select.c",
        "signal.c"
    }
