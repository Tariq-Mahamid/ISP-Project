import Igis
import Scenes
import Foundation

class PlayerRenderFS : RenderableEntity {
    private var playerRect = Rect()
    private let playerImage : Image
    private let isOpponent : Bool
    private let playerSize = Size(width: 300, height: 300)
    private let mrBenGlasses : Image
    
    private var moveForward = false
    private var moveBackwards = false

    private var positionToMove = 30
    private var currentPositionMoved = 0

    private let speed = 10
    
    public init(playerImageString : String, isOpponent: Bool)
    {
        self.isOpponent = isOpponent
        

        guard let playerImageURL = URL(string:playerImageString) else {
            fatalError("Failed to create URL for playerImageURL")
        }
        playerImage = Image(sourceURL: playerImageURL)

        guard let mrBenGlassesURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/FinishedScreen.jpeg?raw=true") else {
            fatalError("Failed to create URL for mrBenGlassesURL")
        }
        mrBenGlasses = Image(sourceURL: mrBenGlassesURL)
        
        super.init(name: "PlayerRenderFS")
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        let playerX = isOpponent ? canvasSize.width / 3 : (canvasSize.width * 2) / 3
        
        playerRect = Rect(topLeft: Point(x: playerX - (playerSize.width / 2), y: (canvasSize.height / 2) - playerSize.height), size: playerSize)
        canvas.setup(playerImage)
        canvas.setup(mrBenGlasses)
        
        positionToMove = canvasSize.width / 10
    }

    override func render(canvas: Canvas){
        //print(foregroundLayer().gameOverScreen.currentWinner)
        if (foregroundLayer().gameOver && !isOpponent && foregroundLayer().gameOverScreen.currentWinner == GameWinner.enemy) {
            let destinationRect = Rect(topLeft: playerRect.topLeft, size: Size(width: 300, height: 300))
            mrBenGlasses.renderMode = .destinationRect(destinationRect)

            canvas.render(mrBenGlasses)
        }
        else {
            let destinationRect = playerRect
            playerImage.renderMode = .destinationRect(destinationRect)

            canvas.render(playerImage)
        }
    }

    override func calculate(canvasSize: Size){
        if moveForward {
            if (isFinishedMoving()) {
                revertAnimation()
                return
            }
            
            movePlayer(factor: speed)
        }
        else if moveBackwards {
            if (isFinishedMoving()) {
                endAnimation()
                return
            }

            movePlayer(factor: -speed)
        }
    }

    private func isFinishedMoving() -> Bool {
        return abs(currentPositionMoved) > positionToMove
    }

    private func movePlayer(factor : Int) {
        let velocity = isOpponent ? factor : -factor

        playerRect.topLeft.x += velocity
        currentPositionMoved += velocity
    }
    
    public func initiateAnimation() {
        moveForward = true
    }

    private func revertAnimation() {
        moveForward = false
        moveBackwards = true
        currentPositionMoved = 0
    }

    private func endAnimation() {
        moveForward = false
        moveBackwards = false
        currentPositionMoved = 0
    }

    private func foregroundLayer() -> ForegroundLayerFS {
        guard let mainScene = scene as? FightScene else {
            fatalError("mainScene of type MainScene is required")
        }
        return mainScene.foregroundLayer
    }
}
