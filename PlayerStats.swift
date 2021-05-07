import Igis
import Scenes

class PlayerStats : Scene {
    public var health = 0
    public var damage = 0
    public var chakra = 0

    init() {
        super.init(name: "PlayerStats")
    }
}
