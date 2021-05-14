import Igis
import Scenes
import Foundation

class Hearts : RenderableEntity {
    let scoreboard = Scoreboard()
    var playerLives = 3
    var heartSize = Size(width: 50, height:50)

    let livesText: Text
    let livesValueText : Text

    let endText : Text

    var endValue = 0
    let scoreColor = FillStyle(color:Color(.red))

    var gameEnded = false

    var HeartImage: Image 
 
    init () {
       endText = Text(location: Point.zero, text: "GAME OVER, press m to return to Main Menu" , fillMode: .fill)
       livesText = Text(location: Point.zero, text: "Lives Left:", fillMode: .fill)
       livesValueText = Text(location:Point.zero, text:"\(playerLives)", fillMode:.fill)
       
        guard let HeartImageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Heart.png?raw=true") else {
          fatalError("Failed to create URL for HeartImage")
        }
            HeartImage = Image(sourceURL: HeartImageURL)
           
        super.init(name: "Hearts")
    }
    
   override func setup (canvasSize:Size, canvas:Canvas){
        livesText.font = "20pt Luminari"
        livesValueText.font = "20pt Luminari"
        
        endText.font = "50pt Luminari"

        endText.location = Point(x: canvasSize.center.x, y: canvasSize.center.y)
        endText.alignment = .center

        livesText.location = Point(x: canvasSize.width - 200, y: heartSize.height*2)
        livesValueText.location = Point(x: canvasSize.width-50, y: heartSize.height*2)

        canvas.setup(HeartImage)
   }
   
   override func render(canvas:Canvas) {

       if playerLives <= 0{

           canvas.render(scoreColor, endText)
       }
           
           if let canvasSize = canvas.canvasSize {
               for x in 0 ..< playerLives {
                   let currentHeartRect = Rect(topLeft: Point(x: canvasSize.width - ((5 - x) * heartSize.width) , y: heartSize.height / 2), size: heartSize)
              //     let currentHeartRectangle = Rectangle(rect: currentHeartRect, fillMode: .fillAndStroke)

                   let destinationRect = Rect(topLeft: currentHeartRect.topLeft, size: currentHeartRect.size)
                   HeartImage.renderMode = .destinationRect(destinationRect)

                   canvas.render(HeartImage) 
               }
           }
       }
    }
    

