import CloudKit

public final class PermissionsKitCloudKit: PermissionsKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitCloudKit: PermissionsKitProtocol {

    public var identifier: String {
        return "PermissionsKitCloudKit"
    }

    public func status(completion: @escaping PermissionsKitResponse) {

        CKContainer.default().status(forApplicationPermission: .userDiscoverability, completionHandler: { status, error in

            if error != nil {
                return completion(.notDetermined)
            }

            switch status {
                case .granted: return completion(.authorized)
                case .denied: return completion(.denied)
                case .couldNotComplete: return completion(.notDetermined)
                case .initialState: return completion(.notDetermined)
            }
        })
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        CKContainer.default().accountStatus { (accountStatus, error) in

            if let error = error {
                print("[PermissionsKit.CloudKit] ☁️ accountStatus not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            switch accountStatus {
                case .available, .restricted:
                    CKContainer.default().requestApplicationPermission(.userDiscoverability, completionHandler: { status, error in
                        if let error = error {
                            print("[PermissionsKit.CloudKit] ☁️ discoverability not determined 🤔 error: \(error)")
                            return completion(.notDetermined)
                        }

                        switch status {
                            case .denied:
                                print("[PermissionsKit.CloudKit] ☁️ discoverability denied by user ⛔️")
                                return completion(.denied)

                            case .granted:
                                print("[PermissionsKit.CloudKit] ☁️ discoverability permission authorized by user ✅")
                                return completion(.authorized)

                            case .couldNotComplete, .initialState:
                                print("[PermissionsKit.CloudKit] ☁️ discoverability permission not determined 🤔")
                                return completion(.notDetermined)
                        }
                    })

                case .noAccount:
                    print("[PermissionsKit.CloudKit] ☁️ account not configured ⛔️")
                    return completion(.denied)

                case .couldNotDetermine:
                    print("[PermissionsKit.CloudKit] ☁️ account not determined 🤔")
                    return completion(.notDetermined)
            }
        }

    }

}
