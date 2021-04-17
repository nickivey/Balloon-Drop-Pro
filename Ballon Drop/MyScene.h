//
//  MyScene.h
//  Ballon Drop
//

//  Copyright (c) 2014 Nick Ivey. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameKit/GameKit.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate> {
    SKSpriteNode* _ballon;
    SKSpriteNode* _ballon2;
    SKSpriteNode* _ballon3;
    SKSpriteNode* _ballon4;
    SKSpriteNode* _ballon5;
    SKSpriteNode* _ballon6;
    SKSpriteNode* _ballon7;
    SKSpriteNode* _ballon8;
    SKSpriteNode* _menuBallon;
    SKSpriteNode* _scoresBack;
    SKLabelNode* _scoreNode;
    SKLabelNode* _ballonDrop;
    SKLabelNode* _classicButton;
    SKLabelNode* _survivalButton;
    SKLabelNode* _mainMenuButton;
    SKLabelNode* _scoreButton;
    SKLabelNode* _bestScore;
    SKLabelNode* _latestScore;
    SKLabelNode* _gameOver;
    SKLabelNode* _shareLabel;
    SKTexture* _ballonYellow;
    SKTexture* _ballonWhite;
    SKTexture* _ballonRed;
    SKTexture* _ballonPink;
    SKTexture* _ballonOrange;
    SKTexture* _ballonGreen;
    SKTexture* _ballonBlue;
    SKTexture* _ballonBlack;
    NSInteger _score;
    UIView* flash;
    
    BOOL _GameOver;
    BOOL _survival;
    int yImpulse;
    float gravity;
    float gravitySurvival;
}

@end
