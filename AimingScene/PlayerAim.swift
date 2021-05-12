import Igis
import Scenes

class PlayerAim: RenderableEntity, KeyDownHandler, KeyUpHandler {
    var player: Rectangle
    var canvasSize = Size()
    var playerSize = Size(width: 50, height: 50)
    var velocity = 0
    var canvasWidth = 1500
    var isProjectileInHand = true
    var gameEnded = false

    let projectile = Projectile()
    
    init() {
        player = Rectangle(rect:Rect(), fillMode:.fill)

        // Using a meaningful name can be helpful for debugging
        super.init(name: "Player")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)

        player = Rectangle(rect: Rect(topLeft: Point(x: (canvasSize.width/2), y: (canvasSize.height - 100)), size: playerSize), fillMode: .fill)
        canvasWidth = canvasSize.width
        print(canvasWidth)
        self.canvasSize = canvasSize
    }

    override func render(canvas:Canvas) {
        if !gameEnded {
            canvas.render(FillStyle(color: Color(.orange)), player)

            if isProjectileInHand {
                if (player.rect.bottomRight.x + velocity) <= (canvasWidth - 50)  && player.rect.bottomLeft.x + velocity >= 50{
                    player.rect.topLeft = Point(x: player.rect.topLeft.x + velocity, y: player.rect.topLeft.y)
                }
            }
        }
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if isProjectileInHand {
            switch key
            {
            case "d":
                if isProjectileInHand {
                    velocity = 14
                }

            case "a":
                if isProjectileInHand {
                    velocity = -14
                }
            default:
                print(key)
            }
        }
    }

    func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch key {
        case "d":
            velocity = 0
        case "a":
            velocity = 0
        default:
            print(key)
        }
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
        dispatcher.unregisterKeyUpHandler(handler: self)
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

/*    
    func willStayInCanvas(_ futurePosition: Int) -> Bool {
//        return futurePosition > 0 && futurePosition < canvasSize.width
    }
*/
}
