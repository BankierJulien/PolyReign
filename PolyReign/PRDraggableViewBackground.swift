//
//  PRDraggableViewBackground.swift
//  PolyReign
//
//  Created by Julien Bankier on 2/28/17.
//  Copyright © 2017 Julien Bankier. All rights reserved.
//

import Foundation
import UIKit

class PRDraggableViewBackground: UIView, PRDraggableViewDelegate {
    var exampleCardLabels: [String]!
    var allCards: [PRDraggableView]!
    
    let MAX_BUFFER_SIZE = 2
    let CARD_HEIGHT: CGFloat = 386
    let CARD_WIDTH: CGFloat = 290
    
    var cardsLoadedIndex: Int!
    var loadedCards: [PRDraggableView]!
    var menuButton: UIButton!
    var messageButton: UIButton!
    var checkButton: UIButton!
    var xButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.layoutSubviews()
        self.setupView()
        exampleCardLabels = ["first", "second", "third", "fourth", "last","t"]
        allCards = []
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }
    
    func setupView(){
        self.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1)
        
        xButton = UIButton(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2 + 35, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        xButton.setImage(UIImage(named: "xButton"), forState: UIControlState.Normal)
        xButton.addTarget(self, action: #selector(PRDraggableViewBackground.swipeLeft), forControlEvents: UIControlEvents.TouchUpInside)
        
        checkButton = UIButton(frame: CGRectMake(self.frame.size.width/2 + CARD_WIDTH/2 - 85, self.frame.size.height/2 + CARD_HEIGHT/2 + 10, 59, 59))
        checkButton.setImage(UIImage(named: "checkButton"), forState: UIControlState.Normal)
        checkButton.addTarget(self, action: #selector(PRDraggableViewBackground.swipeRight), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(xButton)
        self.addSubview(checkButton)
    }
    
    func createDraggableViewWithDataAtIndex(index: NSInteger) -> PRDraggableView {
        let draggableView = PRDraggableView(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/2, CARD_WIDTH, CARD_HEIGHT))
        draggableView.information.text = exampleCardLabels[index]
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() {
        if exampleCardLabels.count > 0 {
            let numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            for i in 0 ..< exampleCardLabels.count {
                let newCard: PRDraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                if i < numLoadedCardsCap {
                    loadedCards.append(newCard)
                }
            }
            
            for i in 0 ..< loadedCards.count {
                if i > 0 {
                    self.insertSubview(loadedCards[i], belowSubview: loadedCards[i - 1])
                } else {
                    self.addSubview(loadedCards[i])
                }
                cardsLoadedIndex = cardsLoadedIndex + 1
            }
        }
    }
    
    func cardSwipedLeft(card: UIView) {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func cardSwipedRight(card: UIView) {
        loadedCards.removeAtIndex(0)
        
        if cardsLoadedIndex < allCards.count {
            loadedCards.append(allCards[cardsLoadedIndex])
            cardsLoadedIndex = cardsLoadedIndex + 1
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE - 1], belowSubview: loadedCards[MAX_BUFFER_SIZE - 2])
        }
    }
    
    func swipeRight() {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: PRDraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() {
        if loadedCards.count <= 0 {
            return
        }
        let dragView: PRDraggableView = loadedCards[0]
        dragView.overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        UIView.animateWithDuration(0.2, animations: {
            () -> Void in
            dragView.overlayView.alpha = 1
        })
        dragView.leftClickAction()
    }
}

