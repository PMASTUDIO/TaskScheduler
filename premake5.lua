project "UnitTest++"
	kind "StaticLib"
	defines {
		"_CRT_SECURE_NO_WARNINGS"
	}

	files {
		"ThirdParty/UnitTest++/UnitTest++/**.cpp",
		"ThirdParty/UnitTest++/UnitTest++/**.h", 
	}

	if isPosix or isOSX then
		excludes { "ThirdParty/UnitTest++/UnitTest++/Win32/**.*" }
	else
		excludes { "ThirdParty/UnitTest++/UnitTest++/Posix/**.*" }
	end


project "Squish"
	kind "StaticLib"
	defines { 
		"_CRT_SECURE_NO_WARNINGS"
	}

	files {
		"ThirdParty/Squish/**.*", 
	}

	includedirs {
		"ThirdParty/Squish"
	}

project "TaskScheduler"
    kind "StaticLib"
 	flags {"NoPCH"}
 	files {
 		"Scheduler/**.*",
		 "ThirdParty/Boost.Context/*.h",
 	}

	includedirs {
		"ThirdParty/Squish", "Scheduler/Include", "ThirdParty/UnitTest++/UnitTest++", "ThirdParty/Boost.Context"
	}
	
	if isPosix or isOSX then
	excludes { "Src/Platform/Windows/**.*" }
	else
	excludes { "Src/Platform/Posix/**.*" }
	end

project "TaskSchedulerTests"
 	flags {"NoPCH"}
 	kind "ConsoleApp"
 	files {
 		"SchedulerTests/**.*", 
 	}

	includedirs {
		"ThirdParty/Squish", "Scheduler/Include", "ThirdParty/UnitTest++/UnitTest++"
	}
	
	if isPosix or isOSX then
	excludes { "Src/Platform/Windows/**.*" }
	else
	excludes { "Src/Platform/Posix/**.*" }
	end

	links {
		"UnitTest++", "Squish", "TaskScheduler"
	}

	if isPosix or isOSX then
		links { "pthread" }
	end


