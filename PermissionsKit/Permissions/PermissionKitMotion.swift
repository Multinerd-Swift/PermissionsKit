import CoreMotion

public final class PermissionKitMotion: PermissionKitBase {

    private let motionManager = CMMotionActivityManager()

    private lazy var motionHandlerQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Multinerd.PermissionKit.MotionHandlerQueue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    public init() {

        super.init(identifier: self.identifier)
    }

    public override init(configuration: PermissionKitConfigurations? = nil, initialPopupData: PermissionKitAlert? = nil, reEnablePopupData: PermissionKitAlert? = nil) {

        super.init(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
    }

}

extension PermissionKitMotion: PermissionKitProtocol {

    public var identifier: String {
        return "PermissionKitMotion"
    }

    public func status(completion: @escaping PermissionKitResponse) {

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

    public func askForPermission(completion: @escaping PermissionKitResponse) {

        if CMMotionActivityManager.isActivityAvailable() == false {
            return completion(.notAvailable)
        }

        motionManager.queryActivityStarting(from: Date(), to: Date(), to: motionHandlerQueue) { _, error in

            self.motionManager.stopActivityUpdates()

            if let error = error as NSError? {
                if [ Int(CMErrorMotionActivityNotAuthorized.rawValue), Int(CMErrorNotAuthorized.rawValue) ].contains(error.code) {
                    print("[PermissionKit.Motion] 🏃🏻 permission denied by user ⛔️")
                    return completion(.denied)

                } else {
                    print("[PermissionKit.Motion] 🏃🏻 permission not determined 🤔")
                    return completion(.notDetermined)
                }
            }

            print("[PermissionKit.Motion] 🏃🏻 permission authorized by user ✅")
            return completion(.authorized)
        }
    }

}
