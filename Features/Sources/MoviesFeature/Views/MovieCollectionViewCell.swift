import UIKit
import DesignSystem


final class MovieCollectionViewCell: UICollectionViewCell {
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
    label.numberOfLines = 2
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = UIColor.label
    return label
  }()
  
  lazy var yearLabel: UILabel = {
    let label = UILabel()
    label.text = "2023"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.secondaryLabel
    return label
  }()
  
  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupConstraints()
  }
  
  private func setupConstraints() {
    contentView.add(subviews: [imageView, titleLabel, yearLabel])
    imageView
      .size(width: 80, height: 100)
      .edges(
        top: contentView.topAnchor,
        leading: contentView.leadingAnchor,
        insets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 0)
      )
    titleLabel
      .top(to: imageView)
      .leading(with: imageView.trailingAnchor, value: 10)
      .trailing(to: contentView, value: -8)
    yearLabel
      .leading(to: titleLabel)
      .top(with: titleLabel.bottomAnchor, value: 8)
      .trailing(to: titleLabel)
  }
  
}
