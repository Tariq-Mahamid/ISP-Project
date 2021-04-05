import Foundation
import Scenes
import Igis

class Background : RenderableEntity {
    init() {    
          super.init(name:"Background")
    }

    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    override func render(canvas:Canvas) {
        clearCanvas(canvas:canvas)
    }
}
