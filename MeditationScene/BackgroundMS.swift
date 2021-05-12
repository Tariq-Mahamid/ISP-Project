import Scenes
import Igis
import Foundation

  /*
     This class is responsible for rendering the background.
   */


class BackgroundMS : RenderableEntity {
    let player = Player()
    var score = 0
    var lives = 5

    let backgroundImage : Image

    var canvasWidth = 2000
    var canvasHeight = 1000


    var scored = false
    var timed = false
    
      init() {
          // Using a meaningful name can be helpful for debugging
          guard let imageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/NarutoGameMeditationSceneBackground.jpeg?raw=true") else {
            fatalError("Failed to create URL for whitehouse")
        }
        backgroundImage = Image(sourceURL:imageURL)

          super.init(name:"BackgroundMS")
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


      func increaseScore() {
          score += 1
      }

      func decreaseLives() {
          if lives >= 1 {
              lives -= 1
          }
      }
      
      override func render(canvas:Canvas) {
          clearCanvas(canvas:canvas)

          func renderTimingBlockInfoText() {
              // TB means "Timing Block" so greenTBText means green Timing Block Text
              let greenTBText = Text(location:Point(x:100, y:25), text:"To score on green blocks, press 'q'.")
              greenTBText.font = "20pt Luminari"
              let yellowTBText = Text(location:Point(x:100, y:60), text:"To score on yellow blocks, press 'w'.")
              let blueTBText = Text(location:Point(x:100, y:95), text:"To score on blue blocks, press 'e'.")
              let redTBText = Text(location:Point(x:100, y:130), text:"To score on red blocks, press 'r'.")
              
              let scoreText = Text(location:Point(x:100, y:190), text:"Score: \(score).")
              scoreText.font = "30pt Luminari"
              let livesText = Text(location:Point(x:100, y:228), text:"Lives: \(lives).")
              livesText.font = "30pt Luminari"

              if backgroundImage.isReady {
                  backgroundImage.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasWidth, height:canvasHeight)))
                  canvas.render(backgroundImage)
              }

              if lives != 0 {
                  canvas.render(FillStyle(color:Color(.white)), greenTBText, yellowTBText, blueTBText, redTBText, scoreText, livesText)
              }
          }
          renderTimingBlockInfoText()
      }
}
