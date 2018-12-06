import UIKit

protocol RegisterableCellProtocol: AnyObject {
    static var identifier: String { get }
    static var nibName: String { get }
}

extension RegisterableCellProtocol where Self: UICollectionViewCell{
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
    func register<T: UICollectionViewCell>(_: T.Type) where T: RegisterableCellProtocol{
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: RegisterableCellProtocol{
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Can not dequeue \(T.self) with identifier \(T.identifier)")
        }
        return cell
    }
}
