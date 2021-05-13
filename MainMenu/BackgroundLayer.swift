import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
    
      let background = Background()
      let playerStatsView = PlayerStatsView()
      
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")

          // We insert our RenderableEntities in the constructor
          insert(entity:background, at:.front)
          insert(entity:Player(), at:.front)
          insert(entity: playerStatsView, at:.front)
      }
  }
