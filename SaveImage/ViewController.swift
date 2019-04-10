import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let first_user = User.create()
//        first_user.name = "name"
//        first_user.image = UIImage(named: "colorless_star_icon.png")
//        first_user.save()
//
//        let second_user = User.create()
//        second_user.name = "name"
//        second_user.image = UIImage(named: "yellow_star_icon.png")
//        second_user.save()
        
        
        
        let users = User.loadAll()
        for (i, user) in users.enumerated() {
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: CGFloat(100*i), width: 100, height: 100)
            imageView.image = user.image
            self.view.addSubview(imageView)
        }
    }
}

