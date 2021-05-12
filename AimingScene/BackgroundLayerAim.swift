import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayerAim : Layer {

    let background = BackgroundAim()
    
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
          
          // We insert our RenderableEntities in the constructor
          insert(entity:background, at:.back)

      }
  }
