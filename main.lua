do
    local sdl = require("SDL2")
    local gl = require("opengl")

    sdl.Init(sdl.e.INIT_VIDEO)

    local wnd_ptr = sdl.CreateWindow("ljstation", sdl.e.WINDOWPOS_CENTERED, sdl.e.WINDOWPOS_CENTERED, 640, 480, sdl.e.WINDOW_OPENGL)
    sdl.GL_SetAttribute(sdl.e.GL_CONTEXT_PROFILE_MASK, sdl.e.GL_CONTEXT_PROFILE_CORE)
    sdl.GL_SetAttribute(sdl.e.GL_CONTEXT_MAJOR_VERSION, 3)
    sdl.GL_SetAttribute(sdl.e.GL_CONTEXT_MINOR_VERSION, 3)

    local gl_context = sdl.GL_CreateContext(wnd_ptr)
    if gl_context == nil then
        error(ffi.string(sdl.GetError()))
    end

    gl.GetProcAddress = sdl.GL_GetProcAddress
    gl.Initialize()

    sdl.GL_MakeCurrent(wnd_ptr, gl_context)

    while true do
        -- do opengl stuff here
        gl.ClearColor(math.random(), math.random(), math.random(), 1)
        gl.Clear(bit.bor(gl.e.GL_COLOR_BUFFER_BIT, gl.e.GL_DEPTH_BUFFER_BIT, gl.e.GL_STENCIL_BUFFER_BIT))
        --

        sdl.PumpEvents()
        sdl.GL_SwapWindow(wnd_ptr)
    end
end

local lr33300 = require("lr33300")

DEBUG = true

local cpu = lr33300.new("SCPH1001.BIN")
cpu[0xBFC00000]()
local status, err = pcall(cpu[0xBFC00000])
print(cpu.instructions_executed, "instructions executed")
