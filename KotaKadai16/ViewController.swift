//
//  ViewController.swift
//  KotaKadai16
//
//  Created by 前田航汰 on 2022/03/17.
//

import UIKit

struct CheckItem {
    var name: String
    var isChecked: Bool
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    private var checkItems: [CheckItem] = [
        .init(name: "みかん", isChecked: true),
        .init(name: "りんご", isChecked: false),
        .init(name: "バナナ", isChecked: true),
        .init(name: "パイナップル", isChecked: false)
    ]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CheckItemsTableViewCell
        cell.configure(checkItem: checkItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        checkItems[indexPath.row].isChecked.toggle()
        tableView.reloadData()
    }

    // itemの変更画面へ遷移
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let changeNameNC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeNameNC") as! UINavigationController
        let changeNameVC = changeNameNC.topViewController as! ChangeNameViewController
        changeNameVC.delegate = self
        changeNameVC.setData(name: checkItems[indexPath.row].name, index: indexPath.row)
        present(changeNameNC, animated: true, completion: nil)
    }

    // itemの追加画面へ遷移
    @IBAction private func didTapAddNameButton(_ sender: Any) {
        let additionNameNC = self.storyboard?.instantiateViewController(withIdentifier: "AdditionNameNC") as! UINavigationController
        let additionNameVC = additionNameNC.topViewController as! AdditionNameViewController
        additionNameVC.delegate = self
        present(additionNameNC, animated: true, completion: nil)
    }

    @IBAction func cancelExit(segue: UIStoryboardSegue) {
    }

}

extension ViewController: AdditionNameViewControllerDelegate, ChangeNameViewControllerDelegate {
    func addName(name: String) {
        checkItems.append(.init(name: name, isChecked: false))
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }

    func changeName(name: String, index: Int) {
        checkItems[index].name = name
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}
