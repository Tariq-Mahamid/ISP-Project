import Igis
import Scenes

class Hearts : RenderableEntity {
    let scoreboard = Scoreboard()
    var playerLives = 3
    var heartSize = Size(width: 50, height:50)

    let livesText: Text
    let livesValueText : Text

    let endText : Text
 //   let endValueText : Text

    var endValue = 0
    let scoreColor = FillStyle(color:Color(.red))

 
    init () {
        
        endText = Text(location: Point.zero, text: "GAME OVER, press m to return to Main Menu" , fillMode: .fill)
        //endValueText = Text(location: Point.zero, text: "\(endValue)" , fillMode: .fill)
        
        
        livesText = Text(location: Point.zero, text: "Lives Left:", fillMode: .fill)
        
       livesValueText = Text(location:Point.zero, text:"\(playerLives)", fillMode:.fill)

        super.init(name: "Hearts")
    }
   override func setup (canvasSize:Size, canvas:Canvas){
        livesText.font = "20pt Luminari"
        livesValueText.font = "20pt Luminari"
        
        
        endText.font = "50pt Luminari"
//        endValueText.font = "50pt Luminari"

        endText.location = Point(x: canvasSize.center.x, y: canvasSize.center.y)
        endText.alignment = .center
   //     endValueText.location = Point(x: canvasSize.center.x, y: canvasSize.center.y)

        
        livesText.location = Point(x: canvasSize.width - 200, y: heartSize.height*2)
        livesValueText.location = Point(x: canvasSize.width-50, y: heartSize.height*2)

  

   }
    override func render(canvas:Canvas) {
        livesValueText.text = String(playerLives)
        canvas.render(scoreColor, livesText, livesValueText)
        
        if playerLives <= 0{

       //     playerStats().health += (XP) -> gerardo need to explain his jank code
            
      //            
    //        endText.text = "GAME OVER XP Earned: \(endValue), \r\n press m to return to Main Menu"
    //        endValueText.text = String(endValue)
            canvas.render(scoreColor, endText)
        }
      
        if let canvasSize = canvas.canvasSize {
            for x in 0 ..< playerLives {
                let currentHeartRect = Rect(topLeft: Point(x: canvasSize.width - ((5 - x) * heartSize.width) , y: heartSize.height / 2), size: heartSize)
                let currentHeartRectangle = Rectangle(rect: currentHeartRect, fillMode: .fillAndStroke)
                
                canvas.render(FillStyle(color: Color(.orange)), currentHeartRectangle)
            }
        }
    }

    
    private func playerStats() -> PlayerStats {
        guard let playerStats = scene as? PlayerStats else {
            fatalError("playerStats of type PlayerStats is required")
        }
        return playerStats
    }

    
     
    
}
