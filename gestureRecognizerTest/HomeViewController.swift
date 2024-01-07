//
//  HomeViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 1/3/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let indicationLabel = UILabel()
    let resultLabel = UILabel()
    let tableView = UITableView(frame: .null, style: .insetGrouped)
    // MARK: - Controllers
    
    let tapController: ViewController = {
        let controller = ViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let longPressController: LongPressGestureViewController = {
        let controller = LongPressGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let pinchController: PinchGestureViewController = {
        let controller = PinchGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let panController: PanGestureViewController = {
        let controller = PanGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let swipeController: SwipeGestureViewController = {
        let controller = SwipeGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let rotationController: RotationGestureViewController = {
        let controller = RotationGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let screenEdgeController: ScreenEdgePanGestureViewController = {
        let controller = ScreenEdgePanGestureViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    let multipleGesturesController: MultipleGesturesViewController = {
        let controller = MultipleGesturesViewController()
        controller.onApear = {
            controller.navigationItem.rightBarButtonItem = nil
        }
        
        return controller
    }()
    
    
    lazy var controllers: [UIViewController] = [
        tapController,
        longPressController,
        pinchController,
        panController,
        swipeController,
        rotationController,
        screenEdgeController,
        multipleGesturesController
    ]

    
    let names: [String] = [
        "Tap",
        "Long Press",
        "Pinch",
        "Pan",
        "Swipe",
        "Rotation",
        "Edge Pan",
        "Multiple Gestures",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupLabel()
        setupAddButton()
        setupTableView()
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "Gestures"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension HomeViewController {
    // MARK: - Indication Label
    func setupLabel() {
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Tap the option on the table to go to the gestures' Test"
        indicationLabel.numberOfLines = 4
        
        view.addSubview(indicationLabel)
        
        indicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            indicationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            indicationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
    
    // MARK: - Plus Button
    func setupAddButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapAddButton() {
        let viewController = ViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: indicationLabel.bottomAnchor, constant: 15),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
        ])
    }
}

// MARK: - Table View's Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = controllers[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - Table View's Data Source
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = names[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}
