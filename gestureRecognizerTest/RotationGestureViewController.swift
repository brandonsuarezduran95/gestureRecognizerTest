//
//  RotationGestureViewController.swift
//  gestureRecognizerTest
//
//  Created by Brandon Suarez on 1/2/24.
//

import UIKit


class RotationGestureViewController: UIViewController {
    
    let square = UIView()
    let indicationLabel = UILabel()
    let resultLabel = UILabel()
    let actionResult = UILabel()
    let resetButton = UIButton()
    var rotation: CGFloat = 0.0

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
    
    func setupController() {
        view.backgroundColor = .white
        title = "Rotation Gesture"
    }
}


extension RotationGestureViewController {
    // MARK: - Square View
    func setupSquareView() {
        square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        square.center = view.center
        square.layer.cornerRadius = 10
        square.backgroundColor = .systemBrown
        
        let gesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        // gesture Recognizer
        square.isUserInteractionEnabled = true
        square.addGestureRecognizer(gesture)
        view.addSubview(square)
        
    }
    
    @objc func handleRotation(_ gestureRecognizer: UIRotationGestureRecognizer) {
        guard gestureRecognizer.view != nil else { return }
        
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            actionResult.text = "\(gestureRecognizer.rotation)"
            self.rotation = gestureRecognizer.rotation
           gestureRecognizer.view?.transform = gestureRecognizer.view!.transform.rotated(by: gestureRecognizer.rotation)
           gestureRecognizer.rotation = 0
        }
    }
    
    // MARK: - Indication Label
    func setupLabel() {
        indicationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        indicationLabel.text = "Use two fingers to rotate the view."
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

extension RotationGestureViewController {
    
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
            self.square.transform = CGAffineTransform.identity.rotated(by: rotation)
            print("Square centered")
        }
    }
    
}
