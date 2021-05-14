import Igis
import Scenes

class PlayerStats {
    private var health = 0
    private var damage = 0
    private var chakra = 0

    public func getHealth() -> Int {
        return health
    }

    public func getDamage() -> Int {
        return damage
    }

    public func getChakra() -> Int {
        return chakra
    }

    public func changeHealth(factor: Int) {
        health += factor
    }

    public func changeDamage(factor: Int) {
        damage += factor
    }

    public func changeChakra(factor: Int) {
        chakra += factor
    }

    public func setValues() {
        health = 50
        damage = 50
        chakra = 50
    }

    public func overpoweredValues() {
        health = 100
        damage = 100
        chakra = 100
    }
}
