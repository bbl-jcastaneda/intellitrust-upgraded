import Foundation
import Capacitor
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
let transactionURL = "https://belizebank.us.trustedauth.com/api/mobile"
//let fileName:NSString = "";
//let dataFileName:NSString = "";
@objc(IntellitrustPlugin)
public class IntellitrustPlugin: CAPPlugin {
    private let implementation = Intellitrust()

    @objc override public func load() {
            // Called when the plugin is first constructed in the bridge
        }
        let dataFileName = ""
        let fileName = ""
        @objc func echo(_ call: CAPPluginCall) {
            let value = call.getString("value") ?? ""
            call.resolve([
                "value": value
            ])
        }
        
        @objc func createNewSoftTokenIdentity(_ call: CAPPluginCall) {
            let serialNumber = call.getString("serialNumber") ?? ""
            let activationCode = call.getString("activationCode") ?? ""
            let deviceId = call.getString("deviceId") ?? ""
            let wasReset = ETSoftTokenSDK.initializeSDK()
            
            if wasReset {
                //Clean up any existing identities because we can't decrypt them
                _ = deleteIdentityFile()
            }
            ETSoftTokenSDK.setApplicationId("com.belizebank.mobile")
            ETSoftTokenSDK.setApplicationVersion("1.8.3")
            ETSoftTokenSDK.setApplicationScheme("belizebank")
            
            var pluginResult:CAPPluginCallResult? = nil
            
            //validate serial number
            do{
                try ETIdentityProvider.validateSerialNumber(serialNumber)
            }catch let error as NSError{
                 pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
            
            //validate activation Code
            do{
                try ETIdentityProvider.validateActivationCode(activationCode)
            }catch let error as NSError{
                pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
            
            do{
                //Create new Identity
                let identity =  ETIdentityProvider.generate(deviceId, serialNumber: serialNumber, activationCode: activationCode)
                let provider = ETIdentityProvider(urlString: transactionURL)
                
                let success = (try provider?.register(identity, deviceId: deviceId, transactions: true, onlineTransactions: true, offlineTransactions: true, notifications: true, callback: nil))!
                _ = saveIdentity(identity!)
                if success {
                    pluginResult = CAPPluginCallResult(["status": "OK", "message" : "Successfully Registered!"]) //need to validate if status returned is what is expected
                    call.resolve([
                        "sendPluginResult": pluginResult,
                        "callbackId": call.callbackId
                    ])
                }else{
                    call.resolve([
                        "sendPluginResult": pluginResult,
                        "callbackId": call.callbackId
                    ])
                }
                
            }catch let error as NSError{
                pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
            
            
            
        }
        @objc func getOTP(_ call: CAPPluginCall) {
            var pluginResult:CAPPluginCallResult
            do{
                let filename =  call.getString("fileName")
                let identity =  loadIdentity()
                
                let otp =  identity?.getOTP(Date())
                pluginResult = CAPPluginCallResult(["status": "OK", "data": ["otp":otp]])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }catch let error as NSError{
                pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
           
            
        }
        @objc func deleteIdentity(_ call: CAPPluginCall){
            var pluginResult:CAPPluginCallResult
            do{
                let filename =  call.getString("fileName")
                _=deleteIdentityFile()
                pluginResult = CAPPluginCallResult(["status": "OK", "message" : "Successfully Deleted!"])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }catch let error as NSError{
                pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
        }
        
        @objc func parseNotification(_ call:CAPPluginCall){
            var pluginResult:CAPPluginCallResult
            var isTransactionAuthenticated:Bool = false
            
            do{
                let filename =  call.getString("fileName")
                let identity =  loadIdentity()
                let txnid =  call.getString("txnid")
                let response =  call.getString("response")
                
                var error: Error?
                
                let txnResponse = ETTransaction.transactionResponse(from: response)
                
                let provider = ETIdentityProvider(urlString: transactionURL)
                let transaction = try provider?.poll(identity, callback: nil)
                var isTransactiomnAuthenticated =  false
                do{
                    try provider!.authenticateTransaction(transaction, for: identity, with: txnResponse, callback: nil)
                    isTransactionAuthenticated =  true
                }catch let error{
                    print("Error \(error)")
                }
                
                if isTransactionAuthenticated{
                    pluginResult = CAPPluginCallResult(["status": "OK", "message" : "true"])
                    call.resolve([
                        "sendPluginResult": pluginResult,
                        "callbackId": call.callbackId
                    ])
                }else{
                    pluginResult = CAPPluginCallResult(["status": "OK", "message" : "false"])
                    call.resolve([
                        "sendPluginResult": pluginResult,
                        "callbackId": call.callbackId
                    ])
                }

                
                
            }catch let error as NSError{
                pluginResult = CAPPluginCallResult(["status": error, "message": error.localizedDescription ])
                call.resolve([
                    "sendPluginResult": pluginResult,
                    "callbackId": call.callbackId
                ])
            }
        }
        
        @objc func loadIdentity() -> ETIdentity? {
            if FileManager.default.fileExists(atPath: getIdentityFileName()){
                return nil
            }
            if let encrypted = NSData(contentsOf: URL(fileURLWithPath: getIdentityFileName())){
                if let serialized =  ETSoftTokenSDK.decryptData(encrypted as Data){
                    do{
                        let decodedObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: ETIdentity.self,from: serialized)
                        return decodedObject
                    }catch{
                        print("Error Unarchiving Object")
                    }
                }
            }
            return nil
        }
        @objc func saveIdentity(_ identity: ETIdentity)->Bool{
            do{
                let serialized =  try NSKeyedArchiver.archivedData(withRootObject: identity, requiringSecureCoding: true)
                let encrypted = ETSoftTokenSDK.encryptData(serialized)
                try encrypted?.write(to: URL(fileURLWithPath:getIdentityFileName()))
                return true
            }catch{
                print("Error Saving Identity")
                return false
            }
        }
        @objc func deleteIdentityFile()->Bool{
            if FileManager.default.fileExists(atPath: getIdentityFileName()){
                do{
                    try FileManager.default.removeItem(atPath: getIdentityFileName())
                    return true
                } catch{
                    return false
                }
            }
            return false
        }
        
        @objc func getIdentityFileName() ->String{
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory = paths[0]
            let DataFileName = (documentsDirectory as NSString).appendingPathComponent(fileName)
            return dataFileName
        }
    
    
}
