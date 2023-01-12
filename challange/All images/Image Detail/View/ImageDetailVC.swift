//
//  ImageDetailVC.swift
//  challange
//
//  Created by sardar saqib on 07/01/2023.
//

import UIKit
import SDWebImage


class ImageDetailVC: UIViewController {

    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var imageSizeLabel:UILabel!
    @IBOutlet weak var imageAutherName:UILabel!
    @IBOutlet weak var favouriteimageIcon:UIImageView!
   
    
    
    var viewModel = ImageDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    @IBAction func makeFavourite(_ sender:UIButton){
        
        if viewModel.isFavorite{
            favouriteimageIcon.image = UIImage(named: Constant.unfavorite)
        }
        else{
            favouriteimageIcon.image = UIImage(named: Constant.favorite)
            viewModel.checkInFavourites()
           
        }
        viewModel.isFavorite.toggle()
        
    }
    @IBAction func backButtonTapped(_ sender:Any){
        
        self.navigationController?.popViewController(animated: true)
    }
   
}
extension ImageDetailVC{
    
    func setupView(){
        
        imageAutherName.text = viewModel.imageDetails.author ?? ""
        let width = Int(viewModel.imageDetails.width ?? 0)
        let height = Int(viewModel.imageDetails.height ?? 0)
        
        imageSizeLabel.text = "\(width) x \(height)"
        if let url = viewModel.imageDetails.downloadUrl{
            self.image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
        }
        viewModel.delegate = self
       
    }
}

// MARK: --- VIEW TO VIEWMODELE DELEGATES METHOD -----
extension ImageDetailVC:ImageDetailViewToVMDelegates{
    func didExistInFavourites(didExist: Bool, error: String) {
        if didExist{
            self.showAlertMessage(message: error)
        }
        else{
            viewModel.makeFavourite()
        }
    }
    
    func didBecomeFavourite(didBecome: Bool, error: String) {
        if didBecome{
            self.showAlertMessage(message: "Saved into favourites")
        }
        else{
            self.showAlertMessage(message: error)
        }
    }
}
