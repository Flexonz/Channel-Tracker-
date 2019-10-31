import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AddingViewController: UIViewController {
    
    var channelID : String? {                           // = ChannelID FROM USER INPUT
        didSet {
            count = 0
        }
    }
    var channel = Channel()                             // = Empty channel
    var count = 0                                       // = Requests count
    var funcError: Error?                               // = Requst error
    let key = "AIzaSyBg1pN6rvnV7OyfHDg0Yq40k8JjAV5AJ2M" // = API KEY
    
    let imageCache = AutoPurgingImageCache()            // = IMAGE CACHE
    
    @IBOutlet weak var textField: UITextField!          // = ID INPUT
    
    @IBAction func goPressed(_ sender: UIButton) {
        
        channelID = textField.text
        
        getBackgroundImage { (error) in
            print("Background image downloaded")
            self.completionCheck(error: error)
        }
        getSubsCount { (error) in
            print("Subscribers count downloaded")
            self.completionCheck(error: error)
        }
        getAvatarImage { (error) in
            print("Avatar Image downloaded")
            self.completionCheck(error: error)
        }
        
    }
    
    func completionCheck(error: Error?) {
        
        if error == nil {
            count += 1
        } else {
            funcError = error
            print("API ERROR!")
        }
        
        if count == 3 {          // WHEN ALL REQUESTS DONE
            
            count = 0
            //BACK TO COLLECTION VIEW
            if let collectionVC  = self.navigationController?.viewControllers[0] as? CollectionViewController {
                
                collectionVC.channelsSaved.append(channel)
                _ =  self.navigationController?.popToViewController(collectionVC, animated: true)
                collectionVC.collectionView.reloadData()
            }
        }
        
        funcError = nil
        
    }
    
    
    //MARK: GET SUBSCRIBERS
    
    func getSubsCount(complition: @escaping (Error?) -> () ) {
        
        let link =
        "https://www.googleapis.com/youtube/v3/channels?part=statistics&id=\(channelID!)&key=\(key)"
        
        request(link).responseJSON { (response) in
            switch response.result {
            //success
            case .success(let value):
                let json = JSON(value)
                self.channel.subscribers = json["items"][0]["statistics"]["subscriberCount"].stringValue
                
                complition(nil)
            //error
            case .failure(let error):
                print (error)
                
                complition(error)
            }
        }
    }
    
    //MARK: GET BACKGROUND IMAGE
    
    func getBackgroundImage(complition: @escaping (Error?) -> () ) {
        
        var backgroundImageLink = String() //BACKGROUND LINK
        
        let link =
        "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings&id=\(channelID!)&key=\(key)"
        
        request(link).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                backgroundImageLink = json["items"][0]["brandingSettings"]["image"]["bannerImageUrl"].stringValue
                
                self.channel.name = json["items"][0]["brandingSettings"]["channel"]["title"].stringValue
                //if success then download the image using backgroundImageLink
                
                request(backgroundImageLink).responseImage { (response) in
                    if let image = response.result.value {
                        self.imageCache.add(image, withIdentifier: "background")
                        self.channel.backImage = image
                        
                        complition(nil)
                    }
                }
            case .failure(let error):
                print (error)
                
                complition(error)
            }
        }
    }
    
    //MARK: GET AVATAR IMAGE. WORK SAME AS getBackgroundImage()
    
    func getAvatarImage(complition: @escaping (Error?) -> () ) {
        
        var avatarImageLink = String()     //AVATAR LINK
        
        let link =
        "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=\(channelID!)&key=\(key)"
        
        request(link).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                avatarImageLink = json["items"][0]["snippet"]["thumbnails"]["medium"]["url"].stringValue
                
                request(avatarImageLink).responseImage { (response) in
                    if let image = response.result.value {
                        self.imageCache.add(image, withIdentifier: "avatar")
                        self.channel.avatarImage = image
                        
                        complition(nil)
                    }
                }
            case .failure(let error):
                print (error)
                
                complition(error)
            }
        }
    }
}

