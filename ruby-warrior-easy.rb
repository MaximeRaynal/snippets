#Solution au mode facile de Ruby Warrior
#Dirty Code
class Player

    def initialize
        @fullHealth = 20
        @currentHealth = @fullHealth
        @healthRatioBeforeLeak = 0.5
        @touchTheWall = true #Sert dans un seul niveau
    end

    def play_turn(warrior)
        if @currentHealth > warrior.health
            fightingMode(warrior)
        elsif canShoot?(warrior)
            warrior.shoot!
        elsif warrior.feel.enemy?
            warrior.attack!
        elsif warrior.feel.captive?
                warrior.rescue!
        else
            if warrior.health < @fullHealth
                warrior.rest!
                @currentHealth = warrior.health
            else
                if !@touchTheWall
                    if  warrior.feel(:backward).captive?
                        warrior.rescue!:backward
                    else
                        warrior.walk!:backward
                    end
                    @touchTheWall = warrior.feel(:backward).wall?
                elsif warrior.feel.wall?
                    warrior.pivot!
                else
                    warrior.walk!
                end
            end
        end

        @currentHealth = warrior.health
    end

    #Fight or leak
    def fightingMode(warrior)
        if warrior.feel.enemy?
                warrior.attack!
        else
            if warrior.health < @fullHealth*@healthRatioBeforeLeak
                warrior.walk!:backward
            else
                warrior.walk!
            end
        end
    end

    def canShoot?(warrior)
        if warrior.look[0].captive? || warrior.look[1].captive? then
            return false
        else
            return  warrior.look[1].enemy? || warrior.look[2].enemy?
        end
    end

end
