

import Foundation

func _22_NestedTypes()
{
    
    struct BlackjackCard {

        // nested Suit enumeration
        enum Suit: Character {
            case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
        }

        // nested Rank enumeration
        enum Rank: Int {
            case two = 2, three, four, five, six, seven, eight, nine, ten
            case jack, queen, king, ace
            struct Values {
                let first: Int, second: Int?
            }
            var values: Values {
                switch self {
                case .ace:
                    return Values(first: 1, second: 11)
                case .jack, .queen, .king:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
                }
            }
        }

        // BlackjackCard properties and methods
        let rank: Rank, suit: Suit
        var description: String {
            var output = "suit is \(suit.rawValue),"
            output += " value is \(rank.values.first)"
            if let second = rank.values.second {
                output += " or \(second)"
            }
            return output
        }
    }
    
    let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
    print("theAceOfSpades: \(theAceOfSpades.description)")
    // Prints "theAceOfSpades: suit is ♠, value is 1 or 11"
    
    //Even though Rank and Suit are nested within BlackjackCard, their type can be inferred from context,
    //and so the initialization of this instance is able to refer to the enumeration cases by their case names (.ace and .spades) alone.
    //In the example above, the description property correctly reports that the Ace of Spades has a value of 1 or 11.
    

    // To use a nested type outside of its definition context, prefix its name with the name of the type it’s nested within:
    

    let heartsSymbol = BlackjackCard.Suit.hearts.rawValue

    
}
