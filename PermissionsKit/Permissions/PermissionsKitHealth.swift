import HealthKit

public final class PermissionsKitHealth: PermissionsKitBase {

    public var identifier: String = "PermissionsKitHealth"
    
    public var hkObjectType: HKObjectType?
    public var hkSampleTypesToShare: Set<HKSampleType>?
    public var hkSampleTypesToRead: Set<HKSampleType>?

    public init() {

        super.init(identifier: "PermissionsKitHealth")
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitHealth: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        guard let objectType = self.hkObjectType else {
            return completion(.notDetermined)
        }

        switch HKHealthStore().authorizationStatus(for: objectType) {
            case .notDetermined: return completion(.notDetermined)
            case .sharingDenied: return completion(.denied)
            case .sharingAuthorized: return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        if self.hkSampleTypesToRead == nil && self.hkSampleTypesToShare == nil {
            print("[PermissionsKit.HealthKit] 📈 no permissions specified 🤔")
            return completion(.notDetermined)
        }

        HKHealthStore().requestAuthorization(toShare: self.hkSampleTypesToShare, read: self.hkSampleTypesToRead) { (granted, error) in

            if let error = error {
                print("[PermissionsKit.HealthKit] 📈 permission not determined 🤔 error: \(error)")
                return completion(.notDetermined)
            }

            if granted {
                print("[PermissionsKit.HealthKit] 📈 permission authorized by user ✅")
                return completion(.authorized)
            }

            print("[PermissionsKit.HealthKit] 📈 permission denied by user ⛔️")
            return completion(.denied)
        }
    }

}
