import UserNotifications

public final class PermissionsKitNotifications: PermissionsKitBase {

    public var identifier: String = "PermissionsKitNotifications"
    
    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

    private func registerForRemoteNotifications() {

        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

extension PermissionsKitNotifications: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            switch settings.authorizationStatus {
                case .notDetermined: return completion(.notDetermined)
                case .denied: return completion(.denied)
                case .authorized: return completion(.authorized)
                case .provisional: return completion(.authorized)
            }
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        UNUserNotificationCenter.current().requestAuthorization(options: [ .alert, .badge, .sound ]) { (granted, error) in

            if let error = error {
                print("[PermissionsKit.Notifications] Push notifications permission not determined 🤔, error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                self.registerForRemoteNotifications()
                print("[PermissionsKit.Notifications] Push notifications permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.Notifications] Push notifications permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
