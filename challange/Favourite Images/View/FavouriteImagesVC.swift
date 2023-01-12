//
//  FavouriteImagesVC.swift
//  challange
//
//  Created by sardar saqib on 07/01/2023.
//

import UIKit

class FavouriteImagesVC: UIViewController {
    
    @IBOutlet weak var favouriteImagesCollectionView:UICollectionView!
    
    var viewModel = FavouriteImagesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
}
extension FavouriteImagesVC{
    func setupView(){
        self.navigationController?.isNavigationBarHidden = true
        favouriteImagesCollectionView.dataSource = self
        favouriteImagesCollectionView.delegate = self
        viewModel.delegate = self
        viewModel.getFavouriteImages()
    }
}
extension FavouriteImagesVC:FavouriteImagesViewToVMDelegates{
    func didRecieveFavouriteImages(didRevieve: Bool) {
        DispatchQueue.main.async {
            self.favouriteImagesCollectionView.reloadData()
        }
    }
}
extension FavouriteImagesVC:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favouriteImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favouriteImagesCollectionView.register(AllImagesCollectionViewCell.self, indexPath: indexPath)
        cell.configCell(imageURL: viewModel.favouriteImages[indexPath.row].downloadUrl ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let refVC = ImageDetailVC()
        refVC.viewModel.imageDetails = viewModel.favouriteImages[indexPath.row]
        self.navigationController?.pushViewController(refVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth : CGFloat = (collectionView.frame.width / CGFloat(viewModel.numberOfCellInRow)) - 1
        let totalHeight : CGFloat = viewModel.collectionViewCellHeight
        
        return CGSizeMake(ceil(totalWidth), ceil(totalHeight))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0 // Adjust the inter item space based on the requirement.
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return viewModel.collectionviewLineSpacing
    }
}
