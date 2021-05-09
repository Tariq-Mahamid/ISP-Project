import Igis
import Scenes


class BackgroundLayerAS : Layer {

    let background = BackgroundAS()
    let apples = [Apple(appleSpawnNumber: 1), Apple(appleSpawnNumber: 2), Apple(appleSpawnNumber: 3)]
    let garbages = [Garbage(garbageSpawnNumber: 1), Garbage(garbageSpawnNumber: 2), Garbage(garbageSpawnNumber: 3)]
    let player = PlayerAS()

    let hearts = Hearts()
    
    let scoreboard = Scoreboard()
    
      init() {
          // Using a meaningful name can be helpful for debugging

                  
          super.init(name:"Background")

          for apple in apples {
              insert(entity:apple, at:.back)
          }

          for garbage in garbages {
              insert(entity:garbage, at:.back)
          }
          
          // We insert our RenderableEntities in the constructor
          insert(entity:player, at:.front)
          insert(entity:scoreboard, at:.back)
          insert(entity:background, at:.back)
          insert(entity:hearts, at:.front)

      }

      override func postCalculate(canvas: Canvas){
          if let canvasSize = canvas.canvasSize{
              checkForContainment(canvasSize)
          }
      }

      func checkForContainment (_ canvasSize: Size) {
          let playerBoundingRect = player.boundingRect()

          for currentObject in 0..<3 {
              let appleBoundingRect = apples[currentObject].boundingRect()
              let garbageBoundingRect = garbages[currentObject].boundingRect()

              let garbageContainment = playerBoundingRect.containment(target: garbageBoundingRect)
              let appleContainment = playerBoundingRect.containment(target: appleBoundingRect)

              let isTouchingGarbage = garbageContainment.contains(.overlapsTop) && !garbageContainment.contains(.beyondHorizontally)
              let isTouchingApple = appleContainment.contains(.overlapsTop) && !appleContainment.contains(.beyondHorizontally)
          
              if (hearts.playerLives > 0 && isTouchingGarbage) {
                  print(hearts.playerLives)
                  
                  garbages[currentObject].resetPosition(canvasSize) 
                  
                  //print(hearts.playerLives)    
                  hearts.playerLives -= 1
                  
                  
                  
              }
              
              if (isTouchingApple) {
                  scoreboard.scoreValue += 1
                  apples[currentObject].resetPosition(canvasSize)
              }
          }
      }
}
      
