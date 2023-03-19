import UIKit
import DesignSystem


final class MovieDetailsView: NiblessView {
  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    return imageView
  }()
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textColor = UIColor.label
    return label
  }()
  
  lazy var yearLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.secondaryLabel
    return label
  }()
  
  lazy var descriptionLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = UIColor.label
    return label
  }()
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    setupConstraints()
  }
  
  private func setupConstraints() {
    add(subviews: [imageView, titleLabel, yearLabel, descriptionLabel])
    imageView
      .size(width: 180, height: 220)
      .centerX(to: self)
      .top(with: safeAreaLayoutGuide.topAnchor, value: 16)
    titleLabel
      .top(with: imageView.bottomAnchor, value: 10)
      .leading(with: self.leadingAnchor, value: 10)
      .trailing(to: self, value: -8)
    yearLabel
      .leading(to: titleLabel)
      .top(with: titleLabel.bottomAnchor, value: 8)
      .trailing(to: titleLabel)
    descriptionLabel
      .leading(to: yearLabel)
      .top(with: yearLabel.bottomAnchor, value: 8)
      .trailing(to: yearLabel)
  }
}
