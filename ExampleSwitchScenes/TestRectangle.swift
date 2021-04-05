import Igis
import Scenes

class TestRectangle : RenderableEntity {
    let rectangle = Rectangle(rect: Rect(topLeft: Point(x: 500, y: 500), size: Size(width: 500, height: 500)), fillMode: .fill)

    init() {
        super.init(name: "TestRectangle")
    }

    override func render(canvas: Canvas) {
        canvas.render(FillStyle(color: Color(.red)), rectangle)
    }
}
