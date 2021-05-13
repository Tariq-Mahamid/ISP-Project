import Igis
import Scenes

class TimingBlockMS: RenderableEntity, KeyDownHandler {
    var block = Rectangle(rect: Rect())
    var velocity = 0
    var defaultVelocity = 12
    var canvasWidth = 1800
    var fillStyleColorNumber = 0
    var fillStyle = FillStyle(color: Color(.gray))
    var touchingPlayer = false
    var scored = false
    var timed = false
    var gameEnded = false

    init() {
        super.init(name: "TimingBlock")
    }

    func background() -> BackgroundMS {
        guard let mainScene = scene as? MeditationScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let background = backgroundLayer.background
        return background
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        block = Rectangle(rect: Rect(bottomLeft:Point(x:canvasSize.width + 120, y: canvasSize.height/2), size:Size(width:120, height: 100)), fillMode:.fill)
        fillStyle = FillStyle(color: Color(.gray))
        canvasWidth = canvasSize.width
        fillStyle = FillStyle(color: randomizeBlockColor())
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
    override func render(canvas:Canvas) {
        
        if background().lives == 0 {
            gameEnded = true
        }

        if !gameEnded {
            canvas.render(fillStyle, block)
        }

        if (75 > block.rect.bottomLeft.x && 75 < block.rect.bottomRight.x) || (125 > block.rect.bottomLeft.x && 125 < block.rect.bottomRight.x) {
            touchingPlayer = true
        }
        else {
            touchingPlayer = false
        }
        if block.rect.topLeft.x == canvasWidth + 120 {
            fillStyle = FillStyle(color: randomizeBlockColor())
        }
    }
    
    override func calculate(canvasSize: Size) {
        block.rect.topLeft = Point(x:block.rect.topLeft.x - velocity, y:block.rect.topLeft.y)
        if block.rect.topLeft.x < -120 {

            if !scored {
                background().decreaseLives()
            }
            velocity = 0
            block.rect.topLeft = Point(x:canvasSize.width + 120, y: block.rect.topLeft.y)
            scored = false
            timed = false
        }
    }
    
    func randomizeBlockColor() -> Color {
        let colorNumber = Int.random(in: 1...4)
        var color = Color(.purple)
        fillStyleColorNumber = colorNumber
        
        switch colorNumber {
        case 1:
            color = Color(.green)
        case 2:
            color = Color(.yellow)
        case 3:
            color = Color(.red)
        case 4:
            color = Color(.blue)
        default:
            color = Color(.green)
        }
        return color
    }

    func associateKey() -> String {
        var key = "UnknownKey"
        if isConditionsForScoringMet() {
            switch fillStyleColorNumber {
            case 1:
                key = "KeyQ"
            case 2:
                key = "KeyW"
            case 3:
                key = "KeyR"
            case 4:
                key = "KeyE"
            default:
                fatalError("UnknownKey due to unkown color number: \(fillStyleColorNumber)")
            }
            print(key)
        }
        return key
    }

    func isConditionsForScoringMet() -> Bool {
        var conditionsForScoringMet = false
        if (touchingPlayer == true) && (scored == false) {
            conditionsForScoringMet = true
        }
        return conditionsForScoringMet
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        let conditionsForScoringMet = isConditionsForScoringMet()
        let correctKey = associateKey()

        switch code {
        case "KeyQ":
            if conditionsForScoringMet && (correctKey == "KeyQ") {
                background().increaseScore()
                scored = true
                break;
            }
            if (touchingPlayer == true) && !(correctKey == "KeyQ") {
                if !(timed) {
                    background().decreaseLives()
                }
                timed = true
            }
            if gameEnded {
                director.enqueueScene(scene: MainScene())
                director.transitionToNextScene()
            }
        case "KeyW":
            if conditionsForScoringMet && (correctKey == "KeyW") {
                background().increaseScore()
                scored = true
                break;
            }
            if (touchingPlayer == true) && !(correctKey == "KeyW") {
                if !(timed) {
                    background().decreaseLives()
                }
                timed = true
            }
        case "KeyE":
            if conditionsForScoringMet && (correctKey == "KeyE") {
                background().increaseScore()
                scored = true
                break;
            }
            if (touchingPlayer == true) && !(correctKey == "KeyE") {
                if !(timed) {
                    background().decreaseLives()
                }
                timed = true
            }
        case "KeyR":
            if conditionsForScoringMet && (correctKey == "KeyR") {
                background().increaseScore()
                scored = true
                break;
            }
            if (touchingPlayer == true) && !(correctKey == "KeyR") {
                if !(timed) {
                    background().decreaseLives()
                }
                timed = true
            }
            if gameEnded {
                if gameEnded {
                    director.enqueueScene(scene: MeditationScene())
                    director.transitionToNextScene()
                }
            }
        default :
            print("Unspecified key has been pressed.")
        }
    }
}
