import Contacts

@available(iOS 9.0, *)
public final class PermissionsKitContacts: PermissionsKitBase {

    public var identifier: String = "PermissionsKitContacts"
    
    public init() {

        super.init(identifier: "PermissionsKitContacts")
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

@available(iOS 9.0, *)
extension PermissionsKitContacts: PermissionsKitProtocol {


    public func status(completion: @escaping PermissionsKitResponse) {

        switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized: return completion(.authorized)
            case .denied, .restricted: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        CNContactStore().requestAccess(for: .contacts, completionHandler: { granted, error in

            if let error = error {
                print("[PermissionsKit.Contacts] 🎫 not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionsKit.Contacts] 🎫 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Contacts] 🎫 denied by user ⛔️")
            return completion(.denied)
        })
    }

}
