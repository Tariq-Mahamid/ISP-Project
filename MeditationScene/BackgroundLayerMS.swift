import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayerMS : Layer {

    let background = BackgroundMS()
    
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"BackgroundMS")

          // We insert our RenderableEntities in the constructor
          insert(entity:background, at:.front)
      }
  }
