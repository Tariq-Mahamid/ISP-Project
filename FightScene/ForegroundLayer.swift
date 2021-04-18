import Igis
import Scenes

class ForegroundLayer : Layer {

    let playerStatsSize = Size(width: 400, height: 250)
    let opponentStatsSize = Size(width: 400, height: 250)
    public let playerHealthBar : HealthBar
    public let opponentHealthBar : HealthBar
    let ground = Ground()    
    let playerMovesArray =  [PlayerMove(name: "Normal Attack", damage: 10, moveType: PlayerMoveType.normal),
                             PlayerMove(name: "Clone Attack", damage: 10, moveType: PlayerMoveType.clone),
                             PlayerMove(name: "Stun Attack", damage: 0, moveType: PlayerMoveType.stun),
                             PlayerMove(name: "Rasenshuriken", damage: 50, moveType: PlayerMoveType.rasenshuriken)]
    let playerMoves : PlayerMoves
    let playerStats : PlayerStats
    let opponentStats : PlayerStats
    private var enemyStunMoves = 0
    
    init() {
        playerStats = PlayerStats(size: playerStatsSize, isOpponent: false)
        opponentStats = PlayerStats(size: opponentStatsSize, isOpponent: true)
        playerHealthBar = HealthBar(playerStatsSize: playerStatsSize, isOpponent: false)
        opponentHealthBar = HealthBar(playerStatsSize: opponentStatsSize, isOpponent: true)
        playerMoves = PlayerMoves(playerMoves: playerMovesArray)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")

        // We insert our RenderableEntities in the constructor
        insert(entity: Background(), at: .back)
        insert(entity: playerStats, at: .front)
        insert(entity: opponentStats, at: .front)
        insert(entity: playerHealthBar, at: .front)
        insert(entity: opponentHealthBar, at: .front)
        insert(entity: ground, at: .front)
        insert(entity: playerMoves, at: .front)
    }

    override func preCalculate(canvas: Canvas) {
        if (playerMoves.shouldInitiateAttackSequence){
            initiateAttackSequence()
            playerMoves.shouldInitiateAttackSequence = false
        }
    }
    
    public func initiateAttackSequence() {
        let playerMove = playerMoves.currentPlayerMoveRectangle.playerMove
        let damage = playerMove.getDamage()
        let opponentDamage = isStunned() ? 0 : 10
        
        subtractHealth(amount: damage, healthBar: opponentHealthBar)
        subtractHealth(amount: opponentDamage, healthBar: playerHealthBar)
         
        playerStats.displaySubtractedHealth(amount: opponentDamage)
        opponentStats.displaySubtractedHealth(amount: damage)
    }    

    private func isStunned() -> Bool{
        let playerMove = playerMoves.currentPlayerMoveRectangle.playerMove
        let isStunned = playerMove.checkForStun()

        if (enemyStunMoves > 0){
            enemyStunMoves -= 1
            return true
        }
        
        if (isStunned) {
            enemyStunMoves = 1
            return true
        }

        return false
    }
    
    public func subtractHealth(amount: Int, healthBar: HealthBar){
        if (healthBar.curHealth - amount >= 0) {
            healthBar.subtractHealth(amount)
        } else {
            healthBar.subtractHealth(healthBar.curHealth)
            initiateGameOverSequence(didPlayerWin: healthBar == opponentHealthBar)
        }
    }

    public func initiateGameOverSequence(didPlayerWin : Bool) {
        if (didPlayerWin) {print("You win!")}
        else {print("You lose")}
    }
}
