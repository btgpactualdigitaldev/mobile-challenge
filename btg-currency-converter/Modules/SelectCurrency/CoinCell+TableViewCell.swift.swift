//
//  CoinCell+TableViewCell.swift.swift
//  btg-currency-converter
//
//  Created by Paulo Cremonine on 23/11/20.
//

import SnapKit

protocol CoinCellDelegate {
    func didUnselect(source: String)
}

class CoinCell: UITableViewCell {
    
    var delegate : CoinCellDelegate?
    
    var data: SelectCurrencyViewModel? {
        didSet {
            guard let data = data else { return }
            self.currenciesCodeLabel.text = data.source
            self.currenciesDescriptionLabel.text = data.description
            self.icon.isHidden = true
        }
    }
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SF_checkmark_circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let currenciesCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let currenciesDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear

        contentView.addSubview(icon)
        contentView.addSubview(currenciesCodeLabel)
        contentView.addSubview(currenciesDescriptionLabel)

        icon.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10.0)
            make.width.height.equalTo(20.0)
            make.centerY.equalToSuperview()
        }
        
        currenciesCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(10.0)
            make.centerY.equalToSuperview()
        }
        
        currenciesDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(currenciesCodeLabel.snp.right).offset(10.0)
            make.centerY.equalToSuperview()
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didReveal(tapGestureRecognizer:)))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc
    func didReveal(tapGestureRecognizer: UITapGestureRecognizer)
    {
        delegate?.didUnselect(source: data!.source)
        self.icon.isHidden = false
    }

}
