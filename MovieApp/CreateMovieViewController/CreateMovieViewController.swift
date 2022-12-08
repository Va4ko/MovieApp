//
//  CreateMovieViewController.swift
//  MovieApp
//
//  Created by Ivan Ivanov on 2.12.22.
//

import UIKit

class CreateMovieViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var releaseYearField: UITextField!
    @IBOutlet weak var shortDescriptionField: UITextField!
    @IBOutlet weak var genreField: UITextField!
    @IBOutlet weak var longDescriptionField: UITextView!
    @IBOutlet weak var AddSaveMovieBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func addSaveBtnTapped(_ sender: Any) {
        if isEditMode {
            validateFields() ? saveMovie() : popAlert(message: Constants.AlertMessages.textFields, onComplete: {
            })
        } else {
            validateFields() ? addMovie() : popAlert(message: Constants.AlertMessages.textFields, onComplete: {
            })
        }
    }
    
    private var movie: Movie?
    private var keyboardRect: CGRect?
    private var containerView: UIView!
    var isEditMode: Bool = false
    var isDismissed: (() -> Void)?
    var imagePicker: UIPickerView?
    var datePicker: UIDatePicker?
    var genrePicker: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func closeBtnTapped() {
        dismiss(animated: true) {}
    }
    
    @objc private func handle(keyboardShowNotification notification: Notification) {
        if let userInfo = notification.userInfo,
           let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardRect = keyboardRectangle
        }
    }
    
    @objc private func dateDoneBtnPressed() {
        
        guard let datePicker else { return }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        releaseYearField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc private func genreDoneBtnPressed() {
        
        guard let genrePicker else { return }
        genreField.text = Constants.AddMovie.genres[genrePicker.selectedRow(inComponent: 0)]
        self.view.endEditing(true)
    }
    
    private func setupUI() {
        
        self.title = isEditMode ? Constants.Titles.createMovieViewControllerTitleEditMovie : Constants.Titles.createMovieViewControllerTitleAddMovie
        
        NotificationCenter.default.addObserver(self, selector: #selector(handle(keyboardShowNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        navigationItem.leftBarButtonItem = isEditMode ? nil : UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeBtnTapped))
        
        hideKeyboardWhenTappedAround()
        
        AddSaveMovieBtn.setBtnUI()
        AddSaveMovieBtn.setTitle(isEditMode ? Constants.Titles.createMovieViewControllerBtnTitleEditMovie : Constants.Titles.createMovieViewControllerBtnTitleAddMovie, for: .normal)
        
        setupPoster()
        setupTextFields()
        setupDatePicker()
        setupGenrePicker()
        
        if isEditMode {
            setupEditMode()
        }
    }
    
    private func setupEditMode() {
        guard let movie = movie else { return }
        
        poster.isUserInteractionEnabled = false
        guard let imageData = movie.poster else { return }
        poster.image = UIImage(data: imageData)
        
        titleField.isUserInteractionEnabled = false
        titleField.backgroundColor = UIColor.gray
        titleField.text = movie.title
        
        releaseYearField.isUserInteractionEnabled = false
        releaseYearField.backgroundColor = UIColor.gray
        releaseYearField.text = movie.releaseDate
        
        shortDescriptionField.text = movie.shortAbout
        
        genreField.text = movie.genre
        
        longDescriptionField.text = movie.longAbout
    }
    
    @objc private func setImagePicker() {
        imagePicker = UIPickerView()
        containerView = UIView()
        let pickerViewHeight = self.view.bounds.height / 3
        guard let imagePicker else { return }
        imagePicker.delegate = self
        imagePicker.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: pickerViewHeight)
        imagePicker.backgroundColor = UIColor.systemBackground
        containerView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: pickerViewHeight)
        containerView.addSubview(imagePicker)
        view.addSubview(containerView)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dismissImagePicker))
        
        let doneToolbar = UIToolbar()
        doneToolbar.sizeToFit()
        doneToolbar.setItems([doneButton], animated: false)
        doneToolbar.isUserInteractionEnabled = true
        doneToolbar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 35)
        doneToolbar.backgroundColor = .gray
        containerView.addSubview(doneToolbar)
        
        UIView.animate(withDuration: 0.2) {
            self.containerView.frame.origin.y = (self.view.frame.height - pickerViewHeight)
        }
    }
    
    @objc private func dismissImagePicker() {
        UIView.animate(withDuration: 0.2) {
            self.containerView.frame.origin.y = self.view.frame.height
        }
    }
    
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        
        guard let datePicker else { return }
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(dateDoneBtnPressed))
        toolBar.setItems([doneBtn], animated: true)
        
        releaseYearField.inputAccessoryView = toolBar
        releaseYearField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
    }
    
    private func setupGenrePicker() {
        genrePicker = UIPickerView()
        
        guard let genrePicker else { return }
        
        genrePicker.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(genreDoneBtnPressed))
        toolBar.setItems([doneBtn], animated: true)
        genreField.inputAccessoryView = toolBar
        genreField.inputView = genrePicker
        
    }
    
    private func setupPoster() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setImagePicker))
        
        poster.addGestureRecognizer(tapGestureRecognizer)
        
        poster.layer.borderWidth = 1.0
        poster.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupTextFields() {
        titleField.setupTextFields(placeHolder: Constants.TextFieldsPlaceholders.titleField)
        titleField.delegate = self
        
        releaseYearField.setupTextFields(placeHolder: Constants.TextFieldsPlaceholders.releaseYearField)
        releaseYearField.delegate = self
        
        shortDescriptionField.setupTextFields(placeHolder: Constants.TextFieldsPlaceholders.shortDescriptionField)
        shortDescriptionField.delegate = self
        
        genreField.setupTextFields(placeHolder: Constants.TextFieldsPlaceholders.genreField)
        genreField.delegate = self
        
        longDescriptionField.setupTextView()
        longDescriptionField.delegate = self
    }
    
    func animateViewMoving (up: Bool, additional: CGFloat?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            guard let keyboardRect = self.keyboardRect else { return }
            if additional != nil {
                let movement:CGFloat = ( up ? (keyboardRect.height + additional!) : 0)
                
                self.scrollView.setContentOffset(CGPoint(x: 0, y: movement), animated: true)
            } else {
                let movement:CGFloat = ( up ? keyboardRect.height : 0)
                self.scrollView.setContentOffset(CGPoint(x: 0, y: movement), animated: true)
            }
        }
    }
    
    private func addMovie() {
        let _ = CoreDataManager.shared.addMovie(poster: (poster.image?.jpegData(compressionQuality: 1))!, title: titleField.text!, releaseDate: releaseYearField.text!, genre: genreField.text!, shortAbout: shortDescriptionField.text!, longAbout: longDescriptionField.text)
        
        CoreDataManager.shared.save {
            self.dismiss(animated: true) {
                self.isDismissed?()
            }
        }
    }
    
    private func saveMovie() {
        guard let movie = movie else { return }
        movie.shortAbout = shortDescriptionField.text
        movie.genre = genreField.text
        movie.longAbout = longDescriptionField.text
        
        CoreDataManager.shared.save {
            self.navigationController?.popViewController(animated: true)
            self.isDismissed?()
        }
    }
    
    private func validateFields() -> Bool {
        if poster.image != nil && titleField.isMoreThanThree() && releaseYearField.text != nil && shortDescriptionField.isMoreThanThree() && genreField.text != nil && longDescriptionField.isMoreThanTen() {
            return true
        } else {
            return false
        }
    }
    
}

extension CreateMovieViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == titleField || textField == releaseYearField || textField == shortDescriptionField || textField == genreField {
            animateViewMoving(up: true, additional: nil)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleField || textField == releaseYearField || textField == shortDescriptionField || textField == genreField {
            animateViewMoving(up: false, additional: nil)
        }
    }
    
}

extension CreateMovieViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        animateViewMoving(up: true, additional: 100)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        animateViewMoving(up: false, additional: nil)
    }
}

extension CreateMovieViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == imagePicker {
            guard let imagePicker else { return }
            guard let image: UIImage = UIImage(named: "\(Constants.AddMovie.posters[imagePicker.selectedRow(inComponent: 0)])") else { return }
            poster.image = image
        }
    }
}

extension CreateMovieViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genrePicker {
            return Constants.AddMovie.genres.count
        } else if pickerView == imagePicker {
            return Constants.AddMovie.posters.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genrePicker {
            return Constants.AddMovie.genres[row]
        } else if pickerView == imagePicker {
            return Constants.AddMovie.posters[row]
        }
        return ""
    }
    
}

extension CreateMovieViewController: MovieDetailsDelegate {
    func movieData(movie: Movie) {
        self.movie = movie
    }
    
}
