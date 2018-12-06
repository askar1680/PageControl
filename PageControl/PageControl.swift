import UIKit

class CustomPageControl: UIView {
    
    private struct Constants {
        static let pageControlItemMaxWidth: CGFloat = 8.0
        static let constantHeight: CGFloat = 8.0
    }
    
    var currentPageIndicatorTintColor: UIColor = UIColor.white
    var pageIndicatorTintColor: UIColor = UIColor.lightGray
    
    var currentPage: Int = 0 {
        didSet{
            stackView.arrangedSubviews[currentPage].backgroundColor = currentPageIndicatorTintColor
        }
        willSet{
            stackView.arrangedSubviews[currentPage].backgroundColor = pageIndicatorTintColor
        }
    }
    
    var numberOfPages: Int = 0 {
        didSet{
            if numberOfPages <= 1 { return }
            let ratio = frame.width / CGFloat(numberOfPages)
            let width = min(Constants.pageControlItemMaxWidth, ratio / 2)
            stackView.spacing = width
            for _ in 0..<numberOfPages{
                stackView.addArrangedSubview(createDotView(width: width))
            }
            if (numberOfPages > 0){
                stackView.arrangedSubviews[0].backgroundColor = currentPageIndicatorTintColor
            }
        }
    }
    
    private var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
        setupConstraints()
    }
    
    private func initViews(){
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        addSubview(stackView)
    }
    
    private func setupConstraints(){
        
        heightAnchor.constraint(equalToConstant: Constants.constantHeight)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func createDotView(width: CGFloat) -> UIView{
        let view = UIView()
        
        view.backgroundColor = pageIndicatorTintColor
        view.layer.cornerRadius = width / 2
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: width).isActive = true
        view.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        return view
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
