import Igis
import Scenes

public enum PlayerMoveType {
    case normal, fire, ice, lightning, wind
}

public class PlayerMove{
    private let name : String
    private let damage : Int
    private let moveType : PlayerMoveType

    init(name: String, damage: Int, moveType: PlayerMoveType){
        self.name = name
        self.damage = damage
        self.moveType = moveType
    }

    public func getName() -> String {
        return name
    }

    public func getDamage() -> Int {
        if (Bool.random()) {return Int(Double(damage) * criticalAmount())}
        return damage
    }

    public func criticalAmount() -> Double {
        return Double.random(in: 1...2)
    }
    
    public func getMoveType() -> PlayerMoveType {
        return moveType
    }

    public func getMoveColor() -> Color {
        switch moveType {
        case PlayerMoveType.normal:
            return Color(.gray)
        case PlayerMoveType.fire:
            return Color(.red)
        case PlayerMoveType.ice:
            return Color(.lightblue)
        case PlayerMoveType.lightning:
            return Color(.blue)
        case PlayerMoveType.wind:
            return Color(.white)
        }
    }
}

class PlayerMoves : RenderableEntity, EntityMouseClickHandler {
    public let playerMoves : [PlayerMove]
    public var playerMoveRectangles = [PlayerMoveRectangle]()
    public var currentPlayerMoveRectangle = PlayerMoveRectangle(rectangle: Rectangle(rect: Rect()), playerMove: PlayerMove(name: "", damage: 0, moveType: PlayerMoveType.fire))
    var shouldInitiateAttackSequence = false
    
    init(playerMoves: [PlayerMove]) {
        self.playerMoves = playerMoves
        
        super.init(name: "PlayerMoves")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {
        let groundTopLeft = canvasSize.height * 2 / 3
        let playerMoveRectSize = Size(width: canvasSize.width / 6, height: canvasSize.height / 6)
        var playerMoveRects = [Rect]()
        
        playerMoveRects.append(Rect(topLeft: Point(x: 0, y: groundTopLeft + 7), size: playerMoveRectSize))
        playerMoveRects.append(Rect(topLeft: Point(x: canvasSize.width / 4, y: groundTopLeft + 7), size: playerMoveRectSize))
        playerMoveRects.append(Rect(topLeft: Point(x: canvasSize.width * 7 / 12, y: groundTopLeft + 7), size: playerMoveRectSize))
        playerMoveRects.append(Rect(topLeft: Point(x: canvasSize.width * 10 / 12, y: groundTopLeft + 7), size: playerMoveRectSize))

        for currentMove in 0..<4 {
            playerMoveRectangles.append(PlayerMoveRectangle(rectangle: Rectangle(rect: playerMoveRects[currentMove], fillMode: .fillAndStroke), playerMove: playerMoves[currentMove]))
        }

        dispatcher.registerEntityMouseClickHandler(handler:self)
    }
    
    override func teardown() {
        dispatcher.unregisterEntityMouseClickHandler(handler:self)
    }
    
    override func boundingRect() -> Rect {
        return Rect(topLeft: Point(), size: Size(width: Int.max, height: Int.max))
    }
    
    func onEntityMouseClick(globalLocation: Point){
        for playerMoveRectangle in playerMoveRectangles {
            let isContained = playerMoveRectangle.rectangle.rect.containment(target: globalLocation).contains(.containedFully)
            if (isContained)
            {
                currentPlayerMoveRectangle = playerMoveRectangle
                shouldInitiateAttackSequence = true
            }
        }
    }
    
    override func render(canvas: Canvas){
        if let canvasSize = canvas.canvasSize {
            for playerMoveRectangle in playerMoveRectangles{
                let playerMove = playerMoveRectangle.playerMove
                let rect = playerMoveRectangle.rectangle.rect
                let name = playerMove.getName()
                let color = playerMove.getMoveColor()
                let rectCenter = Point(x: rect.topLeft.x + rect.size.width / 2, y: rect.topLeft.y + rect.size.height / 2)
                
                canvas.render(FillStyle(color: color), playerMoveRectangle.rectangle)
                canvas.render(FillStyle(color: Color(.black)), Text(location: rectCenter, text: name))
            }
        }
    }
}
