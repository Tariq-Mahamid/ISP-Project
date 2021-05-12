import Igis
import Scenes

class PlayerMS: RenderableEntity{
    var player: Rectangle
    let playerCenter = 100
    var canvasSize = Size()
    var playerSize = Size(width: 50, height: 50)
    let velocity = 25
    var gameEnded = false

    init() {
        player = Rectangle(rect:Rect(), fillMode:.fill)

        // Using a meaningful name can be helpful for debugging
        super.init(name: "Player")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        player = Rectangle(rect: Rect(bottomLeft: Point(x: 100, y: (canvasSize.height/2)), size: playerSize), fillMode: .fill)
        self.canvasSize = canvasSize
    }

    override func render(canvas:Canvas) {
        if background().lives == 0 {
            gameEnded = true
        }

        if !gameEnded {
            canvas.render(FillStyle(color: Color(.orange)), player)
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
    
    override func boundingRect() -> Rect
    {
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
