//
//  MultipleGesturesViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 1/3/24.
//

import UIKit

class MultipleGesturesViewController: UIViewController {
    
    let square = UIView()
    let indicationLabel = UILabel()
    let resultLabel = UILabel()
    let actionResult = UILabel()
    let resetButton = UIButton()
    var onApear: () -> Void = {}
    
    // Gestures
    lazy var swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_ :)))
    lazy var swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_ :)))
    lazy var swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_ :)))
    lazy var swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_ :)))
    
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_ :)))
    var initialCenter = CGPoint()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupSquareView()
        setupLabel()
        setupResultLabel()
        setupActionResultLabel()
        setupAddButton()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onApear()
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "Multiple Gestures"
        panGesture.delegate = self
    }
}


extension MultipleGesturesViewController {
    // MARK: - Square View
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemGray
        
        // gesture Recognizer
        square.isUserInteractionEnabled = true
        
        // Pan Gesture
        square.addGestureRecognizer(panGesture)
        
        // Swipe Gesture
        swipeRightGesture.direction = .right
        swipeLeftGesture.direction = .left
        swipeUpGesture.direction = .up
        swipeDownGesture.direction = .down
        
        square.addGestureRecognizer(swipeRightGesture)
        square.addGestureRecognizer(swipeLeftGesture)
        square.addGestureRecognizer(swipeUpGesture)
        square.addGestureRecognizer(swipeDownGesture)
        
        view.addSubview(square)
        
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        let gesturesView = gestureRecognizer.view
        let translation = gestureRecognizer.translation(in: gesturesView?.superview)
        
        if gestureRecognizer.state == .began {
            initialCenter = gesturesView!.center
        }
        
        if gestureRecognizer.state != .cancelled {
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            print("The new Center is -> X: \(newCenter.x), Y:\(newCenter.y)")
            gesturesView?.center = newCenter
        } else {
            gesturesView?.center = initialCenter
        }
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
        indicationLabel.text = "Pan and Swipe Gestures are attached to the square view, the Swipe gesture is the priority, swipe to the sides to change colors, hold press, and then drag to move the square."
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
        resultLabel.text = "Result of Action."
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
//        let viewController = ScreenEdgePanGestureViewController()
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

extension MultipleGesturesViewController {
    
    func setupButton() {
        
        resetButton.backgroundColor = .systemBlue
        resetButton.setTitle("Reset", for: .normal)
        resetButton.titleLabel?.textColor = .white
        
        resetButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        resetButton.layer.cornerRadius = 10
        resetButton.addTarget(self, action: #selector(didPressResetButton), for: .touchUpInside)
        
        view.addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.heightAnchor.constraint(equalToConstant: 30),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func didPressResetButton() {
        // Button Animation
        UIView.animate(withDuration: 0.1) { [unowned self] in
            self.resetButton.transform = CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.resetButton.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
            }
        }
        
        // Reset View's Rotation.
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.square.center = view.center
            print("Square view center reseted")
        }
    }
    
}

extension MultipleGesturesViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.panGesture && (otherGestureRecognizer == self.swipeUpGesture || otherGestureRecognizer == self.swipeDownGesture || otherGestureRecognizer == self.swipeLeftGesture || otherGestureRecognizer == self.swipeRightGesture) {
            return true
        }
        
        return false
    }
    
}
