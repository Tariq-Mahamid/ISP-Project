import Igis
import Scenes

class GroundFS : RenderableEntity {

    var ground = Rectangle(rect: Rect())
    
    init () {
        super.init(name: "Ground")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        ground = Rectangle(rect: Rect(topLeft: Point(x: 0, y: canvasSize.height * 2 / 3), size: Size(width: canvasSize.width, height: canvasSize.height / 3)), fillMode: .fillAndStroke) 
    }

    override func render(canvas: Canvas) {
        canvas.render(LineWidth(width: 7), FillStyle(color: Color(.green)), ground)
    }
}
