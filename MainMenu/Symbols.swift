import Scenes
import Igis
import Foundation

class Symbol: RenderableEntity{

    var healthSign = Rectangle(rect:Rect())
    var chakraSign = Rectangle(rect:Rect())
    var FinalFightSign = Rectangle(rect:Rect())
    var MeditationSign = Rectangle(rect:Rect())
    var canvasSize = Size()
    
    var healthSignImage: Image
    var chakraSignImage: Image
    var finalFightSignImage: Image
    var aimSignImage: Image


    init () {

        guard let healthSignImageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/Images/SignHealth.png?raw=true") else {
            fatalError("Failed to create URL for healthSignImage")
        }
        healthSignImage = Image(sourceURL:healthSignImageURL)

        guard let chakraSignImageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/Images/SignChakra.png?raw=true") else {
            fatalError("Failed to create URL for chakraSignImage")
        }
        chakraSignImage = Image(sourceURL:chakraSignImageURL)

         guard let finalFightSignImageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/Images/SignArena.png?raw=true") else {
            fatalError("Failed to create URL for finalFightSignImage")
        }
         finalFightSignImage = Image(sourceURL:finalFightSignImageURL)

         guard let aimSignImageURL = URL(string:"https://github.com/Tariq-Mahamid/ISP-Project/blob/main/Images/SignDamage.png?raw=true") else {
            fatalError("Failed to create URL for aimSignImage")
        }
        aimSignImage = Image(sourceURL:aimSignImageURL)

        super.init(name: "Symbol")

    }
    override func setup (canvasSize: Size, canvas: Canvas) {
        canvas.setup(healthSignImage)
        canvas.setup(chakraSignImage)
        canvas.setup(finalFightSignImage)
        canvas.setup(aimSignImage)

        self.canvasSize = canvasSize
    }

    override func render (canvas:Canvas) {

        if let canvasSize = canvas.canvasSize {
            
            let destinationRectofFinalFight = Rect(topLeft:Point(x: canvasSize.width/2 + 450, y: canvasSize.height/2 + 125), size:Size(width: 150, height:150))  

            if finalFightSignImage.isReady {
                finalFightSignImage.renderMode = .destinationRect(destinationRectofFinalFight)

                canvas.render(finalFightSignImage)
            }

            let destinationRectofHealthSignImage = Rect(topLeft:Point(x: canvasSize.width/2 + 150, y:canvasSize.height/2 - 300), size:Size(width:150, height:150))

            if healthSignImage.isReady {
                healthSignImage.renderMode = .destinationRect(destinationRectofHealthSignImage)

                canvas.render(healthSignImage)
            }

            let destinationRectofAimSignImage = Rect(topLeft:Point(x: canvasSize.width/2 - 250, y:canvasSize.height/2 + 150), size:Size(width:150, height:150))

            if aimSignImage.isReady {
                aimSignImage.renderMode = .destinationRect(destinationRectofAimSignImage)

                canvas.render(aimSignImage)
            }

            let destinationRectofChakraSignImage = Rect(topLeft:Point(x: canvasSize.width/2 - 500, y:canvasSize.height/2 - 250), size:Size(width:150, height:150))

            if chakraSignImage.isReady {
                chakraSignImage.renderMode = .destinationRect(destinationRectofChakraSignImage)

                canvas.render(chakraSignImage)
            }
        }
    }
 
    private func foregroundLayer() -> ForegroundLayer {
        guard let mainScene = scene as? MainScene else {
            fatalError("mainScene of type MainScene is required")
        }
        return mainScene.foregroundLayer

    }
   
    
}