require("Cocos2d")
require("Cocos2dConstants")
require("SoundDeal")

--创建一个类，继承scene，class返回一张表
local FlashScene = class("FlashScene",function()
    return cc.Scene:create()
    end
)
--类似c++中的构造函数
function FlashScene:ctor()
    self.size=cc.Director:getInstance():getWinSize()
end
--create留下给外部调用的接口
function FlashScene:create()
    local flashScene = FlashScene:new()
    local layer = flashScene:createLayer()
    flashScene:addChild(layer)
    --加载音效
    SoundDeal:preloadEffect()
    --播放背景声音
    SoundDeal:playBg()
    
    return flashScene
end
--创建一个层，在层上加入元素
function FlashScene:createLayer()
    local layer = cc.Layer:create()
    --动作的回调函数
    local action_callback = function()
        cc.Director:getInstance():replaceScene(require("MainGameScene"):create())
    end
     --使用Cocos提供的模块cc，调用Sprite的方法创建一个logo出来，你在Cocos2d-x看到的内容，都可以从这个模块中获得（前提是有导出）
    local logo = cc.Sprite:create("logo2.png")
    logo:setPosition(self.size.width/2,self.size.height/2)
    layer:addChild(logo,5)
    
    logo:setOpacity(0)
    local action = cc.Sequence:create(cc.FadeIn:create(2),cc.CallFunc:create(action_callback))
    logo:runAction(action)
    
    local title = cc.Sprite:create("picture.png")
    title:setPosition(self.size.width+title:getContentSize().width/2,self.size.height*0.88)
    layer:addChild(title)
    
    local title_action = cc.Sequence:create(cc.MoveTo:create(0.5,{x=self.size.width/2-100,y=title:getPositionY()}),
         cc.Spawn:create(cc.MoveBy:create(0.1,{x=200,y=0}),cc.SkewTo:create(0.1,0,-45)),
         cc.Spawn:create(cc.MoveBy:create(0.2,{x=-150,y=0}),cc.SkewTo:create(0.2,0,45)),
         cc.Spawn:create(cc.MoveBy:create(0.2,{x=50,y=0}),cc.SkewTo:create(0.2,0,0))
         )
    title:runAction(title_action) 
    
    --particle
    local particleSystemQuad = cc.ParticleSystemQuad:create("particle/vanishingPoint.plist")
    particleSystemQuad:setAnchorPoint(cc.p(0.5,0.5))
    particleSystemQuad:setPosition(cc.p(self.size.width/2,self.size.height/2))
    layer:addChild(particleSystemQuad)
    
    return layer
end
     
    


return FlashScene