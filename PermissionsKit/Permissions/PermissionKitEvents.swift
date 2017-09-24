import EventKit

public final class PermissionKitEvents: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitEvents: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitEvents"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
            case .authorized: return completion(.authorized)
            case .restricted, .denied: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        EKEventStore().requestAccess(to: .event) { granted, error in

            if let error = error {
                print("[PermissionKit.Events] 📆 permission not determined 🤔, error \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionKit.Events] 📆 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.Events] 📆 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
