import Igis
import Scenes
import Foundation

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

    let blockColorNumber1URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Wind.png?raw=true"
    let blockColorNumber2URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Lightning.png?raw=true"
    let blockColorNumber3URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Fire.png?raw=true"
    let blockColorNumber4URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Water.png?raw=true"

    let backgroundImage1 : Image
    let backgroundImage2 : Image
    let backgroundImage3 : Image
    let backgroundImage4 : Image

    
    init() {
        guard let imageURL1 = URL(string:blockColorNumber1URL) else {
            fatalError("Failed to create URL for whitehouse")
        }

        guard let imageURL2 = URL(string:blockColorNumber2URL) else {
            fatalError("Failed to create URL for whitehouse")
        }

        guard let imageURL3 = URL(string:blockColorNumber3URL) else {
            fatalError("Failed to create URL for whitehouse")
        }

        guard let imageURL4 = URL(string:blockColorNumber4URL) else {
            fatalError("Failed to create URL for whitehouse")
        }
        
        backgroundImage1 = Image(sourceURL:imageURL1)
        backgroundImage2 = Image(sourceURL:imageURL2)
        backgroundImage3 = Image(sourceURL:imageURL3)
        backgroundImage4 = Image(sourceURL:imageURL4)

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
        canvas.setup(backgroundImage1, backgroundImage2, backgroundImage3, backgroundImage4)
    }

    func getRightBlockImage() -> Image {
        
        switch fillStyleColorNumber {
        case 1:
            return backgroundImage1
        case 2:
            return backgroundImage2
        case 3:
            return backgroundImage3
        case 4:
            return backgroundImage4
        default:
            print("The fillStyleColorNumber '\(fillStyleColorNumber) is not from 1 to 4.")
        }
        return backgroundImage1
    }


    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
    override func render(canvas:Canvas) {        
        if (gameEnded) {return}
        
        if background().lives == 0 {
            gameEnded = true
        }

//        canvas.render(fillStyle, block)

        if getRightBlockImage().isReady {
            getRightBlockImage().renderMode = .destinationRect(Rect(topLeft:Point(x:block.rect.topLeft.x, y:block.rect.topLeft.y), size:Size(width:120, height:100)))
            canvas.render(getRightBlockImage())
        }

        if (75 > block.rect.bottomLeft.x && 75 < block.rect.bottomRight.x) || (175 > block.rect.bottomLeft.x && 175 < block.rect.bottomRight.x) {
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
        if (gameEnded) {return}
        
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
        default :
            print("Unspecified key has been pressed.")
        }
    }
}
