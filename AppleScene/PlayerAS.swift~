import Igis
import Scenes

class PlayerAS: RenderableEntity, KeyDownHandler, KeyUpHandler {
    var player = Rectangle(rect:Rect(), fillMode:.fill)
    var canvasSize = Size()
    var playerSize = Size(width: 50, height: 50)
    var velocity = 0
    var gameEnded = false

    let hearts = Hearts()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name: "PlayerAS")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)
        
        player = Rectangle(rect: Rect(topLeft: Point(x: Int(canvasSize.width / 2) - Int(playerSize.width / 2), y: canvasSize.height - playerSize.height), size: playerSize), fillMode: .fill)
        
        self.canvasSize = canvasSize
    }
    
    override func render(canvas:Canvas) {

        if !gameEnded {
            canvas.render(FillStyle(color: Color(.black)), player)
            
            if (player.rect.bottomRight.x + velocity) <= canvasSize.width  && player.rect.bottomLeft.x + velocity >= 0{
                player.rect.topLeft = Point(x: player.rect.topLeft.x + velocity, y: player.rect.topLeft.y)
            }
        }

    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

        switch key
        {
        case "d":
            velocity = 14
        case "a":
            velocity = -14
        default:
            print(key)

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
    
    func move(_ addX: Int) {
        player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
    }

    func willStayInCanvas(_ futurePosition: Int) -> Bool {
        return futurePosition > 0 && futurePosition < canvasSize.width
    }
    
    override func boundingRect() -> Rect {
        return player.rect
    }
 
}
