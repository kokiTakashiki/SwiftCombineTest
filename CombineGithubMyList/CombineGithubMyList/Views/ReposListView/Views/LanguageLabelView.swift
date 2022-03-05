//
//  LanguageLabelView.swift
//  CombineGithubMyList
//
//  Created by 武田孝騎 on 2022/03/05.
//

import UIKit

@IBDesignable
final class LanguageLabelView: UIView {

    // MARK: Stored Instance Properties

    // MARK: Computed Instance Properties

    // MARK: IBOutlets

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureView()
    }

    // MARK: IBActions

    // MARK: Other Internal Methods

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        configureView()
    }

    // MARK: Other Private Methods

    private func configureView() {
        loadNib()

        // TODO: 他にUIの装飾処理があれば実行する
    }

    private func loadNib() {
//        guard let LanguageLabelView = R.nib.LanguageLabelView(owner: self) else {
//            fatalError("Fail to load LanguageLabelView from Nib.")
//        }
        
        let nib = UINib(nibName: "LanguageLabelView", bundle: Bundle(for: type(of: self)))
        guard let languageLabelView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Fail to load LanguageLabelView from Nib.")
        }
        
        languageLabelView.frame = self.bounds
        addSubview(languageLabelView)
    }
}
