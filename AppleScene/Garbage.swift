import Igis
import Scenes
import Foundation

class Garbage : RenderableEntity{

    var garbage : Rectangle
    var velocity = 14
    var garbageSize : Size
    var garbageSpawnNumber = 1
    let scoreboard = Scoreboard()
    var gameEnded = false
    var ImageOfBoulder : Image
    
    init(garbageSpawnNumber: Int) {
        garbageSize = Size(width: 250, height: 250)
        self.garbageSpawnNumber = garbageSpawnNumber
        garbage = Rectangle(rect: Rect())

       guard let ImageOfBoulderURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Boulder.png?raw=true") else {
           fatalError("Failed to create URL for ImageOfBoulder")
        }
        ImageOfBoulder = Image(sourceURL: ImageOfBoulderURL)
       
        super.init(name: "Garbage")
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        garbage = Rectangle(rect: Rect(topLeft: generateSpawnPoint(canvasSize, garbageSpawnNumber: garbageSpawnNumber), size: garbageSize), fillMode: .fill)
        canvas.setup(ImageOfBoulder)
    }
    
    override func render(canvas: Canvas){

        if (gameEnded) {return}
        let destinationRect = Rect(topLeft: garbage.rect.topLeft, size: garbageSize)
        ImageOfBoulder.renderMode = .destinationRect(destinationRect)

        canvas.render(ImageOfBoulder)
    
    }
    
    override func calculate(canvasSize: Size){
        if (garbage.rect.bottomLeft.y > canvasSize.height) {
            resetPosition(canvasSize)
        }
        
        garbage.rect.topLeft = Point(x: garbage.rect.topLeft.x, y: garbage.rect.topLeft.y + velocity)
    }

    public func resetPosition(_ canvasSize: Size){
            garbage.rect.topLeft = generateSpawnPoint(canvasSize)
    }
    
    private func generateSpawnPoint( _ canvasSize: Size, garbageSpawnNumber : Int = 1) -> Point{
        return Point(x: Int.random(in: 0...canvasSize.width - garbageSize.width), y: Int.random(in: Int(-canvasSize.height / 2) * garbageSpawnNumber...Int(-canvasSize.height / 2) * (garbageSpawnNumber - 1)))
    }

    override func boundingRect() -> Rect{
        return garbage.rect
    }
}
