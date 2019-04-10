//https://qiita.com/happy_ryo/items/72b68859ed8ace9f5fb4


import UIKit
import RealmSwift

class User: Object {
    static let realm = try! Realm()
    
    @objc dynamic private var id = 0
    @objc dynamic var name = ""
    @objc dynamic private var _image: UIImage? = nil
    @objc dynamic var image: UIImage? {
        set{
            //newValueてのはセットされた値？
            self._image = newValue
            if let value = newValue {
                self.imageData = (value.pngData()! as NSData)
            }
        }
        get{
            if let image = self._image {
                return image
            }
            if let data = self.imageData {
                //ここで変換かましてる
                self._image = UIImage(data: data as Data)
                return self._image
            }
            return nil
        }
    }
    @objc dynamic private var imageData: NSData? = nil
    
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
    
    //id順に並び替えてUserインスタンスをUser配列に突っ込み、その配列を返してる
    static func loadAll() -> [User] {
        let users = realm.objects(User.self).sorted(byKeyPath: "id")
        var ret: [User] = []
        for user in users {
            ret.append(user)
        }
        return ret
    }
    
    static func lastId() -> Int {
        if let user = realm.objects(User.self).last {
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
