project "multirole"
    kind "ConsoleApp"

    files {
        "DLOpen.cpp",
        "Multirole/GitRepo.cpp",
        "Multirole/I18N.cpp",
        "Multirole/Instance.cpp",
        "Multirole/Lobby.cpp",
        "Multirole/main.cpp",
        "Multirole/STOCMsgFactory.cpp",
        "Multirole/Core/DLWrapper.cpp",
        "Multirole/Core/HornetWrapper.cpp",
        "Multirole/Endpoint/LobbyListing.cpp",
        "Multirole/Endpoint/RoomHosting.cpp",
        "Multirole/Endpoint/Webhook.cpp",
        "Multirole/Room/Client.cpp",
        "Multirole/Room/Context.cpp",
        "Multirole/Room/Instance.cpp",
        "Multirole/Room/ScriptLogger.cpp",
        "Multirole/Room/TimerAggregator.cpp",
        "Multirole/Room/State/ChoosingTurn.cpp",
        "Multirole/Room/State/Closing.cpp",
        "Multirole/Room/State/Dueling.cpp",
        "Multirole/Room/State/Rematching.cpp",
        "Multirole/Room/State/RockPaperScissor.cpp",
        "Multirole/Room/State/Sidedecking.cpp",
        "Multirole/Room/State/Waiting.cpp",
        "Multirole/Service/BanlistProvider.cpp",
        "Multirole/Service/CoreProvider.cpp",
        "Multirole/Service/DataProvider.cpp",
        "Multirole/Service/LogHandler.cpp",
        "Multirole/Service/ReplayManager.cpp",
        "Multirole/Service/ScriptProvider.cpp",
        "Multirole/Service/LogHandler/DiscordWebhookSink.cpp",
        "Multirole/Service/LogHandler/FileSink.cpp",
        "Multirole/Service/LogHandler/StderrSink.cpp",
        "Multirole/Service/LogHandler/StdoutSink.cpp",
        "Multirole/Service/LogHandler/StreamFormat.cpp",
        "Multirole/Service/LogHandler/Timestamp.cpp",
        "Multirole/YGOPro/Banlist.cpp",
        "Multirole/YGOPro/CardDatabase.cpp",
        "Multirole/YGOPro/CoreUtils.cpp",
        "Multirole/YGOPro/Deck.cpp",
        "Multirole/YGOPro/Replay.cpp",
        "Multirole/YGOPro/StringUtils.cpp",
        "Multirole/YGOPro/LZMA/Alloc.c",
        "Multirole/YGOPro/LZMA/LzFind.c",
        "Multirole/YGOPro/LZMA/LzmaEnc.c"
	}

    defines {
        "_7ZIP_ST", "_SILENCE_ALL_CXX17_DEPRECATION_WARNINGS",
        "_WINSOCK_DEPRECATED_NO_WARNINGS", "NOMINMAX",
        "BOOST_DATE_TIME_NO_LIB", "BOOST_JSON_STANDALONE", "NOMINMAX"
    }

    includedirs { "../include" }
    libdirs { "../lib" }
    links { "boost_filesystem", "ssl", "crypto", "git2", "fmt", "sqlite3" }
