
import Igis
import Scenes

class PlayerMovesFS : RenderableEntity, EntityMouseClickHandler {
    public var playerMoves = [PlayerMove]()
    public var playerMoveRectangles = [PlayerMoveRectangle]()
    public var currentPlayerMoveRectangle = PlayerMoveRectangle(rectangle: Rectangle(rect: Rect()), playerMove: PlayerMove(name: "", damage: 0, moveType: PlayerMoveType.normal, totalChakra: 0))
    public var playerMoveChakrasForegroundLayer = [Rectangle]()
    public var playerMoveChakrasBackgroundLayer = [Rectangle]()
    var shouldInitiateAttackSequence = false
    var playerChakra = 0
    
    init() {
        super.init(name: "PlayerMoves")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {  
        playerChakra = getPlayerStats().getChakra()

        let playerMovesArray = [PlayerMove(name: "Normal Attack", damage: getPlayerStats().getDamage() / 5, moveType: PlayerMoveType.normal, totalChakra: playerChakra / 5),
                            PlayerMove(name: "Clone Attack", damage: getPlayerStats().getDamage() / 5, moveType: PlayerMoveType.clone, totalChakra: playerChakra / 20),
                            PlayerMove(name: "Stun Attack", damage: 0, moveType: PlayerMoveType.stun, totalChakra: playerChakra / 10),
                            PlayerMove(name: "Rasenshuriken", damage: getPlayerStats().getDamage(), moveType: PlayerMoveType.rasenshuriken, totalChakra: Int(playerChakra / 50))]
        playerMoves = playerMovesArray

        let groundTopLeft = canvasSize.height * 2 / 3
        let playerMoveRectSize = Size(width: canvasSize.width / 6, height: canvasSize.height / 6)
        let playerChakraSize = Size(width: canvasSize.width/6, height: canvasSize.height / 18)
        
        var playerMoveRects = [Rect]()
        
        for currentMultiplier in stride(from: 0, to: 12, by: 3) {
            let currentX = (currentMultiplier < 5) ? (canvasSize.width * currentMultiplier) / 12 : (canvasSize.width * (currentMultiplier + 1)) / 12
            
            playerMoveRects.append(Rect(topLeft: Point(x: currentX, y: groundTopLeft + 7), size: playerMoveRectSize))
            playerMoveChakrasForegroundLayer.append(Rectangle(rect: Rect(topLeft: Point(x: currentX, y: groundTopLeft + playerMoveRectSize.height + 7), size: playerChakraSize), fillMode: .fillAndStroke))
            playerMoveChakrasBackgroundLayer.append(Rectangle(rect: Rect(topLeft: Point(x: currentX, y: groundTopLeft + playerMoveRectSize.height + 7), size: playerChakraSize), fillMode: .fillAndStroke))
        }
       
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
        for playerMoveRectangle in playerMoveRectangles{
            let playerMove = playerMoveRectangle.playerMove
            let rect = playerMoveRectangle.rectangle.rect
            let name = playerMove.getName()
            let color = playerMove.getMoveColor()
            let rectCenter = Point(x: rect.topLeft.x + rect.size.width / 2, y: rect.topLeft.y + rect.size.height / 2)
            
            canvas.render(FillStyle(color: color), playerMoveRectangle.rectangle)
            canvas.render(FillStyle(color: Color(.black)), Text(location: rectCenter, text: name))
        }

        if let canvasSize = canvas.canvasSize {
            let playerChakraSize = Size(width: canvasSize.width/6, height: canvasSize.height / 18)
           
            for currentChakra in 0..<playerMoveChakrasBackgroundLayer.count {
                let currentForegroundRect = playerMoveChakrasForegroundLayer[currentChakra].rect
                let currentPlayerMove = playerMoveRectangles[currentChakra].playerMove

                canvas.render(FillStyle(color: Color(.blue)), playerMoveChakrasBackgroundLayer[currentChakra])
                if (currentPlayerMove.getTotalChakraAmount() > 0) {
                    playerMoveChakrasForegroundLayer[currentChakra].rect = Rect(topLeft: currentForegroundRect.topLeft,
                                                                                size: Size(width: (playerChakraSize.width * currentPlayerMove.getCurrentChakra()) / currentPlayerMove.getTotalChakraAmount(),
                                                                                           height: playerChakraSize.height))
                    
                    canvas.render(FillStyle(color: Color(.deepskyblue)), playerMoveChakrasForegroundLayer[currentChakra])
                }
            }
        }
    }
    
    func getPlayerStats() -> PlayerStats {
        guard let mainDirector = director as? ShellDirector else {
            fatalError("mainDirector of type ShellDirector is required")
        }
        return mainDirector.playerStats
    }
}
