//
//  LongPressGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 10/16/23.
//

import UIKit

class LongPressGestureViewController: UIViewController {
    
    let square = UIView()
    let indicationLabel = UILabel()
    lazy var editMenu = UIEditMenuInteraction(delegate: self)
    let resultLabel = UILabel()
    let actionResult = UILabel()
    var onApear: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSquareView()
        setupLabel()
        setupResultLabel()
        setupActionResultLabel()
        setupAddButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onApear()
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "Long Press"
    }


}


extension LongPressGestureViewController {
    // MARK: - Square View
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemBlue
        
        // gesture Recognizer
        square.isUserInteractionEnabled = true
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressView(_:)))
        gesture.minimumPressDuration = 0.5
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 0
        gesture.allowableMovement = 10
        
        square.addGestureRecognizer(gesture)
        square.addInteraction(editMenu)
        
        view.addSubview(square)
        
    }
    
    @objc func didLongPressView(_ gestureRecognizer: UILongPressGestureRecognizer) {

        let location = gestureRecognizer.location(in: square)
        let configuration = UIEditMenuConfiguration(identifier: nil, sourcePoint: location)
        
        if gestureRecognizer.state == .began {
            editMenu.presentEditMenu(with: configuration)
        }
    }
    
    // MARK: - Indication Label
    func setupLabel() {
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Long Press the View, after 0.5 Seconds the menu will appear, select any action."
        indicationLabel.numberOfLines = 4
        
        view.addSubview(indicationLabel)
        
        indicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            indicationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            indicationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
    
    // MARK: - Result Label
    
    func setupResultLabel() {
        resultLabel.font = .systemFont(ofSize: 16, weight: .bold)
        resultLabel.text = "Result of Long Tap Actions:"
        resultLabel.numberOfLines = 1
        
        view.addSubview(resultLabel)
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resultLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            resultLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            resultLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
    
    // MARK: - Add Button
    
    func setupAddButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapAddButton() {
        let viewController = PinchGestureViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Action Result
    
    func setupActionResultLabel() {

        actionResult.font = .systemFont(ofSize: 16, weight: .regular)
        actionResult.text = "No Actions"
        actionResult.numberOfLines = 1
        
        view.addSubview(actionResult)
        
        actionResult.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actionResult.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            actionResult.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            actionResult.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
}

extension LongPressGestureViewController: UIEditMenuInteractionDelegate {
    func editMenuInteraction(_ interaction: UIEditMenuInteraction, menuFor configuration: UIEditMenuConfiguration, suggestedActions: [UIMenuElement]) -> UIMenu? {
        
        let indentationMenu = UIMenu(title: "Indentation", image: UIImage(systemName: "list.bullet.indent"), options: [.destructive], children: [
            UIAction(title: "Increase", image: UIImage(systemName: "increase.indent")) { [weak self] (action) in
                guard let self = self else { return }
                
                self.actionResult.text = "Increase"
            },
            UIAction(title: "Decrease", image: UIImage(systemName: "decrease.indent")) { [weak self] (action) in
                guard let self = self else { return }
                self.actionResult.text = "Decrease"
            },
            UIAction(title: "Action A", image: UIImage(systemName: "pencil.line")) { [weak self] action in
                guard let self = self else { return }
                self.actionResult.text = "Action A"
            },
            UIAction(title: "Action B", image: UIImage(systemName: "eraser.fill")) { [weak self] action in
                guard let self = self else { return }
                self.actionResult.text = "Action B"
            }
        ])

        return indentationMenu
    }
}
