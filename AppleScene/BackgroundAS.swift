import Foundation
import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class BackgroundAS : RenderableEntity {

    let backgroundImage : Image
    
    var canvasWidth = 2000
    var canvasHeight = 1000

      init() {
          // Using a meaningful name can be helpful for debugging
          guard let imageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/NarutoGameAppleSceneBackground.jpeg?raw=true") else {
              fatalError("Failed to create URL for whitehouse")
          }
          
          backgroundImage = Image(sourceURL:imageURL)

          super.init(name:"Background")
      }

      func clearCanvas(canvas:Canvas) {
          if let canvasSize = canvas.canvasSize {
              let canvasRect = Rect(topLeft:Point(), size:canvasSize)
              let canvasClearRectangle = Rectangle(rect:canvasRect, fillMode:.clear)
              canvas.render(canvasClearRectangle)
          }
      }

      override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(backgroundImage)
        canvasWidth = canvasSize.width
        canvasHeight = canvasSize.height
    }


      override func render(canvas:Canvas) {
          clearCanvas(canvas:canvas)

          if backgroundImage.isReady {
              backgroundImage.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasWidth, height:canvasHeight)))
              canvas.render(backgroundImage)
          }

      }
}
