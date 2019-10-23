import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBAction func goPressed(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "countSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "countSegue" {
            let display = segue.destination as! ViewController
            display.getString = textField.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            display.getChannelnfo()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
