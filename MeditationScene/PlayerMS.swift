import Igis
import Scenes
import Foundation

class PlayerMS: RenderableEntity{
    var player: Rectangle
    let playerCenter = 100
    var canvasSize = Size()
    var playerSize = Size(width: 100, height: 100)
    let velocity = 25
    var gameEnded = false
    var frameCounter = 0

    let meditationSprite1URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Meditation1.png?raw=true"
    let meditationSprite2URL = "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Meditation2.png?raw=true"

    let meditationImage1 : Image
    let meditationImage2 : Image

    var renderImage1 = true
    var renderImage2 = false

    init() {
        player = Rectangle(rect:Rect(), fillMode:.fill)

        guard let image1URL = URL(string:meditationSprite1URL) else {
            fatalError("Failed to create URL for whitehouse")
        }

        guard let image2URL = URL(string:meditationSprite2URL) else {
            fatalError("Failed to create URL for whitehouse")
        }

        meditationImage1 = Image(sourceURL:image1URL)
        meditationImage2 = Image(sourceURL:image2URL)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name: "Player")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        player = Rectangle(rect: Rect(bottomLeft: Point(x: 100, y: (canvasSize.height/2)), size: playerSize), fillMode: .fill)
        self.canvasSize = canvasSize
        canvas.setup(meditationImage1)
        canvas.setup(meditationImage2)        
    }

    override func render(canvas:Canvas) {

        frameCounter += 1
        if background().lives == 0 {
            gameEnded = true
        }
        
        if (gameEnded) {return}
        let destinationRect = Rect(topLeft: player.rect.topLeft, size: playerSize)

        if frameCounter == 30 {
            switchFrames()
            frameCounter = 0
        }

        if renderImage1 == true {
            if meditationImage1.isReady {
                meditationImage1.renderMode = .destinationRect(destinationRect)
                canvas.render(meditationImage1)
            }
        }

        if renderImage2 == true {
            if meditationImage2.isReady {
                meditationImage2.renderMode = .destinationRect(destinationRect)
                canvas.render(meditationImage2)
            }
        }
    }

    func switchFrames() {
        if renderImage1 == true {
            renderImage1 = false
            renderImage2 = true
        }
        else {
            renderImage1 = true
            renderImage2 = false
        }
    }
    
    func background() -> BackgroundMS{
        guard let mainScene = scene as? MeditationScene else {
            fatalError("mainScene of type MainScene is required")
        }
        let backgroundLayer = mainScene.backgroundLayer
        let background = backgroundLayer.background
        return background
    }
    
    override func boundingRect() -> Rect {
        let boundingRect = player.rect

        let left = boundingRect.center.x - (boundingRect.width / 2)
        let top = boundingRect.center.y - (boundingRect.height / 2)
        let width =  boundingRect.width
        let height = boundingRect.height

        return Rect(topLeft: Point(x: left, y: top), size: Size(width: width, height: height))
    }
    func moveX(_ addX: Int) {

        player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
    }

    func moveY(_ addY: Int) {

        player.rect.topLeft = Point(x: player.rect.topLeft.x, y: player.rect.topLeft.y + addY)
    }

    func willStayInCanvas(_ futurePosition: Int) -> Bool {
        return futurePosition > 0 && futurePosition < canvasSize.width
    }
}
