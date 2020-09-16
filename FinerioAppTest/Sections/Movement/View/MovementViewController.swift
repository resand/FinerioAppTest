//
//  MovementViewController.swift
//  FinerioAppTest
//
//  Created by René Sandoval on 15/09/20.
//  Copyright © 2020 Finerio. All rights reserved.
//

import UIKit

class MovementViewController: BaseViewController {
    var eventHandler: MovementEventHandler?
    fileprivate var movements: [Movement]?
    fileprivate var listMovementsComplet: Bool = false
    fileprivate var scrollActivityIndicator: ScrollActivityIndicator!

    fileprivate lazy var userLabel: UILabel = self.setupLabel(text: Utils.getInfoUserDefaults(key: Constants.UserKeys.name) ?? "", fontSize: 20)
    fileprivate lazy var emailLabel: UILabel = self.setupLabel(text: Utils.getInfoUserDefaults(key: Constants.UserKeys.email) ?? "", fontSize: 18)
    fileprivate lazy var movementsTableView: UITableView = setupMovementsTableView()

    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movimientos"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir", style: .done, target: self, action: #selector(logoutAction))

        startLoader()
        eventHandler?.sendMovement(page: offset)
    }

    override func addViews() {
        [userLabel, emailLabel, movementsTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    override func setupLayout() {
        // userLabel
        userLabel.topAnchor(equalTo: view.topAnchor, constant: 20)
        userLabel.centerXAnchor(equalTo: view.centerXAnchor)

        // emailLabel
        emailLabel.topAnchor(equalTo: userLabel.bottomAnchor)

        [userLabel, emailLabel].forEach {
            $0.widthAnchor(equalTo: view.frame.width - 50)
            $0.centerXAnchor(equalTo: view.centerXAnchor)
            $0.heightAnchor(equalTo: 30)
        }

        // movementsTableView
        movementsTableView.topAnchor(equalTo: emailLabel.bottomAnchor, constant: 20)
        movementsTableView.bottomAnchor(equalTo: view.bottomAnchor)
        movementsTableView.leadingAnchor(equalTo: view.leadingAnchor)
        movementsTableView.trailingAnchor(equalTo: view.trailingAnchor)
    }
    
    @objc func logoutAction() {
        let alertController = UIAlertController(title: "¡Atención!", message: "Se cerrará la sesión actual", preferredStyle: .alert)
        let goAction = UIAlertAction(title: "Aceptar", style: .default) { (action) in
            Utils.saveInfoUserDefaults(value: "false", key: Constants.UserKeys.currentSession)
            self.eventHandler?.sendLogin()
        }
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertController.addAction(goAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Views
extension MovementViewController {
    private func setupLabel(text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.textColor = UIColor(hex: Constants.Colors.mainColor)
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }

    private func setupMovementsTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovementTableViewCell.self, forCellReuseIdentifier: MovementTableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
}

//Mark: UITableViewDataSource
extension MovementViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovementTableViewCell.id, for: indexPath) as? MovementTableViewCell else {
            fatalError("Could not cast MovementTableViewCell")
        }

        cell.setup(with: movements![indexPath.row])
        return cell
    }
}

extension MovementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !listMovementsComplet else {
            scrollActivityIndicator.stop()
            return
        }

        scrollActivityIndicator = ScrollActivityIndicator(scrollView: movementsTableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)

        scrollActivityIndicator.start {
            self.offset += 10
            self.eventHandler?.sendMovement(page: self.offset)
            DispatchQueue.main.async { [weak self] in
                self?.scrollActivityIndicator.stop()
            }
        }
    }
}

extension MovementViewController: MovementView {
    func movementResponseSuccess(response: MovementModel) {
        stopLoader()
        if movements?.count ?? 0 > 0 {
            movements?.append(contentsOf: response.movements ?? [])
        } else {
            movements = response.movements
        }

        if response.size == 0 { listMovementsComplet = true }

        movementsTableView.reloadData()
    }

    func movementResponseFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error", message: response, context: self)
    }

    func movementResponseServiceFail(response: String) {
        stopLoader()
        Utils.showAlert(title: "Error al ingresar", message: response, context: self)
    }
}
