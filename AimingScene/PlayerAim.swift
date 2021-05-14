import Igis
import Scenes
import Foundation

class PlayerAim: RenderableEntity, KeyDownHandler, KeyUpHandler {
    var player: Rectangle
    var canvasSize = Size()
    var playerSize = Size(width: 100, height: 100)
    var velocity = 0
    var canvasWidth = 1500
    var isProjectileInHand = true
    var gameEnded = false

    var defaultNaruto: Image
    var NarutoFacingLeft: Image
    var NarutoFacingRight: Image
    var NarutoWalkingRight: Image
    var NarutoWalkingLeft: Image

    var renderRight = false
    var renderLeft = false
    var renderBack = true

    var leftAnimation = false

    let projectile = Projectile()
    
    init() {
        player = Rectangle(rect:Rect(), fillMode:.fill)

        // Using a meaningful name can be helpful for debugging
        guard let defaultNarutoURL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Shuriken1.png?raw=true") else {
            fatalError("Failed to create URL for deafaultNaruto")
        }
        defaultNaruto = Image(sourceURL:defaultNarutoURL)

        
         guard let NarutoFacingLeftURL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Left1.png?raw=true") else {
         fatalError("Failed to create URL for NarutoFacingLeft")
         } 
         NarutoFacingLeft = Image(sourceURL:NarutoFacingLeftURL)

         guard let NarutoFacingRightURL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Right1.png?raw=true") else {
         fatalError("Failed to create URL for NarutoFacingForward")
         } 
         NarutoFacingRight = Image(sourceURL:NarutoFacingRightURL)

         guard let NarutoWalkingLeftURL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Left2.png?raw=true") else {
         fatalError("Failed to create URL for NarutoWalkingLeft")
         } 
         NarutoWalkingLeft = Image(sourceURL:NarutoWalkingLeftURL)

         guard let NarutoWalkingRightURL = URL(string: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Right2.png?raw=true") else {
         fatalError("Failed to create URL for NarutoWalkingRight")
         } 
         NarutoWalkingRight = Image(sourceURL:NarutoWalkingRightURL)
         
         
         super.init(name: "Player")
    }

    override func setup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerKeyUpHandler(handler: self)
        canvas.setup(defaultNaruto)
        canvas.setup(NarutoFacingLeft)
        canvas.setup(NarutoFacingRight)
        canvas.setup(NarutoWalkingRight)
        canvas.setup(NarutoWalkingLeft)
        
        
        player = Rectangle(rect: Rect(topLeft: Point(x: (canvasSize.width/2), y: (canvasSize.height - 100)), size: playerSize), fillMode: .fill)
        canvasWidth = canvasSize.width
        print(canvasWidth)
        self.canvasSize = canvasSize
    }

    override func render(canvas:Canvas) {

        if (gameEnded) {return}
        
        if abs(velocity) > 0 {
            leftAnimation = !leftAnimation
        }
        
        let destinationRect = Rect(topLeft: player.rect.topLeft, size: playerSize)

        if renderBack || velocity == 0 {
            if defaultNaruto.isReady {
                defaultNaruto.renderMode = .destinationRect(destinationRect)

                canvas.render(defaultNaruto)
            }
        }
        
        else if renderRight || velocity > 0 {
            if NarutoFacingRight.isReady && leftAnimation{
                NarutoFacingRight.renderMode = .destinationRect(destinationRect)
                
                canvas.render(NarutoFacingRight)
            }
            else if NarutoWalkingRight.isReady && !leftAnimation{
                NarutoWalkingRight.renderMode = .destinationRect(destinationRect)
                
                canvas.render(NarutoWalkingRight)    
            }
        } 
        else if renderLeft || velocity < 0 {
            if NarutoFacingLeft.isReady && leftAnimation{
                NarutoFacingLeft.renderMode = .destinationRect(destinationRect)
                
                canvas.render(NarutoFacingLeft)                
            }
            else if NarutoWalkingLeft.isReady && !leftAnimation{
                NarutoWalkingLeft.renderMode = .destinationRect(destinationRect)
                
                canvas.render(NarutoWalkingLeft)    
            } 
        }

        if !gameEnded {
            
            if (player.rect.bottomRight.x + velocity) <= canvasSize.width  && player.rect.bottomLeft.x + velocity >= 0{
                player.rect.topLeft = Point(x: player.rect.topLeft.x + velocity, y: player.rect.topLeft.y)
            }
        }

    }
    
    
    

        func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
            switch key
            {
            case "d":
                velocity = 14
                turnOffRenders()
                renderRight = true
            case "a":
                velocity = -14
                turnOffRenders()
                renderLeft = true
            case "q":
                if gameEnded {
                    director.enqueueScene(scene: MainScene())
                    director.transitionToNextScene()
                }
            case "r":
                if gameEnded {
                    director.enqueueScene(scene: AimingScene())
                    director.transitionToNextScene()
                }
                
            default:
                print(key)
            }
        }

        
        
        func turnOffRenders() {
            renderRight = false 
            renderLeft = false 
            renderBack = false
        }
        
        func onKeyUp(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
            switch key {
            case "d":
                velocity = 0
            case "a":
                velocity = 0
            default:
                print(key)
            }
        }

        override func teardown() {
            dispatcher.unregisterKeyDownHandler(handler: self)
            dispatcher.unregisterKeyUpHandler(handler: self)
        }

        override func boundingRect() -> Rect
        {
            let boundingRect = player.rect

            let left = boundingRect.center.x - (boundingRect.width / 2)
            let top = boundingRect.center.y - (boundingRect.height / 2)
            let width =  boundingRect.width
            let height = boundingRect.height

            return Rect(topLeft: Point(x: left, y: top), size: Size(width: width, height: height))
        }
        func moveX(_ addX: Int) {

            player.rect.topLeft = Point(x: player.rect.topLeft.x + addX, y: player.rect.topLeft.y)
        }

        func moveY(_ addY: Int) {

            player.rect.topLeft = Point(x: player.rect.topLeft.x, y: player.rect.topLeft.y + addY)
        }

    }

