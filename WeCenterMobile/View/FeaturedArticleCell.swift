//
//  FeaturedArticleCell.swift
//  WeCenterMobile
//
//  Created by Darren Liu on 15/3/13.
//  Copyright (c) 2015年 Beijing Information Science and Technology University. All rights reserved.
//

import UIKit

class FeaturedArticleCell: FeaturedObjectCell {
    
    @IBOutlet weak var userAvatarView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var articleTagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatarView.layer.cornerRadius = userAvatarView.bounds.width / 2
        userAvatarView.layer.masksToBounds = true
        articleTagLabel.layer.masksToBounds = false
        articleTagLabel.layer.shadowColor = UIColor.msr_materialBlueGray900().CGColor
        articleTagLabel.layer.shadowPath = UIBezierPath(rect: articleTagLabel.bounds).CGPath
        articleTagLabel.layer.shadowOpacity = 1
        articleTagLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        articleTagLabel.layer.shadowRadius = 1
    }
    
    override func update(#object: FeaturedObject) {
        super.update(object: object)
        if !objectChanged {
            return
        }
        let object = object as! FeaturedArticle
        userAvatarView.image = UIImage(named: "DefaultAvatar")
        let user = object.article.user
        userAvatarView.msr_userInfo = user?.avatarURL
        if user?.avatarURL != nil {
            user?.fetchAvatar(
                success: {
                    [weak self] in
                    if (self?.userAvatarView.msr_userInfo as? String) == user?.avatarURL {
                        self?.userAvatarView.image = user?.avatar
                    }
                    return
                },
                failure: nil)
        }
        userNameLabel.text = object.article.user?.name ?? "匿名用户"
        articleTitle.text = object.article.title
        setNeedsLayout()
        layoutIfNeeded()
    }
    
}