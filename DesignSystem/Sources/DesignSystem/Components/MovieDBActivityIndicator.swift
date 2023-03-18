import UIKit


public final class MovieDBActivityIndicator: UIView {
  
  private var width: CGFloat = 40
  private var height: CGFloat = 20
  private let numberOfDots: Double = 3
  private var dotsColor: UIColor = .white
  private let animationDuration: Double = 0.9
  private(set) var dotDiameter: CGFloat = 10
  
  private static var indicatorContainer: UIView?
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.width = frame.width
    self.height = frame.height
    self.setupViews(dotsColor: dotsColor)
  }
  
  public convenience init(dotsColor: UIColor = .white) {
    self.init()
    self.dotsColor = dotsColor
  }
  
  public convenience init(){
    self.init(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 20)))
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setupViews(dotsColor: dotsColor)
  }
  
  public func startAnimating() {
    self.isHidden = false
    for i in 0..<Int(numberOfDots) {
      self.subviews[i].alpha = 1
      self.subviews[i].backgroundColor = self.dotsColor
      animateWithKeyframes(dotToAnimate: self.subviews[i], delay: (Double(i) * animationDuration / numberOfDots))
    }
  }
  
  public func stopAnimating() {
    self.isHidden = true
    self.subviews.forEach { $0.layer.removeAllAnimations() }
  }
  
  private func setupViews(dotsColor: UIColor) {
    self.isHidden = true
    self.backgroundColor = UIColor(white: 1, alpha: 0)
    self.size(width: self.width, height: self.height)
    
    for index in 0..<Int(numberOfDots) {
      let dot = UIView()
      dot.layer.cornerRadius = dotDiameter / 2
      dot.backgroundColor = dotsColor
      self.addSubview(dot)
      dot.size(width: dotDiameter, height: dotDiameter)
      switch index {
        case 1:
          dot.centerX(to: self).top(to: self)
        case 0, 2:
          dot.bottom(to: self)
          index == 0 ? (dot.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true ) :
          (dot.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true )
        default: break
      }
    }
  }
  
  private func animateWithKeyframes(dotToAnimate:UIView, delay:Double) {
    UIView.animateKeyframes(
      withDuration: animationDuration,
      delay: delay,
      options: [.repeat],
      animations: {
        UIView.addKeyframe(
          withRelativeStartTime: 0.0,
          relativeDuration: self.animationDuration / self.numberOfDots,
          animations: {
            dotToAnimate.transform = CGAffineTransform(scaleX: 0.8 , y: 0.8)
            dotToAnimate.alpha = 0.8
          })
        UIView.addKeyframe(
          withRelativeStartTime: self.animationDuration / self.numberOfDots,
          relativeDuration: Double(2) * self.animationDuration / self.numberOfDots,
          animations: {
            dotToAnimate.transform = CGAffineTransform.identity
            dotToAnimate.alpha = 0.5
          })
      }
    )
  }
  
  public static func showAdded(to view: UIView, title: String = "", message: String = "") {
    let indicator = MovieDBActivityIndicator(dotsColor: .lightGray)
    
    let indicatorTitleLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
      label.textColor = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.00)
      label.numberOfLines = 0
      label.textAlignment = .center
      return label
    }()
    
    let indicatorMessageLabel: UILabel = {
      let label = UILabel()
      label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
      label.textColor = UIColor(red: 0.20, green: 0.20, blue: 0.20, alpha: 1.00)
      label.numberOfLines = 0
      label.textAlignment = .center
      return label
    }()
    
    let stackView: UIStackView = {
      let stackView = UIStackView()
      stackView.axis = .vertical
      stackView.distribution = .equalSpacing
      stackView.alignment = .center
      stackView.spacing = 4
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.setContentHuggingPriority(.required , for: .horizontal)
      return stackView
    }()
    
    indicatorTitleLabel.text = title
    indicatorMessageLabel.text = message
    
    if indicatorContainer == nil { indicatorContainer = UIView() }
    if indicatorContainer?.superview != nil {
      DispatchQueue.main.async {
        removeDescendants()
        indicatorContainer?.removeFromSuperview()
      }
    }
    
    guard let container = indicatorContainer else { return }
    
    container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    [indicatorTitleLabel, indicatorMessageLabel].forEach {
      stackView.addArrangedSubview($0)
      $0.isHidden = ($0.text ?? "").count == 0
    }
    
    [stackView, indicator].forEach(container.addSubview)
    
    indicator
      .centerX(to: container)
      .top(to: container, value: title == "" && message == "" ? 8 :  24)
    stackView.top(with: indicator.bottomAnchor, value: 16 )
      .leading(to: container, value: 24)
      .trailing(to: container, value: -24)
      .bottom(to: container, value:  ( title == "" && message == "" ) ? 0 :  -24)
    stackView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
    
    view.addSubview(container)
    container
      .centerX(to: view)
      .centerY(to: view)
    container.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
    container.layer.cornerRadius = 8
    container.layer.masksToBounds = true
    
    view.isUserInteractionEnabled = false
    indicator.startAnimating()
  }
  
  private static func removeDescendants() {
    indicatorContainer?.subviews.forEach {
      if $0.isKind(of: MovieDBActivityIndicator.self) {
        ($0 as! MovieDBActivityIndicator).stopAnimating()
      }
      $0.removeFromSuperview()
    }
  }
  
  public static func hide(for view: UIView) {
    DispatchQueue.main.async {
      guard let container = indicatorContainer else { return }
      removeDescendants()
      container.removeFromSuperview()
      view.isUserInteractionEnabled = true
    }
  }
}
