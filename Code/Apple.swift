import Igis
import Scenes

class Apple : RenderableEntity{

    var apple : Rectangle
    var velocity = 7
    var appleSize : Size
    var appleSpawnNumber = 1
    
    init(appleSpawnNumber: Int) {
        appleSize = Size(width: 50, height: 50)
        self.appleSpawnNumber = appleSpawnNumber
        apple = Rectangle(rect: Rect())
        
        super.init(name: "Apple")
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        apple = Rectangle(rect: Rect(topLeft: generateSpawnPoint(canvasSize, appleSpawnNumber: appleSpawnNumber), size: appleSize), fillMode: .fill)

    }
    
    override func render(canvas: Canvas){
        canvas.render(FillStyle(color: Color(.red)), apple)
    }
    
    override func calculate(canvasSize: Size){
        if (apple.rect.bottomLeft.y > canvasSize.height) {apple.rect.topLeft = generateSpawnPoint(canvasSize)}
        
        apple.rect.topLeft = Point(x: apple.rect.topLeft.x, y: apple.rect.topLeft.y + velocity)
    }

    private func generateSpawnPoint( _ canvasSize: Size, appleSpawnNumber : Int = 1) -> Point{
        return Point(x: Int.random(in: 0...canvasSize.width - appleSize.width), y: Int.random(in: Int(-canvasSize.height / 2) * appleSpawnNumber...Int(-canvasSize.height / 2) * (appleSpawnNumber - 1)))
    }
}
