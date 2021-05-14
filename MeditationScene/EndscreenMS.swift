import Igis
import Scenes

class EndScreenMS : RenderableEntity, KeyDownHandler{
    var endScreen = Rectangle(rect: Rect())
    var endScreenWidth : Int
    var endScreenHeight : Int
    var endScreenSize = Size()

    let endScreenStrokeStyle = StrokeStyle(color:Color(.orange))
    let endScreenFillStyle = FillStyle(color:Color(.gray))
    let endScreenLineWidth = LineWidth(width:5)
    
    var gameEnded = false
    var score = 0 //Should be retrieved before End Screen is rendered
    var addScore = true
    
    init() {
        endScreenWidth = 1100
        endScreenHeight = 400
    }

    func background() -> BackgroundMS {
        guard let mainScene = scene as? MeditationScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let background = backgroundLayer.background
        return background
    }

    override func setup(canvasSize:Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        endScreenSize = Size(width:endScreenWidth, height:endScreenHeight)
        endScreen = Rectangle(rect: Rect(topLeft: Point(x: (canvasSize.width/2 - endScreenWidth/2), y: (canvasSize.height/2 - endScreenHeight/2)), size: endScreenSize), fillMode: .fillAndStroke)
    }

    override func render(canvas:Canvas) {
        if background().lives == 0 {
            gameEnded = true
        }

        score = background().score
        
        let endScreenText = Text(location: Point(x: endScreen.rect.topLeft.x + 10, y:endScreen.rect.topLeft.y + 50), text: "Training Finished! You lost too many lives.")
        endScreenText.font = "40pt Luminari"
        
        let scoreText = Text(location: Point(x: endScreen.rect.topLeft.x + 10, y:endScreen.rect.topLeft.y + 250), text: "Experience gained: \(score)")
        scoreText.font = "40pt Luminari"

        endScreenText.alignment = .left
        scoreText.alignment = .left
        
        if gameEnded {
            canvas.render(endScreenLineWidth, endScreenStrokeStyle, endScreenFillStyle, endScreen)
            canvas.render(FillStyle(color: Color(.orange)), scoreText, endScreenText)

            if addScore {
                getPlayerStats().changeChakra(factor: score)
                addScore = false
            }
        }
    }
    
    func getPlayerStats() -> PlayerStats {
        guard let mainDirector = director as? ShellDirector else {
            fatalError("mainDirector of type ShellDirector is required")
        }
        return mainDirector.playerStats
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        
        switch code {
        case "KeyQ":
            if gameEnded{
                director.enqueueScene(scene: MainScene())
                director.transitionToNextScene()
            }
        case "KeyR":
            if gameEnded{
                director.enqueueScene(scene: MeditationScene())
                director.transitionToNextScene()
            }
        default :
            print("Unspecified key has been pressed.")
        }
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
}                          
