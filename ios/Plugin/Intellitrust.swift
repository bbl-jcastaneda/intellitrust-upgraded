import Foundation

@objc public class Intellitrust: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
//    @objc func loadIdentity() -> ETIdentity? {
//        if FileManager.default.fileExists(atPath: getIdentityFileName()){
//            return nil
//        }
//        if let encrypted = NSData(contentsOf: URL(fileURLWithPath: getIdentityFileName())){
//            if let serialized =  ETSoftTokenSDK.decryptData(encrypted as Data){
//                do{
//                    let decodedObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: ETIdentity.self,from: serialized)
//                    return decodedObject
//                }catch{
//                    print("Error Unarchiving Object")
//                }
//            }
//        }
//        return nil
//    }
//    @objc func saveIdentity(_ identity: ETIdentity)->Bool{
//        do{
//            let serialized =  try NSKeyedArchiver.archivedData(withRootObject: identity, requiringSecureCoding: true)
//            let encrypted = ETSoftTokenSDK.encryptData(serialized)
//            try encrypted?.write(to: URL(fileURLWithPath:getIdentityFileName()))
//            return true
//        }catch{
//            print("Error Saving Identity")
//            return false
//        }
//    }
//    @objc func deleteIdentityFile()->Bool{
//        if FileManager.default.fileExists(atPath: getIdentityFileName()){
//            do{
//                try FileManager.default.removeItem(atPath: getIdentityFileName())
//                return true
//            } catch{
//                return false
//            }
//        }
//        return false
//    }
//    
//    @objc func getIdentityFileName() ->String{
//        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
//        let documentsDirectory = paths[0]
//        let DataFileName = (documentsDirectory as NSString).appendingPathComponent(fileName)
//        return dataFileName
//    }
    
}
