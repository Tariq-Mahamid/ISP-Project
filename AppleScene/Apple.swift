import Igis
import Scenes
import Foundation

class Apple : RenderableEntity{
    
    let hearts = Hearts()
    var apple = Rectangle(rect: Rect())
    let velocity = 7
    var appleSize = Size(width: 50, height: 50)
    var appleSpawnNumber = 1
    var gameEnded = false
    var ImageOfRamen: Image
    
    init(appleSpawnNumber: Int) {
        self.appleSpawnNumber = appleSpawnNumber

      guard let ImageOfRamenURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Ramen.png?raw=true") else {
          fatalError("Failed to create URL for ImageOfRamen")
       }
      ImageOfRamen = Image(sourceURL: ImageOfRamenURL)
        
        super.init(name: "Apple")
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        apple = Rectangle(rect: Rect(topLeft: generateSpawnPoint(canvasSize, appleSpawnNumber: appleSpawnNumber), size: appleSize), fillMode: .fill)
        canvas.setup(ImageOfRamen)
    }
    
    override func render(canvas: Canvas){
        if (gameEnded) {return}
        
        let destinationRect = Rect(topLeft: apple.rect.topLeft, size: appleSize)
        ImageOfRamen.renderMode = .destinationRect(destinationRect)

        canvas.render(ImageOfRamen)
    }
    
    override func calculate(canvasSize: Size){
        if (apple.rect.bottomLeft.y > canvasSize.height) {
            resetPosition(canvasSize)
        }
        
        apple.rect.topLeft = Point(x: apple.rect.topLeft.x, y: apple.rect.topLeft.y + velocity)
    }

    public func resetPosition(_ canvasSize: Size) {
        print(hearts.playerLives)

        apple.rect.topLeft = generateSpawnPoint(canvasSize)
    }
    
    private func generateSpawnPoint( _ canvasSize: Size, appleSpawnNumber : Int = 1) -> Point{
        return Point(x: Int.random(in: 0...canvasSize.width - appleSize.width), y: Int.random(in: Int(-canvasSize.height / 2) * appleSpawnNumber...Int(-canvasSize.height / 2) * (appleSpawnNumber - 1)))
    }

    override func boundingRect() -> Rect{
        return apple.rect
    }
}
