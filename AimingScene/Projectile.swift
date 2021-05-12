import Scenes
import Igis

class Projectile: RenderableEntity, KeyDownHandler, KeyUpHandler {
    let ellipse = Ellipse(center:Point(x:0, y:0), radiusX:25, radiusY:25, fillMode:.fillAndStroke)
    let strokeStyle = StrokeStyle(color:Color(.gray))
    let fillStyle = FillStyle(color:Color(.gray))
    let lineWidth = LineWidth(width:1)
    var canvasHeight = 1000
    var canvasWidth = 2000
    var gameEnded = false
    
    // Velocity to move with player
    var velocity = 0

    //Velocity when firing
    var velocityY = 0
    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Ball")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)
        
        canvasHeight = canvasSize.height
        canvasWidth = canvasSize.width
        ellipse.center.x = canvasWidth/2 + 50
        ellipse.center.y = canvasSize.height - 100
    }

    override func render(canvas:Canvas) {
        if !gameEnded {
            canvas.render(fillStyle, strokeStyle, lineWidth, ellipse)
            
            if ellipse.center.x + velocity + 50 <= canvasWidth && ellipse.center.x + velocity - 100 >= 0{
                ellipse.center = Point(x: ellipse.center.x + velocity, y: ellipse.center.y)
            }

            ellipse.center = Point(x: ellipse.center.x , y: ellipse.center.y + velocityY)

            if velocityY != 0 {
                velocity = 0
            }
        }
    }

    override func boundingRect() -> Rect {
        return Rect(topLeft: Point(x: ellipse.center.x - ellipse.radiusX, y: ellipse.center.y - ellipse.radiusY),
        size: Size(width: ellipse.radiusX * 2, height: ellipse.radiusY * 2))  
    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {

        switch key
        {
            /*
        case "d":
            if velocityY == 0 {
                velocity = 14
            }
        case "a":
            
            if velocityY == 0 {
                velocity = -14
            }
             */
        case "w":
            fire()
        default:
            print(key)
        }
    }

    func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        /*
        switch key {
        case "d":
            velocity = 0
        case "a":
            velocity = 0
        default:
            print(key)
        }
        
         */
    }

    
    func changeVelocity(velocityY:Int) {
        self.velocityY = velocityY
    }

    func fire() {
        velocityY = -25
    }

    func collision(canvas:Canvas) {
//        if (ellipse.center + 30
        velocityY = 0
    } 
}


