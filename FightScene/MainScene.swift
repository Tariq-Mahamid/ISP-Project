import Scenes

class MainScene : Scene {

    let foregroundLayer = ForegroundLayer()
    
    init() {
        super.init(name:"Main")

        insert(layer:foregroundLayer, at:.front)
    }
}
