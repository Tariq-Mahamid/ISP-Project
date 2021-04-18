import Igis
import Scenes

class Scoreboard: RenderableEntity {

  let scoreText: Text
  let scoreValueText: Text
  var scoreValue = 0
  
  private let offsetFromCenter = 200
  private let verticalOffset = 100

  private let scoreColor = FillStyle(color: Color(.red))

  init() {
      scoreText = Text(location: Point.zero, text: "XP Gained:", fillMode: .fill)
      scoreValueText = Text(location: Point.zero, text: "\(scoreValue)" , fillMode: .fill)
  }

  override func setup (canvasSize: Size, canvas: Canvas) {
      scoreText.font = "50pt Arial"
      scoreValueText.font = "50pt Arial" 
      
      scoreText.location = Point(x: canvasSize.center.x - offsetFromCenter, y: verticalOffset)
      scoreValueText.location = Point(x: canvasSize.center.x + offsetFromCenter, y: verticalOffset)
  }

  override func render(canvas: Canvas) {
      scoreValueText.text = String(scoreValue)
      print(scoreValueText.text)
      canvas.render(scoreColor, scoreValueText, scoreText)
  }
}
