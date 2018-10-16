
import Foundation

protocol CellType
{
    associatedtype T
    static func identifier()->String
    func configure(cellModel: T)
}
