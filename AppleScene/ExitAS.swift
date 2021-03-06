import Igis
import Scenes

class ExitSceneAS : Layer, KeyDownHandler{
    let hearts = Hearts()
    let scoreboard = Scoreboard()
    var readyToQuit = false

    let endText : Text
    let endValueText : Text
    let scoreColor = FillStyle(color:Color(.red))

    
    init() {
        
        endText = Text(location: Point.zero, text: "GAME OVER XP Earned:     , press m to return to Main Menu" , fillMode: .fill)
        endValueText = Text(location: Point.zero, text: "\(scoreboard.scoreValue)" , fillMode: .fill)




        super.init(name: "ExitSceneAS")
    }
    
    override func preSetup(canvasSize: Size, canvas: Canvas){
        
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
/*
    func endGame(){
        if(hearts.playerLives < 2 && ){
        director.enqueueScene(scene:MainScene())
        director.transitionToNextScene()
        }



    }

  

 */
          func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool){
        
        
        switch key
        {
           /*
        case "m":
            if(hearts.playerLives == 1  && readyToQuit == true){
                director.enqueueScene(scene:MainScene())
                director.transitionToNextScene()
            }
            
            */
        case"q":
            director.enqueueScene(scene:MainScene())
            director.transitionToNextScene()
        default:
            _ = 2
        }
    }
    
 
}
