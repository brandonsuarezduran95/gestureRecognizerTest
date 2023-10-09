//
//  ViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 10/1/23.
//

import UIKit

class ViewController: UIViewController {
    
    let square: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let toggleSwitch = UISwitch()
    
    let indicationLabel = UILabel()
    
    var didTapSquare = true
    var didSwipeRectangle = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()

        square.backgroundColor = .systemRed
        square.layer.cornerRadius = 10
        square.center = self.view.center
        
        view.addSubview(square)
        
        toggleSwitch.center = view.center
        toggleSwitch.center.y += 200
        
        view.addSubview(toggleSwitch)
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSingleTapSquare(_:)))
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.numberOfTouchesRequired = 1
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapSquare(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 1
        doubleTapRecognizer.numberOfTouchesRequired = 2
        
        square.addGestureRecognizer(singleTapRecognizer)
        square.addGestureRecognizer(doubleTapRecognizer)
        square.isUserInteractionEnabled = true
        
    }
    
    
    @objc func didSingleTapSquare(_ gesture: UITapGestureRecognizer) {
        
        guard gesture.view != nil else { return }
        
        let returnToCenter: () -> Void = { [weak self] in
            if gesture.state == .ended {
                guard let maxX = gesture.view?.frame.maxX else { return }
                guard let self = self else { return }
                
                if maxX > self.view.bounds.maxX {
                    gesture.view?.center = self.view.center
                }
            }
            
        }
        
        if (gesture.state == .ended) && (toggleSwitch.isOn == false) {
            UIView.animate(withDuration: 0.4) {
                gesture.view?.center.x += 25
                returnToCenter()
            }
        } else if (gesture.state == .ended) && (toggleSwitch.isOn) {
            gesture.view?.backgroundColor = .systemRed
        }
        
        
        print("Square Single Tapped")
    }
    
    @objc func didDoubleTapSquare(_ gesture: UITapGestureRecognizer) {
        
        guard gesture.view != nil else { return }
        
        
        let returnToCenter: () -> Void = { [weak self] in
            if gesture.state == .ended {
                guard let minX = gesture.view?.frame.minX else { return }
                guard let self = self else { return }
                
                if minX < 0 {
                    gesture.view?.center = self.view.center
                }
            }
            
        }
        
        if (gesture.state == .ended) && (toggleSwitch.isOn == false) {
            UIView.animate(withDuration: 0.4) {
                gesture.view?.center.x -= 25
                returnToCenter()
            }
        } else if (gesture.state == .ended) && (toggleSwitch.isOn) {
            gesture.view?.backgroundColor = .systemGreen
        }
        
        print("Square Double Tapped")
    }
    
    @objc func didSwipeRectangle(_ gesture: UISwipeGestureRecognizer) {
//        guard let view = gesture.view else { return }
        
        print("Rectangle Swiped")
    }
    
    func setupController() {
        view.backgroundColor = .white
        title = "Tap Gesture"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupAddButton()
        setupLabel()
    }
    
    func setupAddButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapAddButton() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.systemYellow
        viewController.navigationController?.title = "Swipe Gesture"
        viewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        let rectangle = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
        rectangle.backgroundColor = .systemBlue
        rectangle.layer.cornerRadius = 10
        
        viewController.view.addSubview(rectangle)
        rectangle.center = viewController.view.center
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeRectangle(_ :)))
        swipeGesture.direction = .right
        swipeGesture.numberOfTouchesRequired = 1
        
        rectangle.isUserInteractionEnabled = true
        rectangle.addGestureRecognizer(swipeGesture)
        
        navigationController?.pushViewController(viewController, animated: true)
    }

}


extension ViewController {
    
    func setupLabel() {
        
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "When toggle is OFF tap to move right, double tap to move left, when toggle is ON, tap to change to .systemRed, double tap to change to .systemGreen"
        indicationLabel.numberOfLines = 4
        
        view.addSubview(indicationLabel)
        
        indicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            indicationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            indicationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
}
