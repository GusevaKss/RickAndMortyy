//
//  AddPlayerBottomSheetViewController.swift
//  RickAndMortyy
//
//  Created by Kseniya Kovgorenya on 27.06.25.
//

import UIKit
import SnapKit

class AddPlayerBottomSheetViewController: UIViewController {
    
    var onAddPlayer: ((PlayersListItem) -> Void)?
    
    private let numberField = UITextField()
    private let nameField = UITextField()
    private let matchField = UITextField()
    private let uspField = UITextField()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let addButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupViews()
        setupKeyboardObservers()
        setupTargets()
        
        uspField.delegate = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.keyboardDismissMode = .interactive
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        [numberField, nameField, matchField, uspField].forEach {
            $0.borderStyle = .roundedRect
            $0.delegate = self
        }
        
        numberField.placeholder = "Номер игрока"
        numberField.keyboardType = .numberPad
        
        nameField.placeholder = "Имя игрока"
        
        matchField.placeholder = "Количество матчей"
        matchField.keyboardType = .numbersAndPunctuation
        
        uspField.placeholder = "УСП"
        uspField.keyboardType = .decimalPad
        
        addButton.setTitle("Добавить", for: .normal)
        addButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        addButton.addTarget(self, action: #selector(addPlayerTapped), for: .touchUpInside)
        
        contentView.addSubview(numberField)
        contentView.addSubview(nameField)
        contentView.addSubview(matchField)
        contentView.addSubview(uspField)
        contentView.addSubview(addButton)
        
        numberField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.right.equalToSuperview().inset(20)
        }

        nameField.snp.makeConstraints { make in
            make.top.equalTo(numberField.snp.bottom).offset(16)
            make.left.right.equalTo(numberField)
        }

        matchField.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(16)
            make.left.right.equalTo(nameField)
        }

        uspField.snp.makeConstraints { make in
            make.top.equalTo(matchField.snp.bottom).offset(16)
            make.left.right.equalTo(nameField)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(uspField.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupTargets() {
            [numberField, nameField, matchField, uspField].forEach {
                $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            }
        }
    
    @objc private func keyboardWillShow(notification: Notification) {
            guard let userInfo = notification.userInfo,
                  let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
            
            let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
        
        @objc private func keyboardWillHide(notification: Notification) {
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
        }
    
    @objc private func addPlayerTapped() {
        guard let numberText = numberField.text, let number = Int(numberText),
              let name = nameField.text, !name.isEmpty,
              let matches = matchField.text,
              let usp = uspField.text else { return }
        
        let newUsp = usp.replacingOccurrences(of: ",", with: ".")
        
        let newPlayer = PlayersListItem(number: number, image: UIImage(systemName: "person.fill"), name: name, matches: matches, usp: newUsp)
        
        onAddPlayer?(newPlayer)
        dismiss(animated: true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
            let isFilled = [numberField, nameField, matchField, uspField].allSatisfy { !($0.text?.isEmpty ?? true) }
            addButton.isEnabled = isFilled
        }

}

// MARK: - UITextFieldDelegate

extension AddPlayerBottomSheetViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }

        let current = textField.text ?? ""
        let nsCurrent = current as NSString
        let updated = nsCurrent.replacingCharacters(in: range, with: string)

        switch textField {
        case numberField:
            return updated.range(of: "[^0-9]", options: .regularExpression) == nil
        case nameField:
            return updated.range(of: "[^a-zA-Zа-яА-Я0-9]", options: .regularExpression) == nil
        case matchField:
            return updated.range(of: "[^0-9\\-]", options: .regularExpression) == nil
        case uspField:
            if string == "," {
                if let text = textField.text as NSString? {
                    textField.text = text.replacingCharacters(in: range, with: ".")
                }
                return false
            }

            let allowed = updated.range(of: "[^0-9\\.]", options: .regularExpression) == nil
            let dotCount = updated.filter { $0 == "." }.count
            let decimals = updated.components(separatedBy: ".").last ?? ""
            return allowed && dotCount <= 1 && decimals.count <= 2
        default:
            return true
        }
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            switch textField {
            case numberField: numberField.placeholder = "123"
            case nameField: nameField.placeholder = "Имя123"
            case matchField: matchField.placeholder = "25-5"
            case uspField: uspField.placeholder = "1.23"
            default: break
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            switch textField {
            case numberField: numberField.placeholder = "Номер игрока"
            case nameField: nameField.placeholder = "Имя игрока"
            case matchField: matchField.placeholder = "Количество матчей"
            case uspField: uspField.placeholder = "УСП"
            default: break
            }
        }
    
}
