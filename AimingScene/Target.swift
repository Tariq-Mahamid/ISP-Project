import Scenes
import Igis

class Target: RenderableEntity {
    let targetEllipse = Ellipse(center:Point(x: 1000, y:1000), radiusX: 40, radiusY: 40, fillMode:.fillAndStroke)
//    let bullseyeEllipse = Ellipse(center:Point(x: 1000, y:1000), radiusX: 3, radiusY: 3, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.red))
    let fillStyle = FillStyle(color:Color(.white))
    let lineWidth = LineWidth(width:10)
    var gameEnded = false

    override func setup(canvasSize: Size, canvas: Canvas) {
        // Position the ellipse at the center of the canvas
//        targetEllipse.center = canvasSize.center
    }

    override func render(canvas:Canvas) {
        if !gameEnded {
            //        canvas.render(strokeStyle, FillStyle(color:Color(.red)))
            canvas.render(strokeStyle, fillStyle, lineWidth, targetEllipse)
            //        bullseyeEllipse.center = targetEllipse.center
        }
    }

    override func boundingRect() -> Rect {  
        return Rect(topLeft: Point(x: targetEllipse.center.x - targetEllipse.radiusX, y: targetEllipse.center.y - targetEllipse.radiusY),
        size: Size(width: targetEllipse.radiusX * 2, height: targetEllipse.radiusY * 2))
    }
}
