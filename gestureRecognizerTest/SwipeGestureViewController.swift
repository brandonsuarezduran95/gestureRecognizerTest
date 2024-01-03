//
//  SwipeGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 12/31/23.
//

import UIKit

class SwipeGestureViewController: UIViewController {
    
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
        title = "Swipe Gesture"
    }


}


extension SwipeGestureViewController {
    // MARK: - Square View
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .white
        square.layer.borderColor = UIColor.systemCyan.cgColor
        square.layer.borderWidth = 2.0
        
        // gesture Recognizer
        square.isUserInteractionEnabled = true
        
        let downGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        downGesture.direction = .down
        
        let upGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        upGesture.direction = .up
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftGesture.direction = .left
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightGesture.direction = .right
        
        square.addGestureRecognizer(downGesture)
        square.addGestureRecognizer(upGesture)
        square.addGestureRecognizer(leftGesture)
        square.addGestureRecognizer(rightGesture)
        
        view.addSubview(square)
        
    }
    
    @objc func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        let changeColor: (UIColor) -> Void = { [unowned self] color in
            UIView.animate(withDuration: 0.5) {
                self.square.backgroundColor = color
            }
        }
        if gestureRecognizer.state == .ended {
            square.layer.borderColor = UIColor.white.cgColor
            
            switch gestureRecognizer.direction {
            case .up:
                actionResult.text = "Swiped Up"
                changeColor(.systemIndigo)
            case .down:
                actionResult.text = "Swiped Down"
                changeColor(.systemRed)
            case .left:
                actionResult.text = "Swiped Left"
                changeColor(.systemGreen)
            case .right:
                actionResult.text = "Swiped Right"
                changeColor(.systemYellow)
            default:
                break
            }
  
        }
         
    }
    
    // MARK: - Indication Label
    func setupLabel() {
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Swipe the view in any direction."
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
        let viewController = RotationGestureViewController()
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
