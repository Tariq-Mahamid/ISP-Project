import Igis
import Scenes


class EndScreen : RenderableEntity{
    var endScreen = Rectangle(rect: Rect())
    var endScreenWidth : Int
    var endScreenHeight : Int
    var endScreenSize = Size()

    let endScreenStrokeStyle = StrokeStyle(color:Color(.orange))
    let endScreenFillStyle = FillStyle(color:Color(.gray))
    let endScreenLineWidth = LineWidth(width:5)
    
    var gameEnded = false
    var score = 0 //Should be retrieved before End Screen is rendered

    init() {
        endScreenWidth = 1000
        endScreenHeight = 400
    }

    override func setup(canvasSize:Size, canvas: Canvas) {
        
        endScreenSize = Size(width:endScreenWidth, height:endScreenHeight)
        endScreen = Rectangle(rect: Rect(topLeft: Point(x: (canvasSize.width/2 - endScreenWidth/2), y: (canvasSize.height/2 - endScreenHeight/2)), size: endScreenSize), fillMode: .fillAndStroke)

    }

    override func render(canvas:Canvas) {
        let endScreenText = Text(location: Point(x: endScreen.rect.topLeft.x + 10, y:endScreen.rect.topLeft.y + 50), text: "Training Finished! The timer hit 0.")
        endScreenText.font = "40pt Luminari"
        
        let scoreText = Text(location: Point(x: endScreen.rect.topLeft.x + 10, y:endScreen.rect.topLeft.y + 250), text: "Experience gained: \(score)")
        scoreText.font = "40pt Luminari"

        if gameEnded {
            canvas.render(endScreenLineWidth, endScreenStrokeStyle, endScreenFillStyle, endScreen)
            canvas.render(FillStyle(color: Color(.orange)), scoreText, endScreenText)
        }
    }
}                          
