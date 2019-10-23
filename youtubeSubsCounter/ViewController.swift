import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var outPut: UILabel!
    
    var imageURL =
    "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings&id={CHANNEL-ID}&key={YOUR_API_KEY}"
    
    var getString : String? // = ChannelID in first viewController
    
    let key = "AIzaSyBg1pN6rvnV7OyfHDg0Yq40k8JjAV5AJ2M" // API KEY
    
    func getChannelnfo() {
        let link =
        "https://www.googleapis.com/youtube/v3/channels?part=statistics&id=\(getString!)&key=\(key)"
        request(link).responseJSON { (response) in
            print(link)
            switch response.result {
            //success
            case .success(let value):
                let json = JSON(value)
                self.outPut.text = Int.formatnumber(json["items"][0]["statistics"]["subscriberCount"].intValue)()
            //error
            case .failure(let error):
                print (error)
                self.outPut.text = "Error! Try again."
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//Subsribers count formatter

extension Int {
    func formatnumber() -> String {
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = .decimal
        return formater.string(from: NSNumber(value: self))!
    }
}

