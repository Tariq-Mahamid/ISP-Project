import Igis
import Scenes

class ForegroundLayerFS : Layer {

    let playerStatsSize = Size(width: 400, height: 250)
    let opponentStatsSize = Size(width: 400, height: 250)
    public let playerHealthBar : HealthBarFS
    public let opponentHealthBar : HealthBarFS
    let player : PlayerRenderFS
    let opponent : PlayerRenderFS
    let textDisplay = TextDisplayFS()
    let playerMoves : PlayerMovesFS
    let chakra = 100
    var playerStats : PlayerStatsFS
    var opponentStats : PlayerStatsFS
    let cloneAttackDamage = 10
    public var enemyStunMoves = 0
    public var currentCloneAttackMoves = 0
    public var gameOver = false
    let gameOverScreen = GameoverScreenFS()

    init() {
        playerMoves = PlayerMovesFS()
        playerStats = PlayerStatsFS(size: playerStatsSize, isOpponent: false)
        opponentStats = PlayerStatsFS(size: opponentStatsSize, isOpponent: true)
        playerHealthBar = HealthBarFS(playerStatsSize: playerStatsSize, isOpponent: false)
        opponentHealthBar = HealthBarFS(playerStatsSize: opponentStatsSize, isOpponent: true)
        
        player = PlayerRenderFS(playerImageString: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/Punch1.png?raw=true", isOpponent: true)
        opponent = PlayerRenderFS(playerImageString: "https://github.com/Tariq-Mahamid/ISP-Project/blob/master/Images/MrBen.jpeg?raw=true", isOpponent: false)
        
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Foreground")

        // We insert our RenderableEntities in the constructor
        insert(entity: BackgroundFS(), at: .back)
        insert(entity: playerStats, at: .front)
        insert(entity: opponentStats, at: .front)
        insert(entity: playerHealthBar, at: .front)
        insert(entity: opponentHealthBar, at: .front)
        insert(entity: playerMoves, at: .front)
        insert(entity: player, at: .front)
        insert(entity: opponent, at: .front)
        insert(entity: textDisplay, at: .front)
        insert(entity: gameOverScreen, at: .front)
    }
    
    override func preCalculate(canvas: Canvas) {
        if (playerMoves.shouldInitiateAttackSequence){
            initiateAttackSequence()
            playerMoves.shouldInitiateAttackSequence = false
        }
    }
    
    
    public func initiateAttackSequence() {
        if (gameOver) {return}
        
        let playerMove = playerMoves.currentPlayerMoveRectangle.playerMove
        if (!playerMove.canAttack()) {return}

        let damage = playerMove.getDamage()

        player.initiateAnimation()
        opponent.initiateAnimation()
        
        if (playerMove.getMoveType() == PlayerMoveType.clone) {
            currentCloneAttackMoves = damage / cloneAttackDamage
            
            textDisplay.showCloneText = true
        }
        else {
            textDisplay.showCloneText = false
        }
        let opponentDamage = isStunned() ? 0 : 20
        
        subtractHealth(amount: damage, healthBar: opponentHealthBar)
        subtractHealth(amount: opponentDamage, healthBar: playerHealthBar)
         
        playerStats.displaySubtractedHealth(amount: opponentDamage)
        opponentStats.displaySubtractedHealth(amount: damage)
        
        playerMove.subtractChakra()
    }    

    public func isStunned() -> Bool{
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
    
    public func subtractHealth(amount: Int, healthBar: HealthBarFS){
        if (healthBar.curHealth - amount > 0) {
            healthBar.subtractHealth(amount)
        } else {
            healthBar.subtractHealth(healthBar.curHealth)
            initiateGameOverSequence(didPlayerWin: healthBar == opponentHealthBar)
        }
    }

    public func initiateGameOverSequence(didPlayerWin : Bool) {
        gameOver = true
        gameOverScreen.currentWinner = didPlayerWin ? GameWinner.player : GameWinner.enemy
    }
}
