import UIKit
import PermissionsKit

struct ExamplePermission {
    
    var permission: PermissionsKitBase
    var title: String
}

class ViewController: UIViewController {

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return PermissionsKitCellVMServiceProgrammatically.permissionCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionsKitCell", for: indexPath) as? PermissionsKitCell else {
            fatalError()
        }

        cell.viewModel = PermissionsKitCellVMServiceProgrammatically.buildVM(index: indexPath.row)

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Permissions configured programmatically"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? PermissionsKitCell else {
            fatalError()
        }

        cell.clicked = true
    }
}
