import Scenes

  /*
     This class is responsible for the foreground Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class ForegroundLayerMS : Layer {

    let endScreen = EndScreenMS()

      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"ForegroundMS")

          // We insert our RenderableEntities in the constructor
          insert(entity:endScreen, at:.front)
      }
  }
