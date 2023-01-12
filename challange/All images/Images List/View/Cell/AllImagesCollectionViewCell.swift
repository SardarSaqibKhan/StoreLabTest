//
//  AllImagesCollectionViewCell.swift
//  challange
//
//  Created by sardar saqib on 06/01/2023.
//

import UIKit
import SDWebImage

class AllImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configCell(imageURL:String){
      
        self.image.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.image.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder"))
       
         
    }

}
