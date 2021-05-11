import Igis
import Scenes

class Garbage : RenderableEntity{

    var garbage : Rectangle
    var velocity = 7
    var garbageSize : Size
    var garbageSpawnNumber = 1
    let scoreboard = Scoreboard()
    var gameEnded = false

    init(garbageSpawnNumber: Int) {
        garbageSize = Size(width: 50, height: 50)
        self.garbageSpawnNumber = garbageSpawnNumber
        garbage = Rectangle(rect: Rect())
        
        super.init(name: "Garbage")
    }

    override func setup(canvasSize: Size, canvas: Canvas){

        garbage = Rectangle(rect: Rect(topLeft: generateSpawnPoint(canvasSize, garbageSpawnNumber: garbageSpawnNumber), size: garbageSize), fillMode: .fill)

    }
    
    override func render(canvas: Canvas){
        if !gameEnded {
            canvas.render(FillStyle(color: Color(.gray)), garbage)
        } 
    }
    
    override func calculate(canvasSize: Size){
        if (garbage.rect.bottomLeft.y > canvasSize.height) {
            resetPosition(canvasSize)
        }
        
        garbage.rect.topLeft = Point(x: garbage.rect.topLeft.x, y: garbage.rect.topLeft.y + velocity)
    }

    public func resetPosition(_ canvasSize: Size){

//        if hearts.playerLives > 0{
            garbage.rect.topLeft = generateSpawnPoint(canvasSize)
  //      }
    }
    
    private func generateSpawnPoint( _ canvasSize: Size, garbageSpawnNumber : Int = 1) -> Point{
        return Point(x: Int.random(in: 0...canvasSize.width - garbageSize.width), y: Int.random(in: Int(-canvasSize.height / 2) * garbageSpawnNumber...Int(-canvasSize.height / 2) * (garbageSpawnNumber - 1)))
    }

    override func boundingRect() -> Rect{
        return garbage.rect
    }
}
