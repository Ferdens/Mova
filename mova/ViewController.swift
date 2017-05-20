//
//  ViewController.swift
//  mova
//
//  Created by anton Shepetuha on 19.05.17.
//  Copyright © 2017 anton Shepetuha. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class ViewController: UIViewController {
    
    var collectionView      : UICollectionView?
    var viewUnderNavigation : UIView?
    var infoView            : PinInfoView?
    var mapView             : MKMapView?
    
    var testArray = ["Beauty","Household","Auto","Tech","Spa","Sport","Study","Translation"]
    
     var dataArray = [PinData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()

//        let pinData1 = PinData()
//        pinData1.latitude  = 48.525978
//        pinData1.longitude = 35.065998
//        pinData1.topText = "TopText1"
//        pinData1.bottomText = "BottomText1"
//        
//        let pinData2 = PinData()
//        pinData2.latitude = 48.525978
//        pinData2.longitude = 37.065998
//        pinData2.topText = "TopText2"
//        pinData2.bottomText = "BottomText2"

        
//        let realm = try! Realm()
//        try! realm.write {
//            realm.add(pinData1)
//            realm.add(pinData2)
//        }
     
        //MAP start
        mapView = MKMapView(frame: view.frame)
        mapView?.delegate = self
        view.addSubview(mapView!)
        //MAP end
        loadPins()
        viewUnderNavigation = UIView(frame: CGRect(x: 0 , y: 0, width: view.frame.width, height: view.frame.height * 0.19))
        viewUnderNavigation?.backgroundColor = .navigationBarBackground
        view.addSubview(viewUnderNavigation!)
        displayBarButtonItems()
        displaySearchStack()
        displayCollectionView()
        
    }
    func loadPins() {
        DispatchQueue(label: "background").async {
            let realm = try! Realm()
            let pinsRealm = realm.objects(PinData.self)
            var pins = [ImageAnnotation]()
            for pinData in pinsRealm {
                let pin = ImageAnnotation()
                pin.image = #imageLiteral(resourceName: "Pin")
                pin.coordinate = CLLocationCoordinate2D(latitude: pinData.latitude, longitude: pinData.longitude)
                let annotationView = ImageAnnotationView(annotation: pin, reuseIdentifier: "imageAnnotation")
                annotationView.image = #imageLiteral(resourceName: "Pin")
                self.mapView?.addAnnotation(pin)
                pins.append(pin)
                let pinDataGlobal = PinData()
                pinDataGlobal.bottomText = pinData.bottomText
                pinDataGlobal.topText    = pinData.topText
                pinDataGlobal.latitude   = pinData.latitude
                pinDataGlobal.longitude  = pinData.longitude
                self.dataArray.append(pinDataGlobal)
            }
            self.mapView?.showAnnotations(pins, animated: true)
        }
    }
    
    //MARK: Actions
    
    func settingsTapped() {
        print("Settings tapped")
    }
    func chatTapped() {
        print("Chat tapped")
    }
    func listButtonPressed() {
        print("ListTapped")
    }
    func filterButtonPressed() {
        print("FilterTapped")
        
    }
    
    //MARK: Configurate views
    func displayCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collectionView = UICollectionView(frame: CGRect(x: 0, y: (viewUnderNavigation?.frame.maxY)!, width: view.frame.width, height: view.frame.height * 0.07), collectionViewLayout: layout)
        collectionView?.addShadow(opacity: 1, radius: 2)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
    }
    
    func createButtonForNavBarWith( image: UIImage,target: Any,selector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.08, height: view.frame.height * 0.045)
        return button
    }
    
    func displayBarButtonItems() {
        //SettingsbarButtonitem
        let leftButton = createButtonForNavBarWith(image: #imageLiteral(resourceName: "Settings"), target: self, selector: #selector(settingsTapped))
        let leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        //ChatButton
        let rightButton = createButtonForNavBarWith(image: #imageLiteral(resourceName: "Chat"), target: self, selector: #selector(chatTapped))
        let rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func displaySearchStack() {
        let searchStackView = UIView(frame: CGRect(x: 0, y: view.frame.height * 0.12, width: view.frame.width, height:view.frame.height * 0.05))
        view.addSubview(searchStackView)
        let filterButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
        filterButton.setTitle("Filter", for: .normal)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        searchStackView.addSubview(filterButton)
        let listButton = UIButton(frame: CGRect(x: view.frame.width * 0.8, y: 0, width: view.frame.width * 0.2, height: view.frame.height * 0.05))
        listButton.setTitle("List", for: .normal)
        listButton.tintColor = .white
        listButton.addTarget(self, action: #selector(listButtonPressed), for: .touchUpInside)
        searchStackView.addSubview(listButton)
        let searchField = UITextField(frame: CGRect(x: view.frame.width * 0.2, y: searchStackView.frame.height * 0.08, width: view.frame.width * 0.6, height: view.frame.height * 0.04))
        searchField.delegate = self
        searchField.textAlignment = .center
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 4
        let searchIcon = UIImageView(frame: CGRect(x: searchField.frame.height * 0.25, y: searchField.frame.height * 0.25, width: searchField.frame.height * 0.55, height: searchField.frame.height * 0.55))
        searchIcon.image = #imageLiteral(resourceName: "search")
        searchField.addSubview(searchIcon)
        searchStackView.addSubview(searchField)
    }
    
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = testArray[indexPath.row]
        cell.label.sizeToFit()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let testLabel = UILabel()
        testLabel.text = testArray[indexPath.row]
        testLabel.sizeToFit()
        
        return CGSize(width: testLabel.frame.width + 6, height: collectionView.frame.height * 0.7)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(testArray[indexPath.row] + " tapped")
    }
    
}


extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        
        if annotation.isKind(of: MKUserLocation.self) {  //Handle user location annotation..
            return nil  //Default is to let the system handle it.
        }
        
        if !annotation.isKind(of: ImageAnnotation.self) {  //Handle non-ImageAnnotations..
            var pinAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation")
            if pinAnnotationView == nil {
                pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
            }
            return pinAnnotationView
        }
        
        //Handle ImageAnnotations..
        var view: ImageAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: "imageAnnotation") as? ImageAnnotationView
        if view == nil {
            view = ImageAnnotationView(annotation: annotation, reuseIdentifier: "imageAnnotation")
        }
        let annotation = annotation as! ImageAnnotation
        view?.image = annotation.image
        view?.canShowCallout = false
        view?.annotation = annotation
        return view
        
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let view = view as! ImageAnnotationView
      
        var data : PinData?
        for pinData in dataArray {
            if (pinData.latitude == view.annotation?.coordinate.latitude) && (pinData.longitude == view.annotation?.coordinate.longitude) {
               data = pinData
            }
        }
        guard data != nil else {return}
        
        infoView = PinInfoView(viewFrame: self.view.frame, annotationViewFrame: view.frame,image: #imageLiteral(resourceName: "test"),topText: (data?.topText)!,bottomText: (data?.bottomText)!)
        
        infoView?.alpha = 0
        infoView?.isActive = true
        
        
        view.addSubview(infoView!)
        UIView.animate(withDuration: 0.2) {
            view.image = #imageLiteral(resourceName: "PinTapped")
            self.infoView?.alpha = 1
        }
    }
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        let view = view as! ImageAnnotationView
        UIView.animate(withDuration: 0.2, animations: {
              view.image = #imageLiteral(resourceName: "Pin")
            self.infoView?.alpha = 0
        }) { (success) in
            if !(self.infoView?.isActive)! {
                self.infoView?.isActive = false
                self.infoView?.removeFromSuperview()
            }
         
        }
        
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

