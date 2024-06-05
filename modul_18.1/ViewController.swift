//
//  ViewController.swift
//  modul_18.1
//
//  Created by Admin on 28/04/24.
//

import SnapKit
import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let apiKey = "8444fa56-7af6-40e6-b27f-fdbcbab43f60"
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "тут пользовательский текст"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let urlSessionButton: UIButton = {
        let button = UIButton()
        button.setTitle("URLSession", for: .normal)
        //button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(urlSesionButtonTaped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        return button
    }()
    
    
    let alomafireButton: UIButton = {
        let button = UIButton()
        button.setTitle("Alomafire", for: .normal)
        //button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(nil, action: #selector(alomafireButtonTaped), for: .touchUpInside)
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    let resultTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.backgroundColor = .systemGray6
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.cornerRadius = 8.0
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        return textView
    }()
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "тут результат:"
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let  activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.color = .red
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemGreen
        
        
        setupUI()
    }
    
    
    
    func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(urlSessionButton)
        view.addSubview(alomafireButton)
        view.addSubview(resultTextView)
        //view.addSubview(textLabel)
        view.addSubview(activityIndicator)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        urlSessionButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.equalTo(50)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
        
        alomafireButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            //make.leading.equalTo(urlSessionButton.snp.trailing).offset(70)
            make.trailing.equalTo(-40)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        resultTextView.snp.makeConstraints{ make in
            make.top.equalTo(urlSessionButton.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
//        textLabel.snp.makeConstraints{ make in
//            make.top.equalTo(urlSessionButton.snp.bottom).offset(50)
//            make.leading.equalToSuperview().offset(30)
//        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(urlSessionButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            //make.bottom.equalTo(resultTextView.snp.top).offset(-3)
        }
    }
    
    
    @objc func urlSesionButtonTaped() {
        //        guard let searchText = searchTextField.text else {
        //            return
        //        }
        //
        //        let urlString = "https://api.kinopoisk.cloud/search-by-keyword?keyword=\(searchText)"
        //
        //        // Выбор метода для отправки запроса
        //        if let selectedMethod = UserDefaults.standard.string(forKey: "selectedMethod") {
        //            switch selectedMethod {
        //            case "URLSession":
        //                fetchUsingURLSession(urlString: urlString)
        //            default:
        //                print("No method selected")
        //            }
        //        } else {
        //            print("No method selectedd")
        //        }
        //
        //        func fetchUsingURLSession(urlString: String) {
        //            if let url = URL(string: urlString) {
        //                var request = URLRequest(url: url)
        //                request.httpMethod = "GET"
        //                request.allHTTPHeaderFields = ["accept": "application/json"]
        //                request.httpBody = nil
        //                request.setValue(apiKey, forHTTPHeaderField: "8444fa56-7af6-40e6-b27f-fdbcbab43f60")
        //
        //                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //                    if let error = error {
        //                        print("Error: \(error)")
        //                    } else if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
        //                        print(json)
        //                        let resultString = String(data: data, encoding: .utf8)
        //                        DispatchQueue.main.async {
        //                            self.resultTextView.text = resultString
        //                        }
        //                    }
        //                }
        //                task.resume()
        //            }
        //
        //        }
        
        view.endEditing(true) // Скрытие клавиатуры
        
        guard let movieId = searchTextField.text, !movieId.isEmpty else {
            print("Movie is empty")
            return
        }
        
        guard let movieId1 = movieId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid movie ID encoding")
            return
        }
        
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(movieId1)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-API-KEY")
        
        activityIndicator.startAnimating() // Запуск индикатора загрузки
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating() // Остановка индикатора загрузки
            }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.resultTextView.text = jsonString
                }
            }
        }
        task.resume()
    }
    
    
    @objc func alomafireButtonTaped() {
        //        guard let searchText = searchTextField.text else {
        //            return
        //        }
        //
        //        let urlString = "https://api.kinopoisk.cloud/search-by-keyword?keyword=\(searchText)"
        //
        //        // Выбор метода для отправки запроса
        //        if let selectedMethod = UserDefaults.standard.string(forKey: "selectedMethod") {
        //            switch selectedMethod {
        //            case "URLSession":
        //                fetchUsingURLSession(urlString: urlString)
        //            default:
        //                print("No method selected")
        //            }
        //        } else {
        //            print("No method selectedd")
        //        }
        //
        //        func fetchUsingURLSession(urlString: String) {
        //            if let url = URL(string: urlString) {
        //                var request = URLRequest(url: url)
        //                request.httpMethod = "GET"
        //                request.allHTTPHeaderFields = ["accept": "application/json"]
        //                request.httpBody = nil
        //                request.setValue(apiKey, forHTTPHeaderField: "8444fa56-7af6-40e6-b27f-fdbcbab43f60")
        //
        //                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        //                    if let error = error {
        //                        print("Error: \(error)")
        //                    } else if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
        //                        print(json)
        //                        let resultString = String(data: data, encoding: .utf8)
        //                        DispatchQueue.main.async {
        //                            self.resultTextView.text = resultString
        //                        }
        //                    }
        //                }
        //                task.resume()
        //            }
        //
        //        }
        //
        //    }
        
        view.endEditing(true) // Скрытие клавиатуры
        
        guard let movieId = searchTextField.text, !movieId.isEmpty else {
                    print("Movie ID is empty")
                    return
                }
                
        guard let movieId1 = movieId.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Invalid movie ID encoding")
            return
        }
                let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(movieId1)"
                
                let headers: HTTPHeaders = [
                    "X-API-KEY": apiKey
                ]
                
        activityIndicator.startAnimating() // Запуск индикатора загрузки
        
                AF.request(urlString, headers: headers).response { response in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating() // Остановка индикатора загрузки
                    }
                    
                    if let error = response.error {
                        print("Error: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let data = response.data else {
                        print("No data returned")
                        return
                    }
                    
                    if let jsonString = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            self.resultTextView.text = jsonString
                        }
                    }
                }
        
    }
    
    
    
}








