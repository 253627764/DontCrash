
require "Cocos2d"

-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    cc.FileUtils:getInstance():addSearchPath("src")
    cc.FileUtils:getInstance():addSearchPath("res")
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(480, 320, 0)
    --我采用如下的适配方法
    local pEGLView = cc.Director:getInstance():getOpenGLView()
    local frameSize = pEGLView:getFrameSize()
    --这里的尺寸写背景图片的大小
    local winSize = {width=1280,height=720}

    local widthRate = frameSize.width/winSize.width
    local heightRate = frameSize.height/winSize.height
    
    --pEGLView:setDesignResolutionSize(1280,720,0)
    if widthRate > heightRate then
        pEGLView:setDesignResolutionSize(winSize.width,
            winSize.height*heightRate/widthRate, 1)
    else
        pEGLView:setDesignResolutionSize(winSize.width*widthRate/heightRate, winSize.height,
            1)
    end 
    --create scene 
    local scene = require("FlashScene")
    local gameScene = scene.create()
    --gameScene:playBgMusic()
    
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(gameScene)
    else
        cc.Director:getInstance():runWithScene(gameScene)
    end

end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
