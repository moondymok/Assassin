require("types/Types")
require("ParamConfig")
require("managers/AnimationManager")
Entity = class("Entity",function(filepath)
    return cc.Sprite:create(filepath)
end)

Entity.__index = Entity


function Entity:ctor()
    self.direction = ENTITY_DIRECTION.RIGHT_DOWN
    self.isAlive = true
    self.isAttacking = false
    self.hp=0
    self.moveInfo = nil
    self.entityState = nil
    self:setScale(1.5)
    local function update()
        if self.isAttacking == false then return end
    end
    
    --self:scheduleUpdateWithPriorityLua(update, 0)  

end

function Entity:stateEnterRun()
end

function Entity:stateEnterStand()
end

function Entity:stateEnterDie()
end

function Entity:stateEnterFight()
    
end

function Entity:changeState(state)
end

function Entity:attack(target)
    if self.isAttacking then 
        return 
    end
    print("is attacking")
    target.hp = target.hp - self.damage
    target:runAction(cc.Blink:create(0.3,2))
    if target.hp <=0 then
        target.hp = 0
        target.isAlive = false
        target:stateEnterDie()
    end
--    local function attackInterval(delta)
--        print("hero attack interval")
--        target.hp = target.hp - self.damage
--        if target.hp <= 0 then 
--            target.hp = 0 
--            target.isAlive = false
--            self:getParent():removeEntity(target)
--            self.isAttacking = false
--            cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.scheduler)
--            
--        end
--        
--    end
--    self.scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(attackInterval,2,false)

end

function Entity:isAttacked()
end

function Entity:setDirection(direct)
    self.direction = direct
end

function Entity:getDirection()
    return self.direction
end

function Entity:stopAnimations()
    Entity:stopAllActions()
end


function Entity:runAnimationOnce(animation_type)
    local animation = AnimationManager:getInstance():getOnceAnimation(animation_type , self.direction)
    --print(animation , animation_type , self.direction)
    local animate = cc.Animate:create(animation)
    animate:setTag(ACTION_TAG.CHANGING)
    self:runAction(animate)
end

function Entity:getAnimation(animation_type, direction,loops)
    return AnimationManager:getInstance():getAnimation(animation_type,direction ,loops)
end

--function Entity:runAnimation(animation_type)
--    local animation = AnimationManager:getInstance():getForeverAnimation(animation_type , self.direction)
--    --print(animation , animation_type , self.direction)
--    local animate = cc.Animate:create(animation)
--    animate:setTag(ACTION_TAG.CHANGING)
--    self:runAction(animate)
--end

function Entity:setHP(value)
    self.hp = value
end

function Entity:getHP()
	return self.hp
end
