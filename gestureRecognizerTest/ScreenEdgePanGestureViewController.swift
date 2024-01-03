//
//  ScreenEdgePanGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 1/2/24.
//

import UIKit


class ScreenEdgePanGestureViewController: UIViewController {
    
    let square = UIView()
    let indicationLabel = UILabel()
    let resultLabel = UILabel()
    let actionResult = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSquareView()
        setupLabel()
        setupResultLabel()
        setupActionResultLabel()
        setupAddButton()
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "EdgePan Gesture"
    }
}


extension ScreenEdgePanGestureViewController {
    // MARK: - Square View
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemPink
        
        
        let gestureRight = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        gestureRight.edges = .right
        
        
        // gesture Recognizer
        square.isUserInteractionEnabled = true
        
        square.addGestureRecognizer(gestureRight)
        
        view.addSubview(square)
        
    }
    
    @objc func screenEdgeSwiped(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        
        let changeColor: (UIColor) -> Void = { [unowned self] color in
            UIView.animate(withDuration: 0.5) {
                self.square.backgroundColor = color
            }
        }
        
        if gestureRecognizer.state == .recognized {
            actionResult.text = "Swiped Right"
            print("Swiped Right")
            changeColor(.systemYellow)
        }
        
    }

    
    // MARK: - Indication Label
    func setupLabel() {
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Swipe from the right edge of the screen."
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
        resultLabel.text = "Result of Rotation."
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
//        let viewController = UIViewController()
//        navigationController?.pushViewController(viewController, animated: true)
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
