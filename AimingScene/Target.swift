import Scenes
import Igis
import Foundation

class Target: RenderableEntity {
    let targetEllipse = Ellipse(center:Point(x: 1000, y:1000), radiusX: 40, radiusY: 40, fillMode:.fillAndStroke)

    let strokeStyle = StrokeStyle(color:Color(.red))
    let fillStyle = FillStyle(color:Color(.white))
    let lineWidth = LineWidth(width:10)
    var gameEnded = false

    var targetImage : Image

    init() {
        guard let URL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/main/Images/Target.png?raw=true") else {
            fatalError("Failed to create URL for deafaultNaruto")
        }
        targetImage = Image(sourceURL:URL)
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        // Position the ellipse at the center of the canvas
        canvas.setup(targetImage)
    }

    override func render(canvas:Canvas) {
        if !gameEnded {

            let destinationRect = Rect(topLeft: Point(x: targetEllipse.center.x - targetEllipse.radiusX, y: targetEllipse.center.y - targetEllipse.radiusY),
                                       size: Size(width: targetEllipse.radiusX * 2, height: targetEllipse.radiusY * 2))

            if targetImage.isReady {
                targetImage.renderMode = .destinationRect(destinationRect)
                canvas.render(targetImage)
            }
        }
    }

    override func boundingRect() -> Rect {  
        return Rect(topLeft: Point(x: targetEllipse.center.x - targetEllipse.radiusX, y: targetEllipse.center.y - targetEllipse.radiusY),
        size: Size(width: targetEllipse.radiusX * 2, height: targetEllipse.radiusY * 2))
    }
}
