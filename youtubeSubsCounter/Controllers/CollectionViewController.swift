import UIKit
import AlamofireImage

class CollectionViewController: UICollectionViewController {
    
    var channelsSaved = [Channel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! CustomCollectionViewCell
        
        if let name = channelsSaved[indexPath.row].name {
            cell.channelName.text = name
        } else {
            cell.channelName.text = "Error!"
        }
        
        if let logoImage = channelsSaved[indexPath.row].avatarImage {
            cell.avatarImage.image = logoImage
        } else {
            cell.avatarImage.image = Image(named: "defaultLogo")
        }
        
        if let backImage = channelsSaved[indexPath.row].backImage {
            cell.backImage.image = backImage
        } else {
            cell.backImage.image = Image(named: "defaultBack")
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channelsSaved.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        //Fade-out
                        cell?.alpha = 0.5
        }) { (completed) in
            UIView.animate(withDuration: 0.2,
                           animations: {
                            //Fade-out
                            cell?.alpha = 1
            })
        }
        // perfrom segue for special cell
    }
}

