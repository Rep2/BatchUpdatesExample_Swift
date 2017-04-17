import SnapKit

class MovieCell: UITableViewCell, Identifiable {
    lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0

        return label
    }()

    lazy var yearLabel:  UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray

        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(yearLabel)

        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView).inset(16)
            make.height.equalTo(20)
        }

        yearLabel.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(20)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(contentView).inset(16)
            make.top.equalTo(yearLabel.snp.bottom).offset(8)
        }
    }

    func present(movie: MoviePresentable) {
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
        yearLabel.text = String(movie.releaseYear)
    }
}
