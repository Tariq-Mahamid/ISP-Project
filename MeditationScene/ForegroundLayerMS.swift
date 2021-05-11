import Scenes

  /*
     This class is responsible for the foreground Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class ForegroundLayer : Layer {

    let endScreen = EndScreen()

      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Foreground")

          // We insert our RenderableEntities in the constructor
          insert(entity:endScreen, at:.front)
      }
  }
