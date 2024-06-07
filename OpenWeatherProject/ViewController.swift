//
//  ViewController.swift
//  OpenWeatherProject
//
//  Created by 권대윤 on 6/6/24.
//

import UIKit
import CoreLocation

import Alamofire
import Kingfisher
import SnapKit

final class ViewController: UIViewController {
    
    //MARK: - Properties
    
    let locationManager = CLLocationManager()
    
    
    //MARK: - UI Components
    
    private let mainBackImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let updateTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let locationIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "location")
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .regular)
        return label
    }()
    
    private let shareButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    private lazy var refreshButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let tempBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let humidityBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let windBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let weatherImageBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let weatherImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.tintColor = .black
        return iv
    }()
    
    private let commentBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCLLoacationManager()
        configureLayout()
        configureUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
            self.locationManager.requestLocation()
        })
    }
    
    private func configureLayout() {
        view.addSubview(mainBackImageView)
        mainBackImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(updateTimeLabel)
        updateTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        view.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.top.equalTo(updateTimeLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        view.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(updateTimeLabel.snp.bottom).offset(5)
            make.leading.equalTo(locationIcon.snp.trailing).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        view.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.top).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(25)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.top).offset(5)
            make.width.equalTo(20)
            make.height.equalTo(25)
            make.trailing.equalTo(refreshButton.snp.leading).offset(-30)
        }
        
        view.addSubview(tempBackView)
        tempBackView.snp.makeConstraints { make in
            make.top.equalTo(locationIcon.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        view.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.edges.equalTo(tempBackView.snp.edges).inset(10)
        }
        
        view.addSubview(humidityBackView)
        humidityBackView.snp.makeConstraints { make in
            make.top.equalTo(tempBackView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(130)
            make.height.equalTo(40)
        }
        
        view.addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints { make in
            make.edges.equalTo(humidityBackView.snp.edges).inset(10)
        }
        
        view.addSubview(windBackView)
        windBackView.snp.makeConstraints { make in
            make.top.equalTo(humidityBackView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(40)
        }
        
        view.addSubview(windLabel)
        windLabel.snp.makeConstraints { make in
            make.edges.equalTo(windBackView.snp.edges).inset(10)
        }
        
        view.addSubview(weatherImageBackView)
        weatherImageBackView.snp.makeConstraints { make in
            make.top.equalTo(windBackView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(188)
            make.height.equalTo(150)
        }
        
        view.addSubview(weatherImageView)
        weatherImageView.snp.makeConstraints { make in
            make.edges.equalTo(weatherImageBackView.snp.edges).inset(10)
        }
        
        view.addSubview(commentBackView)
        commentBackView.snp.makeConstraints { make in
            make.top.equalTo(weatherImageBackView.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(188)
            make.height.equalTo(40)
        }
        
        view.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.edges.equalTo(commentBackView.snp.edges).inset(10)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        mainBackImageView.image = UIImage.tomBarrettHgGplX3PFBgUnsplash
    }
    
    //MARK: - Functions
    
    private func setupCLLoacationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.delegate = self
    }
    
    private func callRequest(lat: Double, lon: Double) {
        let url = APIURL.url(lat: lat, lon: lon)
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let data):
                self.updateUIWithData(data: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateUIWithData(data: WeatherData) {
        guard let temp = data.main?.temp else {return}
        guard let wind = data.wind?.speed else {return}
        guard let humidity = data.main?.humidity else {return}
        guard let icon = data.weather?[0].icon else {return}
        weatherImageView.kf.setImage(with: APIURL.iconURL(with: icon))
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 HH시 mm분"
        let currentDate = formatter.string(from: date)
        
        updateTimeLabel.text = currentDate
        tempLabel.text = "지금은 \(Int(temp))°C 에요"
        humidityLabel.text = "\(Int(humidity))% 만큼 습해요"
        windLabel.text = "\(wind)m/s의 바람이 불어요"
        commentLabel.text = "오늘도 행복한 하루 보내세요"
        
        [tempBackView, humidityBackView, windBackView, weatherImageBackView, commentBackView].forEach {
            $0.backgroundColor = .white
        }
    }
    
    @objc func refreshButtonTapped() {
        self.locationManager.requestLocation()
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    //결과로 호출되는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lat = locations.last?.coordinate.latitude else {return}
        guard let lon = locations.last?.coordinate.longitude else {return}
        
        callRequest(lat: lat, lon: lon)
        findAddr(lat: lat, long: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                var myAdd: String = ""
                if let area: String = address.last?.locality{
                    myAdd += area
                }
                if let name: String = address.last?.name {
                    myAdd += " "
                    myAdd += name
                }
                let array = myAdd.components(separatedBy: " ")
                let reform = array[0] + " " + array[1]
                self.locationLabel.text = reform
            }
        })
    }
}

