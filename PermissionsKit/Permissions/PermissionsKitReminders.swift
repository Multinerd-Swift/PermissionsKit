import EventKit

public final class PermissionsKitReminders: PermissionsKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitReminders: PermissionsKitProtocol {

    public var identifier: String {
        return "PermissionsKitReminders"
    }

    public func status(completion: @escaping PermissionsKitResponse) {

        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
            case .authorized: return completion(.authorized)
            case .restricted, .denied: return completion(.denied)
            case .notDetermined: return completion(.notDetermined)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        EKEventStore().requestAccess(to: .reminder) { granted, error in

            if let error = error {
                print("[PermissionsKit.Reminders] 🎗 permission error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionsKit.Reminders] 🎗 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Reminders] 🎗 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
