import HealthKit

public final class PermissionKitHealth: PermissionKitBase {

    public var hkObjectType: HKObjectType?
    public var hkSampleTypesToShare: Set<HKSampleType>?
    public var hkSampleTypesToRead: Set<HKSampleType>?

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitHealth: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitHealth"
    }

    public func status(completion: @escaping PermissionKitResponse) {

        guard let objectType = self.hkObjectType else {
            return completion(.notDetermined)
        }

        switch HKHealthStore().authorizationStatus(for: objectType) {
            case .notDetermined: return completion(.notDetermined)
            case .sharingDenied: return completion(.denied)
            case .sharingAuthorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        if self.hkSampleTypesToRead == nil && self.hkSampleTypesToShare == nil {
            print("[PermissionKit.HealthKit] 📈 no permissions specified 🤔")
            return completion(.notDetermined)
        }

        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (granted, error) in

            if let error = error {
                print("[PermissionKit.HealthKit] 📈 permission not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionKit.HealthKit] 📈 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionKit.HealthKit] 📈 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
