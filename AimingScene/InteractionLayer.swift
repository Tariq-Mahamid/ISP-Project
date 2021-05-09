import Scenes
import Igis
  /*
     This class is responsible for the interaction Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class InteractionLayer : Layer {

    let projectile = Projectile()
    let player = Player()
    let target = Target()
    let background = Background()
    var canvasWidth = 2000
    var canvasHeight = 1000
    var score = 0

    var targetContainmentWidthLeft = 150
    var targetContainmentWidthRight = 150
    var targetContainmentHeightUp = 200
    var targetContainmentHeightDown = 600

    
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Interaction")


        // We insert our RenderableEntities in the constructor
        insert(entity:background, at:.front)
        insert(entity:projectile, at:.front)
        insert(entity:player, at:.front)
        insert(entity:target, at:.front)
    }

    override func preSetup(canvasSize: Size, canvas: Canvas) {
        canvasWidth = canvasSize.width
        canvasHeight = canvasSize.height

        targetContainmentWidthRight = canvasWidth - 150
        targetContainmentHeightDown = canvasHeight - 600

        randomizeTargetLocation()
        returnProjectileToPlayer()
    }
    
    override func postCalculate(canvas: Canvas) {
        if projectile.ellipse.center.y - 25 < 0 {
            returnProjectileToPlayer()
            projectile.velocityY = 0
            projectile.velocity = player.velocity
        }
        background.score = score

        if (checkContainment()) {
            randomizeTargetLocation()
            score += 1
            projectile.velocityY = 0
            returnProjectileToPlayer()
        }
    }

    func checkContainment() -> Bool {
        let projectileBoundingRect = projectile.boundingRect()
        let targetBoundingRect = target.boundingRect()
        let containment = projectileBoundingRect.containment(target: targetBoundingRect)
        return containment.contains(.overlapsBottom) && !containment.contains(.beyondHorizontally)
    }
    
    func randomizeTargetLocation() {
        let randomX = Int.random(in: targetContainmentWidthLeft...targetContainmentWidthRight)
        let randomY = Int.random(in: targetContainmentHeightUp...targetContainmentHeightDown)
        target.targetEllipse.center = Point(x: randomX, y: randomY)
    }

    func returnProjectileToPlayer() {
        projectile.ellipse.center = player.player.rect.topRight
        projectile.velocityY = 0
    }
}
