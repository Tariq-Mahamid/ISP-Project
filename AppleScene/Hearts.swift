import Igis
import Scenes

class Hearts : RenderableEntity {

    var playerLives = 3
    var heartSize = Size(width: 50, height:50)
    
    init () {
        super.init(name: "Hearts")
    }

    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            for x in 0 ..< playerLives {
                let currentHeartRect = Rect(topLeft: Point(x: canvasSize.width - ((5 - x) * heartSize.width) , y: heartSize.height / 2), size: heartSize)
                let currentHeartRectangle = Rectangle(rect: currentHeartRect, fillMode: .fillAndStroke)
            
                canvas.render(FillStyle(color: Color(.orange)), currentHeartRectangle)
            }
        }
    }
}
