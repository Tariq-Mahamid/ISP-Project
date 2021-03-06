import Igis
import Scenes

public enum PlayerMoveType {
    case normal, rasenshuriken, clone, stun
}

public class PlayerMove {
    private let moveName : String
    private let damage : Int
    private let moveType : PlayerMoveType
    private let totalChakra : Int
    private var currentChakra : Int;
    
    init(name: String, damage: Int, moveType: PlayerMoveType, totalChakra: Int){
        moveName = name
        self.damage = damage
        self.moveType = moveType
        self.totalChakra = totalChakra
        currentChakra = totalChakra
    }
    
    public func getName() -> String {
        return moveName
    }

    public func getDamage() -> Int {
        if (moveType == PlayerMoveType.clone) {return getCloneAttackDamage()}
        else if (moveType == PlayerMoveType.rasenshuriken) {return getRasenShuriken()}
        else if (moveType == PlayerMoveType.stun) {return 0}
        return calculateCritical()
    }

    public func calculateCritical() -> Int{
        return Int(Double(10) * Double.random(in: 1...1.5))
    }
    
    private func getCloneAttackDamage() -> Int {
        let numberOfMoves = Int.random(in: 0...3)
        
        return damage * numberOfMoves
    }

    private func getRasenShuriken() -> Int{
        let didWork = Int.random(in: 0...2)

        if (didWork == 0) {return self.damage}
        return 0
    }
    
    public func checkForStun() -> Bool {
        if (moveType == PlayerMoveType.stun){
            return Bool.random()
        }

        return false
    }
    
    public func getMoveType() -> PlayerMoveType {
        return moveType
    }
    
    public func getMoveColor() -> Color {
        switch moveType {
        case PlayerMoveType.normal:
            return Color(.gray)
        case PlayerMoveType.rasenshuriken:
            return Color(.gold)
        case PlayerMoveType.clone:
            return Color(.lightblue)
        case PlayerMoveType.stun:
            return Color(.pink)
        }
    }

    public func getTotalChakraAmount() -> Int {
        return totalChakra
    }

    public func subtractChakra() {
        currentChakra = currentChakra > 0 ? currentChakra - 1 : currentChakra
        print(currentChakra)
    }
    
    public func getCurrentChakra() -> Int {
        return currentChakra
    }
    
    public func canAttack() -> Bool {
        return currentChakra > 0
    }
}
