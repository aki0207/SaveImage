import UIKit
import RealmSwift

class Diary: Object {
    static let realm = try! Realm()
    
    dynamic private var id = 0
    dynamic var name = ""
    dynamic private var _image: UIImage? = nil
    dynamic var image: UIImage? {
        set{
            self._image = newValue
            if let value = newValue {
                self.imageData = UIImagePNGRepresentation(value)
            }
        }
        get{
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                self._image = UIImage(data: data)
                return self._image
            }
            return nil
        }
    }
    dynamic private var imageData: NSData? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["image", "_image"]
    }
    
    static func create() -> User {
        let user = User()
        user.id = lastId()
        return user
    }
    
    static func loadAll() -> [User] {
        let users = realm.objects(User).sorted("id", ascending: false)
        var ret: [User] = []
        for user in users {
            ret.append(user)
        }
        return ret
    }
    
    static func lastId() -> Int {
        if let user = realm.objects(User).last {
            return user.id + 1
        } else {
            return 1
        }
    }
    
    func save() {
        try! User.realm.write {
            User.realm.add(self)
        }
    }
}
