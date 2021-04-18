import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class Background : RenderableEntity {
    
      init() {
          // Using a meaningful name can be helpful for debugging
          
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
