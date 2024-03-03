-- TaskScheduler premake5.lua

-- Define common configurations
local configurations = { "Debug", "Release" }
local platforms = {"x64" }

-- Define common flags and options
local common_flags = { "NoManifest", "ExtraWarnings", "StaticRuntime", "NoMinimalRebuild", "FloatFast" }
local optimization_flags = { "OptimizeSpeed" }
local common_defines = { "MT_UNICODE" }

-- Define function to set common configuration properties
local function set_common_configuration_properties()
    flags(common_flags)
    defines(common_defines)
    objdir("Build/" .. _ACTION .. "/tmp/%{cfg.buildcfg}-%{cfg.platform}")
end

-- Define function to set platform-specific properties
local function set_platform_specific_properties()
    if os.is("windows") then
        -- Windows-specific properties
        buildoptions("/wd4127") -- Compiler Warning (level 4) C4127. Conditional expression is constant
    else
        -- Unix-specific properties
        buildoptions("-std=c++11")
        linkoptions("-rdynamic")
        if os.is("macosx") then
            buildoptions { "-Wno-invalid-offsetof", "-Wno-deprecated-declarations", "-fno-omit-frame-pointer" }
            -- Add any additional macOS-specific options here
        else
            -- Add any additional Unix-specific options here
        end
    end
end

-- Define the main project
project "TaskScheduler"
    kind "StaticLib"
    language "C++"
    set_common_configuration_properties()

    -- Set platform-specific properties
    filter { "platforms:x64" }
        architecture "x86_64"
        set_platform_specific_properties()
    filter {}

    -- Define project files
    files {
        "Scheduler/**.*",
        "ThirdParty/Boost.Context/*.h",
    }

    -- Define include directories
    includedirs {
        "ThirdParty/Squish",
        "Scheduler/Include",
        "ThirdParty/UnitTest++/UnitTest++",
        "ThirdParty/Boost.Context",
    }

    filter "configurations:Debug"
        defines { "DEBUG" }
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        defines { "RELEASE" }
        runtime "Release"
        optimize "On"

    -- Exclude platform-specific files
    filter { "files:Src/Platform/Windows/**.*" }
        removefiles { "Src/Platform/Windows/**.*" }
    filter { "files:Src/Platform/Posix/**.*" }
        removefiles { "Src/Platform/Posix/**.*" }
    filter {}

 


