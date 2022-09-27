//
//  HealingNativeAdFactory.swift
//  Runner
//
//  Created by Roman Makarenko on 2022-09-25.
//

import Foundation
import google_mobile_ads

public class HealingNativeAdFactory: FLTNativeAdFactory {

    public func createNativeAd(_ nativeAd: GADNativeAd,
                        customOptions: [AnyHashable : Any]? = nil) -> GADNativeAdView? {
        let nibView = Bundle.main.loadNibNamed("HealingGADView", owner: nil, options: nil)!.first
        let nativeAdView = nibView as! GADNativeAdView

        (nativeAdView.headlineView as! UILabel).text = nativeAd.headline

        (nativeAdView.bodyView as! UILabel).text = nativeAd.body
        nativeAdView.bodyView!.isHidden = nativeAd.body == nil

        (nativeAdView.iconView as! UIImageView).image = nativeAd.icon?.image
        nativeAdView.iconView!.isHidden = nativeAd.icon == nil
        

    
        if (nativeAd.icon == nil) {
            let filteredConstraints = (nativeAdView.iconView as! UIImageView).constraints.filter { $0.identifier == "0" }
             if let wConstraint = filteredConstraints.first {
                 changeMultiplier(wConstraint, multiplier: 0.01)
             }

        }
        
//        (nativeAdView.starRatingView as? StarRatingView)?.rating = nativeAd.starRating?.floatValue ?? 0
//          nativeAdView.starRatingView?.isHidden = nativeAd.starRating == nil
        
        
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
//        (nativeAdView.callToActionView as? UIButton)?.sizeToFit()
          nativeAdView.callToActionView?.isHidden = nativeAd.callToAction == nil
        
//        (nativeAdView.advertiserView as? UILabel)?.text = nativeAd.advertiser
//            nativeAdView.advertiserView?.isHidden = nativeAd.advertiser == nil
        
        nativeAdView.callToActionView?.isUserInteractionEnabled = false

        nativeAdView.nativeAd = nativeAd

        return nativeAdView
    }
    
    func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
          item: constraint.firstItem,
          attribute: constraint.firstAttribute,
          relatedBy: constraint.relation,
          toItem: constraint.secondItem,
          attribute: constraint.secondAttribute,
          multiplier: multiplier,
          constant: constraint.constant)

        newConstraint.priority = constraint.priority

        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])

        return newConstraint
      }
}
