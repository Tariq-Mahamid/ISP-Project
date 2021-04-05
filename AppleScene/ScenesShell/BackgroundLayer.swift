import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
    
      let background = Background()

      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")

          // We insert our RenderableEntities in the constructor
          insert(entity:Apple(appleSpawnNumber: 1), at:.back)
          insert(entity:Apple(appleSpawnNumber: 2), at:.back)
          insert(entity:Apple(appleSpawnNumber: 3), at:.back)
          insert(entity:Garbage(garbageSpawnNumber: 1), at:.back)
          insert(entity:Garbage(garbageSpawnNumber: 2), at:.back)
          insert(entity:Garbage(garbageSpawnNumber: 3), at:.back)
          insert(entity:background, at:.back)
          insert(entity:Player(), at:.front)
      }
  }
