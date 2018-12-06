import UIKit

protocol ReusableCell: AnyObject {
    static var identifier: String { get }
    static var nibName: String { get }
}

extension ReusableCell where Self: UICollectionViewCell{
    static var identifier: String {
        return NSStringFromClass(self)
    }
    static var nibName: String {
        var nibName = NSStringFromClass(self)
        nibName.append("!NibName")
        return nibName
    }
}

extension UICollectionView{
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableCell{
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableCell{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Can not dequeue \(T.self) with identifier \(T.identifier)")
        }
        return cell
    }
}
