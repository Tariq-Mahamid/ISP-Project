import Scenes
import Igis
import Foundation

  /*
     This class is responsible for rendering the background.
*/
class Background : RenderableEntity {
    var Crossroads : Image
    
    init() {
        // Using a meaningful name can be helpful for debugging

        
        guard let CrossroadsURL = URL(string:"https://cdn.discordapp.com/attachments/747828138007986196/826503470210744381/Background2.png") else {
            fatalError("Failed to create URL for 50Cent")
        }
        Crossroads = Image(sourceURL:CrossroadsURL)
        
        super.init(name:"Background")
    }
    func clearCanvas(canvas:Canvas){
        if let canvasSize = canvas.canvasSize{
            let canvasRect = Rect(topLeft:Point(), size:canvasSize)
            let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
            canvas.render(canvasClearRectangle)
        }
    }
    override func setup(canvasSize:Size, canvas:Canvas){
        canvas.setup(Crossroads)
//        self.canvasSize = canvasSize
    }
    override func render(canvas:Canvas) {
        clearCanvas(canvas:canvas)
        let canvasSize = (canvas.canvasSize)!
        let specificCanvasWidth = 480*(canvasSize.height)/272
        let canvasHeight = canvasSize.height
        let canvasWidth = canvasSize.width
        let x = (canvasWidth/2)-(specificCanvasWidth/2)
        if Crossroads.isReady {
            let sourceRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:478, height:272))
            let destinationRect = Rect(topLeft:Point(x:x, y:0), size:Size(width:(specificCanvasWidth), height:(canvasHeight)))
            Crossroads.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
            
            canvas.render(Crossroads)
        }
    }
}

