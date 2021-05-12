import Igis
import Scenes
import Foundation

class Player: RenderableEntity, KeyDownHandler {
    var player = Rectangle(rect:Rect(), fillMode:.stroke)
    var playerSize = Size(width: 200, height: 206)
    var velocity = 20

    var ImagePlayerOne : Image
    var ImagePlayerTwo : Image
    var addend:Int = 0
    var addendy:Int = 0
    var canvasSize = Size()

    var specificCanvasWidth = 0
    var x = 0
    var y = 0
    var leftAnimation = false
    
    var leftTrue = 0
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let ImagePlayerURLOne = URL(string:"https://cdn.discordapp.com/attachments/747828138007986196/831939572274954260/LeftLeg.png") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        ImagePlayerOne = Image(sourceURL:ImagePlayerURLOne)

        guard let ImagePlayerURLTwo = URL(string:"https://cdn.discordapp.com/attachments/747828138007986196/831939579761131540/RightLeg.png") else{
            fatalError("Boi")
        }
        ImagePlayerTwo = Image(sourceURL:ImagePlayerURLTwo)
        
        super.init(name: "Player")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        canvas.setup(ImagePlayerOne)
        canvas.setup(ImagePlayerTwo)
        
        self.canvasSize = canvasSize
        player = Rectangle(rect: Rect(topLeft: Point(x: (Int(specificCanvasWidth / 2)+x) - Int(playerSize.width / 2), y: Int((canvasSize.height / 2)+y) - Int(playerSize.height / 2)), size: (playerSize)), fillMode: .stroke)
        self.canvasSize = canvasSize

        specificCanvasWidth = (480*canvasSize.height)/272

        x = (canvasSize.width/2)-(specificCanvasWidth/2)
        y = (canvasSize.height/2) - (canvasSize.height/2)
    }
    
    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            
            let isTouchingLeft = player.rect.topLeft.x < 10
            let isTouchingTop = player.rect.topRight.y < 10
            let isTouchingRight = player.rect.topRight.x > canvasSize.width - 10
            let isTouchingBottom = player.rect.bottomRight.y > canvasSize.height - 10
              
            if(isTouchingTop){
                director.enqueueScene(scene:AppleScene())
                director.transitionToNextScene()
            }else if(isTouchingRight){
                director.enqueueScene(scene:FightScene())
                director.transitionToNextScene()
            }
            else if(isTouchingBottom){
                director.enqueueScene(scene:AimingScene())
                director.transitionToNextScene()
            }else if(isTouchingLeft){
                director.enqueueScene(scene:MeditationScene())
                director.transitionToNextScene() 
            }
            if ImagePlayerOne.isReady && leftAnimation{
                let sourceRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:400, height:412))
                let destinationRect = Rect(topLeft:Point(x:(Int((specificCanvasWidth/2)+x+addend)-Int(playerSize.width/2)),y: Int((canvasSize.height/2)+y+addendy) - Int(playerSize.height / 2)), size:Size(width:200, height:206))

                ImagePlayerOne.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                
                canvas.render(ImagePlayerOne)
            }
            if ImagePlayerTwo.isReady && !leftAnimation{
                let sourceRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:400, height:412))
                let destinationRect = Rect(topLeft:Point(x:(Int((specificCanvasWidth/2)+x+addend)-Int(playerSize.width/2)),y: Int((canvasSize.height/2)+y+addendy) - Int(playerSize.height / 2)), size:Size(width:200, height:206))
                
                ImagePlayerTwo.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                
                canvas.render(ImagePlayerTwo)
            }
        }
        leftAnimation = !leftAnimation
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch key
        {
        case "a":
            if(willStayInXAxis(player.rect.topLeft.x-velocity)) {
                moveX(-velocity)
            }
        case "d":
            if(willStayInXAxis(player.rect.topRight.x+velocity)){
                moveX(velocity)
            }
        case "s":
            if(willStayInYAxis(player.rect.bottomRight.y+velocity)){
                moveY(velocity)
            }
        case "w":
            if(willStayInYAxis(player.rect.topRight.y-velocity)){
                moveY(-velocity)
            }
        default: 
            print(key)
        }
    }

    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
    func moveX(_ addX: Int) {
        
        addend += addX
        player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
    }
    
    func moveY(_ addY: Int) {
        leftTrue += 1
        addendy += addY
        player.rect.topLeft = Point(x: player.rect.topLeft.x, y: player.rect.topLeft.y + addY)
    }
    func willStayInXAxis(_ futureXPosition:Int) -> Bool{

        let specificCanvasWidth = 480*(canvasSize.height)/272
        let canvasWidth = canvasSize.width

        let x = (canvasWidth/2)-(specificCanvasWidth/2)
        
        return futureXPosition >= x && futureXPosition <= specificCanvasWidth+x
        
    }
    func willStayInYAxis(_ futureYPosition:Int) -> Bool{
        
        return futureYPosition >= 0 && futureYPosition <= canvasSize.height
    }
}
