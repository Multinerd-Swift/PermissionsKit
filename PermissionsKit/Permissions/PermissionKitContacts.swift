import Contacts

@available(iOS 9.0, *)
public final class PermissionKitContacts: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

@available(iOS 9.0, *)
extension PermissionKitContacts: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitContacts"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        switch CNContactStore.authorizationStatus(for: .contacts) {
            case .authorized: return completion(.authorized)
            case .denied, .restricted: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        CNContactStore().requestAccess(for: .contacts, completionHandler: { granted, error in

            if let error = error {
                print("[PermissionKit.Contacts] 🎫 not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionKit.Contacts] 🎫 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.Contacts] 🎫 denied by user ⛔️")
            return completion(.denied)
        })
    }

}
