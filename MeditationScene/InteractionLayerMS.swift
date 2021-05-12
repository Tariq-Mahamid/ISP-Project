import Scenes
import Igis

  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayerMS : Layer, KeyDownHandler{

    let player = PlayerMS()
    let block1 = TimingBlockMS()
    let block2 = TimingBlockMS()
    let block3 = TimingBlocMSk()
    let block4 = TimingBlockMS()
    let block5 = TimingBlockMS()
    let block6 = TimingBlockMS()
    let block7 = TimingBlockMS()
    let block8 = TimingBlockMS()

    var arrayOfBlocks = [TimingBlock]()
    var canvasSizeWidth = 0

    init() {
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"InteractionMS")
        
        arrayOfBlocks = [block1, block2, block3, block4]
        
        // We insert our RenderableEntities in the constructor
        insert(entity:player, at:.front)

        for block in arrayOfBlocks {
            insert(entity: block, at:.front)
        }
    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        dispatcher.registerKeyDownHandler(handler: self)
        canvasSizeWidth = canvasSize.width

        //Begins movement of blocks
        arrayOfBlocks[0].velocity = arrayOfBlocks[0].defaultVelocity
    }

    override func postCalculate(canvas: Canvas) {

        // After the previous block passes a certain point on the canvas, the next block begins moving
        for i in 1..<arrayOfBlocks.count {
            if arrayOfBlocks[i - 1].velocity > 0 && arrayOfBlocks[i - 1].block.rect.bottomLeft.x < (canvasSizeWidth - canvasSizeWidth/arrayOfBlocks.count) {
                arrayOfBlocks[i].velocity = arrayOfBlocks[i].defaultVelocity
            }
            if i == (arrayOfBlocks.count - 1) && arrayOfBlocks[i].block.rect.bottomLeft.x < (canvasSizeWidth - canvasSizeWidth/arrayOfBlocks.count) {
                arrayOfBlocks[0].velocity = arrayOfBlocks[0].defaultVelocity
            }
        }
    }

    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        if code == "KeyQ" {
        }
        
        if code == "KeyW" {
        }
        
        if code == "KeyE" {
        }
        
        if code == "KeyR" {
        }

    }

    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
}
