//
//  PinchGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 10/26/23.
//

import UIKit

class PinchGestureViewController: UIViewController {
    
    let square = UIView()
    let indicationLabel = UILabel()
    let resetButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupSquareView()
        setupLabel()
        setupButton()

    }
    
    func setupViewController() {
        view.backgroundColor = .white
        title = "Pinch Gesture"
        setupAddButton()
    }

}

extension PinchGestureViewController {
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemMint
        
        //Gesture Recognizer
        square.isUserInteractionEnabled = true
        
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(scalePiece))
        square.addGestureRecognizer(gesture)
        view.addSubview(square)
    }
    
    @objc func scalePiece(_ gestureRecognizer: UIPinchGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let scale: CGFloat = {
                if gestureRecognizer.scale > 1.5 {
                    return 1.5
                } else if gestureRecognizer.scale < 0.5 {
                    return 0.3
                }
                
                return gestureRecognizer.scale
                
            }()
             
            print("The current Scale is:",scale)
            gestureRecognizer.view?.frame = CGRect(x: 0, y: 0, width: 200 * scale, height: 200 * scale)
            gestureRecognizer.view?.center = view.center
        }
    }
    
}

extension PinchGestureViewController {
    
    func setupLabel() {
        
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Press The Button to reset the square size, pinch to change the square's size"
        indicationLabel.numberOfLines = 4
        
        view.addSubview(indicationLabel)
        
        indicationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            indicationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            indicationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15)
        ])
    }
    
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
            resetButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 200),
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
        
        // Square Reset Animation
        UIView.animate(withDuration: 1.0) { [unowned self] in
            square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            square.center = view.center
            square.layer.cornerRadius = 10
        }
        
    }
    
    func setupAddButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func didTapAddButton() {
        let viewController = PanGestureViewController()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}