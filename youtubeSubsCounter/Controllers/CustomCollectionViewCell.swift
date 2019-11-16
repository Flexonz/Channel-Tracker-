import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var channelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backImage.layer.borderColor = UIColor.black.cgColor
        backImage.layer.borderWidth = 5.0
        backImage.layer.cornerRadius = backImage.frame.size.height / 2
        avatarImage.layer.masksToBounds = true
        avatarImage.layer.borderWidth = 5.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.cornerRadius = avatarImage.frame.height / 2
        avatarImage.clipsToBounds = true
        backImage.clipsToBounds = true
        
    }
    
}

