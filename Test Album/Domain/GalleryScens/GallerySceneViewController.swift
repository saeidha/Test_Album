//
//  GalleryScensViewController.swift
//  Test Album
//
//  Created by saeid on 8/30/22.
//

import UIKit

protocol GallerySceneInput: AnyObject
{
    /// Successfull Fetch Gallery items
    func successFetchedItems()
    /// Fail Fetch Gallery items
    func errorFetchingItems()
}

final class GallerySceneViewController: UIViewController{
    
    // MARK: - Public Property
    var interactor: GalleryInteractorBusinessLogic?
    var router: GallerySceneRouter?
    
    // MARK: - Private Property
    fileprivate lazy var loader: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    fileprivate lazy var galleryCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.register(GallerySceneViewCell.self, forCellWithReuseIdentifier: String(describing: GallerySceneViewCell.self))
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var photos: [PhotoModel.Fetch.ViewModel]?
    fileprivate var collectionCellSize: CGFloat?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.title = "Gallery"
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: .init(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(reload))
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: - Public Methods
    /// reload Collections
    @objc func refresh(){
        
    }
    /// reload Collections
    @objc func reload(){
        
    }
    
    // MARK: - Private Methods
    /// Setup UI Views
    fileprivate func setupViews(){
        
        self.loader.color = .black
        self.galleryCollectionView.backgroundColor = UIColor.white
        
        self.view.addSubviews(self.galleryCollectionView, self.loader)
        self.view.addSubview(self.loader)
        self.galleryCollectionView.addSubview(refreshControl)
        
        // Add Constraints
        self.galleryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.galleryCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.galleryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.galleryCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.galleryCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        self.loader.translatesAutoresizingMaskIntoConstraints = false
        self.loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.loader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.loader.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
   
}

// Setup collection views
extension GallerySceneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // Setup Collection View number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    // Setup Collection View cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  String(describing: GallerySceneViewCell.self), for: indexPath) as? GallerySceneViewCell else{return UICollectionViewCell()}
        
        return cell
    }
    
    // Setup Collection View Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3
        self.collectionCellSize = width
        return CGSize(width: width , height: width)
    }
}


extension GallerySceneViewController: GallerySceneInput{
    // MARK: - GalleryScene inputs
    
    func successFetchedItems() {
    }
    
    func errorFetchingItems() {
    }
}
