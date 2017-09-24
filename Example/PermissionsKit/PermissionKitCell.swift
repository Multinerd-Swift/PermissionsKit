import PermissionsKit
import UIKit

class PermissionsKitCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!

    var viewModel: PermissionsKitCellVM? {
        didSet {
            self.titleLbl.text = viewModel?.title

            self.viewModel?.permission.status(completion: { (status) in

                self.updateUI(status)

            })
        }
    }

    var clicked: Bool = false {
        didSet {
            if clicked, (viewModel?.permission != nil) {

                self.managePermission()

            }
        }
    }

    private func managePermission() {

        viewModel?.permission.manage(completion: { (status) in

            self.updateUI(status)

        })
    }

    private func updateUI(_ status: PermissionsKitStatus) {

        DispatchQueue.main.async {
            switch status {
                case .authorized:
                    self.statusLbl.text = "✅"
                case .denied:
                    self.statusLbl.text = "⛔️"
                case .notAvailable:
                    self.statusLbl.text = "📵"
                case .notDetermined:
                    self.statusLbl.text = "⁉️"
            }

            self.setSelected(false, animated: false)
        }
    }
}

class PermissionsKitCellVMServiceProgrammatically {

    static private var permissions = [ [ "label": "Bluetooth" ], [ "label": "Camera" ], [ "label": "CloudKit" ], [ "label": "Contacts" ], [ "label": "Events" ], [ "label": "Health" ], [ "label": "Media Library" ], [ "label": "Microphone" ], [ "label": "Motion" ], [ "label": "Notifications" ], [ "label": "Photos" ], [ "label": "Reminders" ], [ "label": "Speech" ], [ "label": "Location - Always" ], [ "label": "Location - When In Use" ] ]

    static var permissionCount: Int {
        return self.permissions.count
    }

    static func buildVM(index: Int) -> PermissionsKitCellVM {

        let data = permissions[index]

        let configuration = PermissionsKitConfigurations(frequency: .onceADay, presentInitialPopup: true, presentReEnablePopup: true)
        let initialPopupData = PermissionsKitAlert(title: data["label"]!, message: "Enable \(data["label"]!) Permissions!", allowButtonTitle: "Allow 👍🏼", denyButtonTitle: "No! 👎🏼")

        let reenablePopupData = PermissionsKitAlert(title: data["label"]!, message: "Enable \(data["label"]!) Permissions!", allowButtonTitle: "Allow 👍🏼", denyButtonTitle: "No! 👎🏼")

        let permission = getPermissionType(index: index, configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reenablePopupData)
        return PermissionsKitCellVM(permission: permission!, title: data["label"]!)
    }

    static private func getPermissionType(index: Int, configuration: PermissionsKitConfigurations, initialPopupData: PermissionsKitAlert, reEnablePopupData: PermissionsKitAlert) -> PermissionsKitProtocol? {

        switch index {
            case 0: return PermissionsKitBluetooth(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 1: return PermissionsKitCamera(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 2: return PermissionsKitCloudKit(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 3:return PermissionsKitContacts(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 4:return PermissionsKitEvents(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 5:return PermissionsKitHealth(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 6:return PermissionsKitMediaLibrary(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 7:return PermissionsKitMicrophone(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 8:return PermissionsKitMotion(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 9:return PermissionsKitNotifications(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 10:return PermissionsKitPhoto(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 11:return PermissionsKitReminders(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 12:return PermissionsKitSpeechRecognizer(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 13:return PermissionsKitLocationAlways(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            case 14:return PermissionsKitLocationWhenInUse(configuration: configuration, initialPopupData: initialPopupData, reEnablePopupData: reEnablePopupData)
            default: return nil
        }
    }

}

class PermissionsKitCellVM {

    private(set) var permission: PermissionsKitProtocol

    private(set) var title: String

    init(permission: PermissionsKitProtocol, title: String) {

        self.permission = permission
        self.title = title
    }
}
