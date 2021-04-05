import Igis
import Scenes

class PlayerMoveRectangle : RenderableEntity {
    public let rectangle : Rectangle
    public let playerMove : PlayerMove

    init(rectangle : Rectangle, playerMove : PlayerMove) {
        self.rectangle = rectangle
        self.playerMove = playerMove
        
        super.init(name: "PlayerMoveRectangle")

    }
    
    override func boundingRect() -> Rect
    {
        let boundingRect = rectangle.rect
          
        let left = boundingRect.center.x - (boundingRect.width / 2)
        let top = boundingRect.center.y - (boundingRect.height / 2)
        let width =  boundingRect.width
        let height = boundingRect.height

        return Rect(topLeft: Point(x: left, y: top), size: Size(width: width, height: height))
    }
}
