import Foundation
import Scenes
import Igis

class BackgroundFS : RenderableEntity {
    let backgroundImage : Image
    
    init() {    
        guard let backgroundURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/NarutoGameFightSceneBackground.jpg?raw=true") else {
            fatalError("Failed to create URL for backgroundURL")
        }
        backgroundImage = Image(sourceURL:backgroundURL)
        super.init(name:"Background")
    }
    
    func clearCanvas(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        canvas.setup(backgroundImage)
    }
    
    override func render(canvas:Canvas) {
        clearCanvas(canvas:canvas)

        if let canvasSize = canvas.canvasSize {
            if backgroundImage.isReady {
                backgroundImage.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:canvasSize))
                canvas.render(backgroundImage)
            }
        }
        
    }
}
