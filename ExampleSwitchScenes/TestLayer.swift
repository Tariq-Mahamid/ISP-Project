import Igis
import Scenes

class TestLayer : Layer {
    let rectangle = TestRectangle()
    
    init() {
        super.init(name: "Test")
        
        insert(entity: rectangle, at: .front)
    }
    
}
