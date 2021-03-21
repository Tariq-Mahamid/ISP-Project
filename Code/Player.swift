import Igis
import Scenes

class Player: RenderableEntity, KeyDownHandler {
    var player: Rectangle
    var canvasSize = Size()
    var playerSize = Size(width: 50, height: 50)
    let velocity = 25
    
    init() {
        player = Rectangle(rect:Rect(), fillMode:.fill)

        // Using a meaningful name can be helpful for debugging
        super.init(name: "Player")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)

        player = Rectangle(rect: Rect(topLeft: Point(x: Int(canvasSize.width / 2) - Int(playerSize.width / 2), y: canvasSize.height - playerSize.height), size: playerSize), fillMode: .fill)
        
        self.canvasSize = canvasSize
    }
    
    override func render(canvas:Canvas) {
        canvas.render(FillStyle(color: Color(.orange)), player)
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        
        switch key
        {
            case "a":
                if (willStayInCanvas(player.rect.topLeft.x - velocity)) {move(-velocity)}
            case "d":
                if (willStayInCanvas(player.rect.topRight.x + velocity)) {move(velocity)}
            default: 
                print(key)
        }
    }
    
    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
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
    func move(_ addX: Int) {

        player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
    }

    func willStayInCanvas(_ futurePosition: Int) -> Bool {
        return futurePosition > 0 && futurePosition < canvasSize.width
    }
}
