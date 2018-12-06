import UIKit

class ViewController: UICollectionViewController {
    let colors = [UIColor.red, UIColor.orange, UIColor.purple, UIColor.green,
                  UIColor.red, UIColor.orange, UIColor.purple, UIColor.green,
                  UIColor.red, UIColor.orange, UIColor.purple, UIColor.green,
                  UIColor.red, UIColor.orange, UIColor.purple, UIColor.green,
                  UIColor.red, UIColor.orange, UIColor.purple, UIColor.green,
                  ]
    
    
    let customPageControl = CustomPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setupConstraints()
    }
    
    private func initViews(){
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(ColorCVCell.self)
        
    }
    
    private func setupConstraints(){
        view.addSubview(customPageControl)
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        customPageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        customPageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        customPageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        self.view.layoutIfNeeded()
        customPageControl.numberOfPages = colors.count
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        customPageControl.currentPage = currentPage
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorCVCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.backgroundColor = colors[indexPath.item].withAlphaComponent(0.5)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
