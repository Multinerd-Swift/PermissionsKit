import CoreMotion

public final class PermissionsKitMotion: PermissionsKitBase {

    public var identifier: String = "PermissionsKitMotion"
    
    private let motionManager = CMMotionActivityManager()

    private lazy var motionHandlerQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Multinerd.PermissionsKit.MotionHandlerQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionsKitConfigurations? = nil, initialPopupData: PermissionsKitAlert? = nil, reEnablePopupData: PermissionsKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionsKitMotion: PermissionsKitProtocol {

    public func status(completion: @escaping PermissionsKitResponse) {

        if CMMotionActivityManager.isActivityAvailable() == false {
            return completion(.notAvailable)
        }

        self.motionManager.queryActivityStarting(from: Date(), to: Date(), to: motionHandlerQueue) { _, error in

            self.motionManager.stopActivityUpdates()

            if let error = error as NSError? {
                if [ Int(CMErrorMotionActivityNotAuthorized.rawValue), Int(CMErrorNotAuthorized.rawValue) ].contains(error.code) {
                    return completion(.denied)

                } else {
                    return completion(.notDetermined)
                }
            }

            return completion(.authorized)
        }
    }

    public func askForPermission(completion: @escaping PermissionsKitResponse) {

        if CMMotionActivityManager.isActivityAvailable() == false {
            return completion(.notAvailable)
        }

        motionManager.queryActivityStarting(from: Date(), to: Date(), to: motionHandlerQueue) { _, error in

            self.motionManager.stopActivityUpdates()

            if let error = error as NSError? {
                if [ Int(CMErrorMotionActivityNotAuthorized.rawValue), Int(CMErrorNotAuthorized.rawValue) ].contains(error.code) {
                    print("[PermissionsKit.Motion] 🏃🏻 permission denied by user ⛔️")
                    return completion(.denied)

                } else {
                    print("[PermissionsKit.Motion] 🏃🏻 permission not determined 🤔")
                    return completion(.notDetermined)
                }
            }

            print("[PermissionsKit.Motion] 🏃🏻 permission authorized by user ✅")
            return completion(.authorized)
        }
    }

}
