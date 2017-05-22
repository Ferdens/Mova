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

private let listButtonTitle   = "List"
private let filterButtonTitle = "Filter"
class ViewController: UIViewController {
    
    var collectionView      : UICollectionView?
    var viewUnderNavigation : UIView?
    var searchStackView     : UIView?
    var infoView            : PinInfoView?
    var mapView             : MKMapView?
    var constraintsForActivation = [NSLayoutConstraint]()
    
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
        //
        //
        //        let realm = try! Realm()
        //        try! realm.write {
        //            realm.add(pinData1)
        //            realm.add(pinData2)
        //        }
        
        //MAP start
        mapView = MKMapView()
        
        mapView?.delegate = self
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView!)
        let topMapConstrint           = mapView?.topAnchor.constraint(equalTo: view.topAnchor)
        let bottmMapConstrint         = mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leadingMapConstrint      = mapView?.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingMapConstrint     = mapView?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        constraintsForActivation.append(contentsOf: [topMapConstrint!,bottmMapConstrint!,leadingMapConstrint!,trailingMapConstrint!])
        
        //MAP end
        loadPins()
        viewUnderNavigation = UIView()
        viewUnderNavigation?.translatesAutoresizingMaskIntoConstraints = false
        viewUnderNavigation?.backgroundColor = .navigationBarBackground
        view.addSubview(viewUnderNavigation!)
        let topUnderNavigationViewConstraint = viewUnderNavigation?.topAnchor.constraint(equalTo: view.topAnchor)
        let ledingUnderNavigationViewConstraint = viewUnderNavigation?.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingUnderNavigationViewConstraint = viewUnderNavigation?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let heightUnderNavigationViewConstraint = viewUnderNavigation?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12)
        constraintsForActivation.append(contentsOf:[topUnderNavigationViewConstraint!,ledingUnderNavigationViewConstraint!,trailingUnderNavigationViewConstraint!,heightUnderNavigationViewConstraint!])
        
        displayBarButtonItems()
        displaySearchStack()
        displayCollectionView()
        
        NSLayoutConstraint.activate(constraintsForActivation)
        
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
        collectionView =  UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.addShadow(opacity: 0.5, radius: 2)
        collectionView?.backgroundColor = .white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
        let topCollectionViewConstraint = collectionView?.topAnchor.constraint(equalTo: (searchStackView?.bottomAnchor)!)
        let trailingCollectionViewConstraint =  collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let leadingCollectionViewConstraint = collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let collectionViewHeightConstraints = collectionView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        constraintsForActivation.append(contentsOf: [topCollectionViewConstraint!,trailingCollectionViewConstraint!,leadingCollectionViewConstraint!,collectionViewHeightConstraints!])
        
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
        searchStackView = UIView()
        searchStackView?.backgroundColor = viewUnderNavigation?.backgroundColor
        searchStackView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchStackView!)
        let topSearchStackViewConstrint = searchStackView?.topAnchor.constraint(equalTo: (viewUnderNavigation?.bottomAnchor)!)
        let leadingSearchStackViewConstrint = searchStackView?.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingSearchStackViewConstrint = searchStackView?.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let searchStackViewHeight = searchStackView?.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05)
        constraintsForActivation.append(contentsOf: [topSearchStackViewConstrint!,leadingSearchStackViewConstrint!,trailingSearchStackViewConstrint!,searchStackViewHeight!])
        
        let filterButton = UIButton()
        filterButton.setTitle(filterButtonTitle, for: .normal)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        searchStackView?.addSubview(filterButton)
        let topFilterButtonConstraint = filterButton.topAnchor.constraint(equalTo: (searchStackView?.topAnchor)!)
        let leadingFilterButtonConstrint = filterButton.leadingAnchor.constraint(equalTo: (searchStackView?.leadingAnchor)!)
        let bottomFilterButtonConstraint = filterButton.bottomAnchor.constraint(equalTo: (searchStackView?.bottomAnchor)!)
        let filterButtonWidth            = filterButton.widthAnchor.constraint(equalTo: (searchStackView?.widthAnchor)!, multiplier: 0.2)
        constraintsForActivation.append(contentsOf: [topFilterButtonConstraint,leadingFilterButtonConstrint,bottomFilterButtonConstraint,filterButtonWidth])
        
        let listButton = UIButton()
        listButton.setTitle(listButtonTitle, for: .normal)
        listButton.tintColor = .white
        listButton.addTarget(self, action: #selector(listButtonPressed), for: .touchUpInside)
        listButton.translatesAutoresizingMaskIntoConstraints = false
        searchStackView?.addSubview(listButton)
        let trailingListButtonConstraint = listButton.trailingAnchor.constraint(equalTo: (searchStackView?.trailingAnchor)!)
        let topListButtonConstraint      = listButton.topAnchor.constraint(equalTo: (searchStackView?.topAnchor)!)
        let bottomListButtonConstraint = listButton.bottomAnchor.constraint(equalTo: (searchStackView?.bottomAnchor)!)
        let listButtonWidthConstraint  = listButton.widthAnchor.constraint(equalTo: (searchStackView?.widthAnchor)!, multiplier: 0.2)
        constraintsForActivation.append(contentsOf: [trailingListButtonConstraint,topListButtonConstraint,bottomListButtonConstraint,listButtonWidthConstraint])
        
        let searchField = UITextField()
        searchField.delegate = self
        searchField.textAlignment = .center
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 4
        searchStackView?.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        let topSearchFieldConstraint = searchField.topAnchor.constraint(equalTo: (searchStackView?.topAnchor)!)
        let heightSearchFieldConstraint = searchField.heightAnchor.constraint(equalTo: (searchStackView?.heightAnchor)!, multiplier: 0.8)
        let leadingSearchFieldConstrint = searchField.leadingAnchor.constraint(equalTo: filterButton.trailingAnchor)
        let trailingSearchFieldConstrint = searchField.trailingAnchor.constraint(equalTo: listButton.leadingAnchor)
        constraintsForActivation.append(contentsOf: [topSearchFieldConstraint,heightSearchFieldConstraint,leadingSearchFieldConstrint,trailingSearchFieldConstrint])
        
        let searchIcon = UIImageView()
        searchIcon.image = #imageLiteral(resourceName: "search")
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchField.addSubview(searchIcon)
        let topSearchIconConstraint = searchIcon.topAnchor.constraint(equalTo: searchField.topAnchor, constant: 5)
        let bottomSearchIconConstraint = searchIcon.bottomAnchor.constraint(equalTo: searchField.bottomAnchor, constant: -5)
        let leadingSearchIconConstraint = searchIcon.leadingAnchor.constraint(equalTo: searchField.leadingAnchor, constant: 5)
        let searchIconWidth           = searchIcon.widthAnchor.constraint(equalTo: searchField.heightAnchor, multiplier: 0.55)
        constraintsForActivation.append(contentsOf: [topSearchIconConstraint,bottomSearchIconConstraint,leadingSearchIconConstraint,searchIconWidth])
        
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
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if !annotation.isKind(of: ImageAnnotation.self) {
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

