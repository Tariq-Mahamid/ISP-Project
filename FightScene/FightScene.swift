import Scenes

class FightScene : Scene {

    let foregroundLayer = ForegroundLayerFS()
    
    init() {
        super.init(name:"Main")

        insert(layer:foregroundLayer, at:.front)
    }
}
