import Scenes

class TestScene : Scene {

    let testLayer = TestLayer()
    
    init() {
        super.init(name:"Test")

        insert(layer:testLayer, at:.front)
    }
}
