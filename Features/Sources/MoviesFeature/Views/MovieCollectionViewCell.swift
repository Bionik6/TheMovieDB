import UIKit
import DesignSystem


final class MovieCollectionViewCell: UICollectionViewCell {
  static let resuableIdentifier = "movie-cell-reuse-identifier"
  
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Lorem Ipsum Dolor sit amit"
    label.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: .current)
    label.textColor = UIColor.label
    return label
  }()
  
  lazy var yearLabel: UILabel = {
    let label = UILabel()
    label.text = "2023"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline, compatibleWith: .current)
    label.textColor = UIColor.secondaryLabel
    return label
  }()
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupConstraints()
  }
  
  private func setupViews() {
    
  }
  
  private func setupConstraints() {
    contentView.add(subviews: [imageView, titleLabel, yearLabel])
    imageView
      .size(width: 80, height: 100)
      .edges(
        top: contentView.topAnchor,
        leading: contentView.leadingAnchor,
        bottom: contentView.bottomAnchor,
        insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0)
      )
    titleLabel
      .leading(with: imageView.trailingAnchor, value: 10)
      .trailing(to: contentView, value: -8)
    yearLabel
      .leading(to: titleLabel)
      .bottom(with: titleLabel.bottomAnchor, value: 8)
      .trailing(to: titleLabel)
  }
    
}
