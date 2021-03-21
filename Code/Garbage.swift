import Igis
import Scenes

class Garbage : RenderableEntity{

    var garbage : Rectangle
    var velocity = 7
    var garbageSize : Size
    var garbageSpawnNumber = 1
    
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
        canvas.render(FillStyle(color: Color(.darkgreen)), garbage)
    }
    
    override func calculate(canvasSize: Size){
        if (garbage.rect.bottomLeft.y > canvasSize.height) {garbage.rect.topLeft = generateSpawnPoint(canvasSize)}
        
        garbage.rect.topLeft = Point(x: garbage.rect.topLeft.x, y: garbage.rect.topLeft.y + velocity)
    }

    private func generateSpawnPoint( _ canvasSize: Size, garbageSpawnNumber : Int = 1) -> Point{
        return Point(x: Int.random(in: 0...canvasSize.width - garbageSize.width), y: Int.random(in: Int(-canvasSize.height / 2) * garbageSpawnNumber...Int(-canvasSize.height / 2) * (garbageSpawnNumber - 1)))
    }
}
