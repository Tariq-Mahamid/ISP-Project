import Igis
import Scenes
import Foundation

class HealthBarFS : RenderableEntity{
    public var healthRectangle = Rectangle(rect: Rect())
    let beginningHealthWidth : Int
    var healthSize : Size
    var canvasSize = Size()

    let startingColor = Color(.green)
    let endingColor = Color(.red)
    var curHealth = 100

    let playerStatsSize : Size
    let isOpponent : Bool
    var playerStatsTopLeft = Point()
    
    init(playerStatsSize: Size, isOpponent: Bool) {
        self.playerStatsSize = playerStatsSize
        self.isOpponent = isOpponent
        
        healthSize = Size(width: playerStatsSize.width * 4 / 5, height: playerStatsSize.height / 4)
        beginningHealthWidth = healthSize.width
        
        super.init(name: "Health")
    }

    override func setup(canvasSize: Size, canvas: Canvas){
        self.canvasSize = canvasSize
        let topLeft = isOpponent ? Point(x: canvasSize.width - playerStatsSize.width, y: 0) : Point()
        healthRectangle = Rectangle(rect: Rect(topLeft: Point(x: topLeft.x + playerStatsSize.width / 10, y: topLeft.y + playerStatsSize.height * 3 / 5), size: healthSize), fillMode: .fill)
    }

    private func resizeHealth() {
        healthRectangle.rect.size = healthSize
    }
    
    override func render(canvas: Canvas){
        resizeHealth()
        
        canvas.render(FillStyle(color: calculateColor(percent: Double(100 - curHealth) / 100)), healthRectangle)
    }
     
    func calculateColor(percent: Double) -> Color {
        let percentFromOne : Double = (1 - percent)
        
        let red = (percentFromOne * Double(startingColor.red)) + (Double(endingColor.red) * percent)
        let green = (percentFromOne * Double(startingColor.green)) + (Double(endingColor.green) * percent)
        let blue = (percentFromOne * Double(startingColor.blue)) + (Double(endingColor.blue) * percent)

        
        return Color(red: UInt8(red), green: UInt8(green), blue: UInt8(blue))
    }
    
    public func subtractHealth(_ health: Int){
        curHealth -= health
        healthSize.width -= beginningHealthWidth * health / 100
    }
}
