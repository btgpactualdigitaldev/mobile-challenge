
import UIKit

final class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cellViewUnder: UIView!
    @IBOutlet var cellViewAbove: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(currency: Currency) {
        nameLabel.text = currency.name
        descriptionLabel.text = currency.description
    }
    
    private func cellSetup() {
        cellViewUnder.layer.shadowColor = UIColor.black.cgColor
        cellViewUnder.layer.shadowOpacity = 0.4
        cellViewUnder.layer.shadowOffset = .zero
        cellViewUnder.layer.shadowRadius = 5.0
        cellViewUnder.layer.shouldRasterize = true
        
        cellViewAbove.layer.cornerRadius = 8.0
        cellViewAbove.layer.masksToBounds = true
        
    }
}
