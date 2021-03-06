import Igis
import Scenes
 
class PlayerStatsFS : RenderableEntity {
    var background = Rectangle(rect: Rect())
    private let playerName = "Naruto"
    private var level = 69
    private var health = 100

    var playerNameText : Text
    var levelText : Text
    let isOpponent: Bool
    
    var topLeft = Point()
    public let size: Size
    var didLoseHealth = false
    let minusText = Text(location: Point(), text: "yo")
    
    init(size: Size, isOpponent: Bool) {
        self.size = size
        self.isOpponent = isOpponent

        playerNameText = Text(location: Point(), text: playerName)
        playerNameText.font = "25pt Arial bold"
        playerNameText.alignment = .center
        
        levelText = Text(location: Point(), text: "Level: " + String(level))
        levelText.font = "25pt Arial bold"
        levelText.alignment = .center
        
        super.init(name: "PlayerStats")    
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        level = (getPlayerStats().getDamage() + getPlayerStats().getHealth() + getPlayerStats().getChakra()) / 3
        health = getPlayerStats().getHealth()
        
        topLeft = isOpponent ? Point(x: canvasSize.width - size.width, y: 0) : Point()
        background = Rectangle(rect: Rect(topLeft: topLeft, size: size), fillMode: .fill)
    }
    
    func assignBackgroundPoints(_ canvas: Canvas) {
        playerNameText.location = Point(x: topLeft.x + size.width / 4, y: topLeft.y + size.height/4)
        levelText.location = Point(x: topLeft.x + size.width * 3 / 4, y: topLeft.y + size.height/4)
    }

    func displaySubtractedHealth(amount: Int) {
        didLoseHealth = true
        
        minusText.text = "-\(amount)"
        minusText.location = Point(x: topLeft.x + size.width / 2, y: topLeft.y + size.height + 30)
    }
    
    override func render(canvas: Canvas){
        assignBackgroundPoints(canvas)
        background = Rectangle(rect: Rect(topLeft: topLeft, size: size), fillMode: .fillAndStroke)
        canvas.render(LineWidth(width: 10), FillStyle(color: Color(.gray)), background)

        canvas.render(FillStyle(color: Color(.black)), playerNameText)
        canvas.render(FillStyle(color: Color(.black)), levelText)
        if (didLoseHealth) {canvas.render(FillStyle(color: Color(.red)), minusText)}
    }

    func getPlayerStats() -> PlayerStats {
        guard let mainDirector = director as? ShellDirector else {
            fatalError("mainDirector of type ShellDirector is required")
        }
        return mainDirector.playerStats

    }
}

