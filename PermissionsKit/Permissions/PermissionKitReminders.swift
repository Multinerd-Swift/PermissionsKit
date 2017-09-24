import EventKit

public final class PermissionKitReminders: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitReminders: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitReminders"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
            case .authorized: return completion(.authorized)
            case .restricted, .denied: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        EKEventStore().requestAccess(to: .reminder) { granted, error in

            if let error = error {
                print("[PermissionKit.Reminders] 🎗 permission error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionKit.Reminders] 🎗 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.Reminders] 🎗 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
