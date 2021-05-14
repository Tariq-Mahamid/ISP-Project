import Scenes
import Igis
import Foundation
import CoreFoundation

  /*
     This class is responsible for rendering the background.
   */


class BackgroundAim : RenderableEntity {
    var score = 0
    var countdownTimer: Timer!
    var totalTime = 25
    var renderTimer = 0 //Incremented 30 times a second, used to measure when to decrement totalTime
    var canvasWidth = 2000
    var canvasHeight = 1000

    let backgroundImage : Image

    init() {
        // Using a meaningful name can be helpful for debugging
        guard let whitehouseURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/NarutoGameAimingSceneBackground.jpeg?raw=true") else {
            fatalError("Failed to create URL for whitehouse")
        }
        backgroundImage = Image(sourceURL:whitehouseURL)
        
        super.init(name:"Background")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        canvas.setup(backgroundImage)
        canvasWidth = canvasSize.width
        canvasHeight = canvasSize.height
    }
    
    func updateTime() {
        totalTime -= 1
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

        renderTimer += 1

        if renderTimer % 30 == 0 && totalTime > 0{
            updateTime()
        }
        
        let scoreText = Text(location:Point(x:100, y:135), text:"Score: \(score).", fillMode: .fill)
        let timerText = Text(location:Point(x:100, y:168), text:"Time left: \(totalTime)", fillMode: .fill)

        scoreText.font = "30pt Luminari"
        timerText.font = "30pt Luminari"

        if backgroundImage.isReady {
            backgroundImage.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasWidth, height:canvasHeight)))
            canvas.render(backgroundImage)
        }

        if totalTime != 0 {
            canvas.render(FillStyle(color:Color(.white)), scoreText, timerText)
        }
    }
}
