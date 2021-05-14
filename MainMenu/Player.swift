import Igis
import Scenes
import Foundation

class Player: RenderableEntity, KeyDownHandler {
    var player = Rectangle(rect:Rect(), fillMode:.stroke)
    var playerSize = Size(width: 200, height: 206)
    var velocity = 20

    var ImagePlayerOne : Image
    var ImagePlayerTwo : Image
    var BackPlayerOne : Image
    var BackPlayerTwo : Image
    var LeftPlayerOne : Image
    var LeftPlayerTwo : Image
    var RightPlayerOne : Image
    var RightPlayerTwo : Image

    var addend:Int = 0
    var addendy:Int = 0
    var canvasSize = Size()

    var specificCanvasWidth = 0
    var x = 0
    var y = 0

    var renderUp = false
    var renderRight = false
    var renderDown = true
    var renderLeft = false
    
    var leftAnimation = false
    
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let ImagePlayerURLOne = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Front1.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        ImagePlayerOne = Image(sourceURL:ImagePlayerURLOne)

        guard let ImagePlayerURLTwo = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Front2.png?raw=true") else{
            fatalError("Boi")
        }
        ImagePlayerTwo = Image(sourceURL:ImagePlayerURLTwo)

        guard let BackPlayerURLOne = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Back1.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        BackPlayerOne = Image(sourceURL:BackPlayerURLOne)
        
        guard let BackPlayerURLTwo = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Back2.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        BackPlayerTwo = Image(sourceURL:BackPlayerURLTwo)

        guard let LeftPlayerURLOne = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Left1.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        LeftPlayerOne = Image(sourceURL:LeftPlayerURLOne)
        
        guard let LeftPlayerURLTwo = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Left2.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        LeftPlayerTwo = Image(sourceURL:LeftPlayerURLTwo)

        guard let RightPlayerURLOne = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Right1.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        RightPlayerOne = Image(sourceURL:RightPlayerURLOne)
        
        guard let RightPlayerURLTwo = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Right2.png?raw=true") else {
            fatalError("Failed to create URL for ImagePlayerOne")
        }
        RightPlayerTwo = Image(sourceURL:RightPlayerURLTwo)
        
        super.init(name: "Player")
    }
    
    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        canvas.setup(ImagePlayerOne)
        canvas.setup(ImagePlayerTwo)
        canvas.setup(BackPlayerOne)
        canvas.setup(BackPlayerTwo)
        canvas.setup(LeftPlayerOne)
        canvas.setup(LeftPlayerTwo)
        canvas.setup(RightPlayerOne)
        canvas.setup(RightPlayerTwo)
        
        self.canvasSize = canvasSize
        player = Rectangle(rect: Rect(topLeft: Point(x: (Int(specificCanvasWidth / 2)+x) - Int(playerSize.width / 2), y: Int((canvasSize.height / 2)+y) - Int(playerSize.height / 2)), size: (playerSize)), fillMode: .stroke)
        self.canvasSize = canvasSize

        specificCanvasWidth = (480*canvasSize.height)/272

        x = (canvasSize.width/2)-(specificCanvasWidth/2)
        y = (canvasSize.height/2) - (canvasSize.height/2)
    }
    
    override func render(canvas:Canvas) {
        if let canvasSize = canvas.canvasSize {
            
            let isTouchingLeft = player.rect.topLeft.x < -(canvasSize.width / 2)
            let isTouchingTop = player.rect.topRight.y < 10
            let isTouchingRight = player.rect.topRight.x > (canvasSize.width / 2) - 10
            let isTouchingBottom = player.rect.bottomRight.y > canvasSize.height - 10
              
            if(isTouchingTop){
                director.enqueueScene(scene:AppleScene())
                director.transitionToNextScene()
                print("Transitioned")
            }else if(isTouchingRight){
                director.enqueueScene(scene:FightScene())
                director.transitionToNextScene()
                print("Transitioned")
            }
            else if(isTouchingBottom){
                director.enqueueScene(scene:AimingScene())
                director.transitionToNextScene()
                print("Transitioned")
            }else if(isTouchingLeft){
                director.enqueueScene(scene:MeditationScene())
                director.transitionToNextScene()
                print("Transitioned")
            }
            let sourceRect = Rect(topLeft:Point(x:0, y:0), size:Size(width:400, height:412))
            let destinationRect = Rect(topLeft:Point(x:(Int((specificCanvasWidth/2)+x+addend)-Int(playerSize.width/2)),y: Int((canvasSize.height/2)+y+addendy) - Int(playerSize.height / 2)), size:Size(width:200, height:206))
            if renderDown {
                if ImagePlayerOne.isReady && leftAnimation{
                ImagePlayerOne.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                
                canvas.render(ImagePlayerOne)                
                }
                else if ImagePlayerTwo.isReady && !leftAnimation{
                    ImagePlayerTwo.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(ImagePlayerTwo)    
                }
            }
            else if renderRight {
                if RightPlayerOne.isReady && leftAnimation{
                    RightPlayerOne.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(RightPlayerOne)
                }
                else if RightPlayerTwo.isReady && !leftAnimation{
                    RightPlayerTwo.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(RightPlayerTwo)    
                }
            }
            else if renderLeft {
                if LeftPlayerOne.isReady && leftAnimation{
                    LeftPlayerOne.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(LeftPlayerOne)                
                }
                else if LeftPlayerTwo.isReady && !leftAnimation{
                    LeftPlayerTwo.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(LeftPlayerTwo)    
                } 
            }
            else if renderUp {
                if BackPlayerOne.isReady && leftAnimation{
                    BackPlayerOne.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(BackPlayerOne)                
                }
                else if BackPlayerTwo.isReady && !leftAnimation{
                    BackPlayerTwo.renderMode = .sourceAndDestination(sourceRect:sourceRect, destinationRect:destinationRect)
                    
                    canvas.render(BackPlayerTwo)    
                }
            }
        }
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch key
        {
        case "a":
            turnOffRenders()
            renderLeft = true
            
            moveX(-velocity)
            leftAnimation = !leftAnimation
        case "d":
            turnOffRenders()
            renderRight = true
            
            moveX(velocity)
            leftAnimation = !leftAnimation
        case "s":
            turnOffRenders()
            renderDown = true
            
            moveY(velocity)
            leftAnimation = !leftAnimation
        case "w":
            turnOffRenders()
            renderUp = true
            
            moveY(-velocity)
            leftAnimation = !leftAnimation
            
        default: 
            print(key)
        }
    }
    
    func turnOffRenders() {
        renderUp = false
        renderDown = false
        renderRight = false
        renderLeft = false
    }
    
    private func foregroundLayer() -> ForegroundLayer {
        guard let mainScene = scene as? MainScene else {
            fatalError("mainScene of type MainScene is required")
        }
        return mainScene.foregroundLayer

    }
    
    override func teardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
    func moveX(_ addX: Int) {
        
        addend += addX
        player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
    }
    
    func moveY(_ addY: Int) {

        addendy += addY
        player.rect.topLeft = Point(x: player.rect.topLeft.x, y: player.rect.topLeft.y + addY)
    }
}
