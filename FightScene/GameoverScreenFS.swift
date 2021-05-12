import Igis
import Scenes

enum GameWinner {case none, player, enemy}

class GameoverScreenFS : RenderableEntity, KeyDownHandler{

    public var currentWinner = GameWinner.none
    
    init() {
        super.init(name: "GameoverScreen")
    }

    override func render(canvas: Canvas) {

        if let canvasSize = canvas.canvasSize {
            if (foregroundLayer().gameOver) {
                let rectangle = Rectangle(rect: Rect(topLeft: Point(x: canvasSize.width / 3, y: canvasSize.height / 4),
                                                     size: Size(width: canvasSize.width / 3, height: canvasSize.height / 2)),
                                          fillMode: .fillAndStroke)
                let gameOverText = Text(location: Point(x: canvasSize.width / 2, y: canvasSize.height / 2), text: "Null")
                gameOverText.text = currentWinner == GameWinner.player ? "You Win!" : "You Lose :("
                
                canvas.render(LineWidth(width: 3), StrokeStyle(color: Color(.black)), FillStyle(color: Color(.gray)), rectangle)
                canvas.render(FillStyle(color: Color(.black)), gameOverText)
            }
        }
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
        
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

        if (!foregroundLayer().gameOver) {return}
        
        if (key == "r") {restartGame()}
        else if (key == "m") {switchToMainMenu()}
    }
    
    private func foregroundLayer() -> ForegroundLayerFS {
        guard let mainScene = scene as? FightScene else {
            fatalError("mainScene of type MainScene is required")
        }
        return mainScene.foregroundLayer
    }

    private func switchToMainMenu() {
        director.enqueueScene(scene: MainScene())
        director.transitionToNextScene()
    }

    private func restartGame() {
        director.enqueueScene(scene: FightScene())
        director.transitionToNextScene()
    }
}
