import Igis
import Scenes

/*
 This class is primarily responsible for transitioning between Scenes.
 At a minimum, it must enqueue the first Scene.
*/
class ShellDirector : Director {
    required init() {
        super.init()
        enqueueScene(scene:AppleScene())
    }

    override func framesPerSecond() -> Int {
        return 30
    }

}

