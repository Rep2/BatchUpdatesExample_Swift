import SnapKit

class LabelCell: UITableViewCell, Identifiable {

    lazy var label: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black

        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.left.right.equalTo(contentView).inset(16)
            make.centerY.equalTo(contentView)
        }
    }

    func present(text: String) {
        label.text = text
    }

}
