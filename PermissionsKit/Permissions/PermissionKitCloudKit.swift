import CloudKit

public final class PermissionKitCloudKit: PermissionKitBase {

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitCloudKit: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitCloudKit"
    }

    public func status(completion: @escaping PermissionKitResponse) {

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

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        CKContainer.default().accountStatus { (accountStatus, error) in

            if let error = error {
                print("[PermissionKit.CloudKit] ☁️ accountStatus not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            switch accountStatus {
                case .available, .restricted:
                    CKContainer.default().requestApplicationPermission(.userDiscoverability, completionHandler: { status, error in
                        if let error = error {
                            print("[PermissionKit.CloudKit] ☁️ discoverability not determined 🤔 error: \(error)")
                            return completion(.notDetermined)
                        }

                        switch status {
                            case .denied:
                                print("[PermissionKit.CloudKit] ☁️ discoverability denied by user ⛔️")
                                return completion(.denied)

                            case .granted:
                                print("[PermissionKit.CloudKit] ☁️ discoverability permission authorized by user ✅")
                                return completion(.authorized)

                            case .couldNotComplete, .initialState:
                                print("[PermissionKit.CloudKit] ☁️ discoverability permission not determined 🤔")
                                return completion(.notDetermined)
                        }
                    })

                case .noAccount:
                    print("[PermissionKit.CloudKit] ☁️ account not configured ⛔️")
                    return completion(.denied)

                case .couldNotDetermine:
                    print("[PermissionKit.CloudKit] ☁️ account not determined 🤔")
                    return completion(.notDetermined)
            }
        }

    }

}
