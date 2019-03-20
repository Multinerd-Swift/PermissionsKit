import EventKit

public final class PermissionsKitEvents: PermissionsKitBase {

    public var identifier: String = "PermissionsKitEvents"
    
    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitEvents: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
            case .authorized: return completion(.authorized)
            case .restricted, .denied: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        EKEventStore().requestAccess(to: .event) { granted, error in

            if let error = error {
                print("[PermissionsKit.Events] 📆 permission not determined 🤔, error \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionsKit.Events] 📆 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Events] 📆 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
