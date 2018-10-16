
import Foundation

protocol CellViewType
{
    associatedtype T
    func configure(cellModel: T)
}
