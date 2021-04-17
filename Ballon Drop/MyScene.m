//
//  MyScene.m
//  Ballon Drop
//
//  Created by Nick Ivey on 2/23/14.
//  Copyright (c) 2014 Nick Ivey. All rights reserved.
//

#import "MyScene.h"
#import <Social/Social.h>
#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
@implementation MyScene

static const uint32_t ballonCategory = 1 << 0;
static const uint32_t boundsCategory = 1 << 1;
static const uint32_t groundCategory = 1 << 2;

-(id)initWithSize:(CGSize)size {
    //
    
    //size = self.view.frame.size;
   // NSLog(@"SIZE: %s", size);
    
    if (self = [super initWithSize:size]) {
        float scale;
        if (IS_WIDESCREEN) {
            scale = .2;
            yImpulse = 80;
            gravity = -1.1;
            gravitySurvival = -.8;
        } else {
            scale = .17;
            yImpulse = 60;
            gravity = -1.25; //used to bve 1.3
            gravitySurvival = -.95;
        }
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        localPlayer.authenticateHandler = ^(UIViewController *receivedViewController, NSError *error){
        if (error == nil)
        {
            // Insert code here to handle a successful authentication.
            NSLog(@"Logged in.");
        }
        else
        {
            // Your application can process the error parameter to report the error to the player.
            NSLog(@"%@", [error description]);
        }
        };

        _GameOver = YES;
        
        /* Setup your scene here */
        SKColor* _skyColor = [SKColor colorWithRed:159.0/255.0 green:201.0/255.0 blue:235.0/255.0 alpha:1.0];
        [self setBackgroundColor:_skyColor];
        self.physicsWorld.gravity = CGVectorMake( 0.0, -0.03 );
        self.physicsWorld.contactDelegate = self;
        
        

        SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody = borderBody;
        self.physicsBody.friction = 0;
        self.physicsBody.categoryBitMask = boundsCategory;
        
        
        
        SKSpriteNode *spikes = [SKSpriteNode spriteNodeWithImageNamed:@"grass"];
        [spikes setScale:.8];
        spikes.position = CGPointMake(100, 30);
        [self addChild:spikes];
        
        SKNode* groundPhysics = [SKNode node];
        groundPhysics.position = CGPointMake(0, spikes.size.height - 40);
        groundPhysics.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:spikes.size];
        groundPhysics.physicsBody.dynamic = NO;
        groundPhysics.physicsBody.categoryBitMask = groundCategory;
        [self addChild:groundPhysics];
        
        
        
        
        _ballonYellow = [SKTexture textureWithImageNamed:@"yellow.png"];
        _ballonWhite = [SKTexture textureWithImageNamed:@"white.png"];
        _ballonRed = [SKTexture textureWithImageNamed:@"red.png"];
        _ballonPink = [SKTexture textureWithImageNamed:@"pink.png"];
        _ballonOrange = [SKTexture textureWithImageNamed:@"orange.png"];
        _ballonGreen = [SKTexture textureWithImageNamed:@"green.png"];
        _ballonBlue = [SKTexture textureWithImageNamed:@"blue.png"];
        _ballonBlack = [SKTexture textureWithImageNamed:@"black.png"];
        
        _ballon = [SKSpriteNode spriteNodeWithTexture:_ballonYellow];
        [_ballon setScale:scale];
        _ballon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon.physicsBody.dynamic = YES;
        _ballon.physicsBody.allowsRotation = YES;
        _ballon.physicsBody.categoryBitMask = ballonCategory;
        _ballon.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon.physicsBody.contactTestBitMask = groundCategory;
        _ballon.name = @"ballon1";
        
        _ballon2 = [SKSpriteNode spriteNodeWithTexture:_ballonWhite];
        [_ballon2 setScale:scale];
        _ballon2.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon2.physicsBody.dynamic = YES;
        _ballon2.physicsBody.allowsRotation = YES;
        _ballon2.physicsBody.categoryBitMask = ballonCategory;
        _ballon2.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon2.physicsBody.contactTestBitMask = groundCategory;
        _ballon2.name = @"ballon2";
        
        _ballon3 = [SKSpriteNode spriteNodeWithTexture:_ballonRed];
        [_ballon3 setScale:scale];
        _ballon3.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon3.physicsBody.dynamic = YES;
        _ballon3.physicsBody.allowsRotation = YES;
        _ballon3.physicsBody.categoryBitMask = ballonCategory;
        _ballon3.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon3.physicsBody.contactTestBitMask = groundCategory;
        _ballon3.name = @"ballon3";
        
        _ballon4 = [SKSpriteNode spriteNodeWithTexture:_ballonPink];
        [_ballon4 setScale:scale];
        _ballon4.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon4.physicsBody.dynamic = YES;
        _ballon4.physicsBody.allowsRotation = YES;
        _ballon4.physicsBody.categoryBitMask = ballonCategory;
        _ballon4.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon4.physicsBody.contactTestBitMask = groundCategory;
        _ballon4.name = @"ballon4";
        
        _ballon5 = [SKSpriteNode spriteNodeWithTexture:_ballonOrange];
        [_ballon5 setScale:scale];
        _ballon5.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon5.physicsBody.dynamic = YES;
        _ballon5.physicsBody.allowsRotation = YES;
        _ballon5.physicsBody.categoryBitMask = ballonCategory;
        _ballon5.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon5.physicsBody.contactTestBitMask = groundCategory;
        _ballon5.name = @"ballon5";
        
        _ballon6 = [SKSpriteNode spriteNodeWithTexture:_ballonGreen];
        [_ballon6 setScale:scale];
        _ballon6.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon6.physicsBody.dynamic = YES;
        _ballon6.physicsBody.allowsRotation = YES;
        _ballon6.physicsBody.categoryBitMask = ballonCategory;
        _ballon6.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon6.physicsBody.contactTestBitMask = groundCategory;
        _ballon6.name = @"ballon6";
        
        _ballon7 = [SKSpriteNode spriteNodeWithTexture:_ballonBlue];
        [_ballon7 setScale:scale];
        _ballon7.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon7.physicsBody.dynamic = YES;
        _ballon7.physicsBody.allowsRotation = YES;
        _ballon7.physicsBody.categoryBitMask = ballonCategory;
        _ballon7.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon7.physicsBody.contactTestBitMask = groundCategory;
        _ballon7.name = @"ballon7";
        
        _ballon8 = [SKSpriteNode spriteNodeWithTexture:_ballonBlack];
        [_ballon8 setScale:scale];
        _ballon8.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _ballon8.physicsBody.dynamic = YES;
        _ballon8.physicsBody.allowsRotation = YES;
        _ballon8.physicsBody.categoryBitMask = ballonCategory;
        _ballon8.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _ballon8.physicsBody.contactTestBitMask = groundCategory;
        _ballon8.name = @"ballon8";
        
        
        _scoreNode = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _scoreNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -100);
        _scoreNode.zPosition = 100;
        _scoreNode.text = [NSString stringWithFormat:@"%ld", (long) _score];
        
        //Gameover start
        _scoresBack = [SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
        _scoresBack.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -200);
        _scoresBack.zPosition = 100;
        [_scoresBack setScale:.5];
        
        _gameOver = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _gameOver.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -100);
        _gameOver.zPosition = 100;
        _gameOver.fontSize = 50;
        _gameOver.text = [NSString stringWithFormat:@"Game Over"];
        
        _latestScore = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _latestScore.position = CGPointMake(CGRectGetMidX(self.frame) + 20, CGRectGetMaxY(self.frame) -189);
        _latestScore.zPosition = 100;
        _latestScore.fontSize = 30;

        _bestScore = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _bestScore.position = CGPointMake(CGRectGetMidX(self.frame) + 20, CGRectGetMaxY(self.frame) -232);
        _bestScore.zPosition = 100;
        _bestScore.fontSize = 30;

        
        //Game Over end
        
        //Main menu
        _ballonDrop = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _ballonDrop.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -100);
        _ballonDrop.zPosition = 100;
        _ballonDrop.fontSize = 40;
        _ballonDrop.text = [NSString stringWithFormat:@"Balloon Drop Pro"];
        
        _classicButton = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _classicButton.position = CGPointMake(CGRectGetMidX(self.frame) - 90, CGRectGetMaxY(self.frame) -300);
        _classicButton.zPosition = 100;
        _classicButton.fontSize = 30;
        _classicButton.text = [NSString stringWithFormat:@"Classic"];
        _classicButton.name = @"classic";
        
        _mainMenuButton = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _mainMenuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 90, CGRectGetMaxY(self.frame) -300);
        _mainMenuButton.zPosition = 100;
        _mainMenuButton.fontSize = 30;
        _mainMenuButton.text = [NSString stringWithFormat:@"Menu"];
        _mainMenuButton.name = @"mainmenu";
        
        _survivalButton = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _survivalButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -380);
        _survivalButton.zPosition = 100;
        _survivalButton.fontSize = 30;
        _survivalButton.text = [NSString stringWithFormat:@"Survival"];
        _survivalButton.name = @"survival";
        
        _scoreButton = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _scoreButton.position = CGPointMake(CGRectGetMidX(self.frame) + 80, CGRectGetMaxY(self.frame) -300);
        _scoreButton.zPosition = 100;
        _scoreButton.fontSize = 30;
        _scoreButton.text = [NSString stringWithFormat:@"Scores"];
        _scoreButton.name = @"scores";
        
        
        _shareLabel = [SKLabelNode labelNodeWithFontNamed:@"MarkerFelt-Wide"];
        _shareLabel.position =  CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) -410);
        _shareLabel.zPosition = 100;
        _shareLabel.fontSize =30;
        _shareLabel.text = @"Share";
        _shareLabel.name = @"share";
        
        _menuBallon = [SKSpriteNode spriteNodeWithTexture:_ballonWhite];
        [_menuBallon setScale:scale];
        _menuBallon.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ballon.size.height / 2];
        _menuBallon.physicsBody.dynamic = YES;
        _menuBallon.physicsBody.allowsRotation = YES;
        _menuBallon.physicsBody.categoryBitMask = ballonCategory;
        _menuBallon.physicsBody.collisionBitMask = groundCategory | boundsCategory;
        _menuBallon.name = @"BalMenu";
        _menuBallon.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100);

        
        
        [self addChild:_menuBallon];
        [self addChild:_ballonDrop];
        [self addChild:_classicButton];
        [self addChild:_survivalButton];
        [self addChild:_scoreButton];
    }
    return self;
}
-(void)startClassicGame {
    _survival = NO;
    _bestScore.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"hiScores"]];
    _score = 0;
    _scoreNode.text = [NSString stringWithFormat:@"%ld", (long) _score];
    [_scoresBack removeFromParent];
    [_gameOver removeFromParent];
    [_classicButton removeFromParent];
    [_survivalButton removeFromParent];
    [_scoreButton removeFromParent];
    [_menuBallon removeFromParent];
    [_latestScore removeFromParent];
    [_bestScore removeFromParent];
    [_shareLabel removeFromParent];
    self.physicsWorld.gravity = CGVectorMake( 0.0, gravity );
    [_ballonDrop removeFromParent];
    
    [self addChild:_scoreNode];
    _GameOver = NO;
    _ballon.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon4.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon5.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon6.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMaxY(self.frame));
    _ballon7.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMaxY(self.frame));
    _ballon8.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    
    [self addChild:_ballon];
}

-(void)startSurvivalGame {
    _survival = YES;
    _bestScore.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"hiScoresSurvival"]];
    _score = 0;
    _scoreNode.text = [NSString stringWithFormat:@"%ld", (long) _score];
    [_scoresBack removeFromParent];
    [_gameOver removeFromParent];
    [_classicButton removeFromParent];
    [_survivalButton removeFromParent];
    [_scoreButton removeFromParent];
    [_menuBallon removeFromParent];
    [_latestScore removeFromParent];
    [_bestScore removeFromParent];
    [_shareLabel removeFromParent];
    self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival);
    [_ballonDrop removeFromParent];
    
    [self addChild:_scoreNode];
    _GameOver = NO;
    _ballon.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon3.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon4.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon5.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    _ballon6.position = CGPointMake(CGRectGetMidX(self.frame) - 50, CGRectGetMaxY(self.frame));
    _ballon7.position = CGPointMake(CGRectGetMidX(self.frame) + 50, CGRectGetMaxY(self.frame));
    _ballon8.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
    
    [self addChild:_ballon];

    //TODO
}
-(void)endGame {
    [self reportHighScore:_score];
    if (_survival) {
        int hiScore = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hiScoresSurvival"];
        if (hiScore < _score) {
            [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"hiScoresSurvival"];
        }
    } else {
    int hiScore = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hiScores"];
    if (hiScore < _score) {
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"hiScores"];
        
        }
    }
    
    [_ballon removeFromParent];
    [_ballon2 removeFromParent];
    [_ballon3 removeFromParent];
    [_ballon4 removeFromParent];
    [_ballon5 removeFromParent];
    [_ballon6 removeFromParent];
    [_ballon7 removeFromParent];
    [_ballon8 removeFromParent];
    
    _GameOver = YES;
    
    [_scoreNode removeFromParent];
    _mainMenuButton.position = CGPointMake(CGRectGetMidX(self.frame) - 90, CGRectGetMaxY(self.frame) -350);
    _scoreButton.position = CGPointMake(CGRectGetMidX(self.frame) + 80, CGRectGetMaxY(self.frame) -350);
    _latestScore.text = [NSString stringWithFormat:@"%ld", (long)_score];
    
    
    flash = [[UIView alloc] initWithFrame:self.view.frame];
    flash.backgroundColor = [UIColor whiteColor];
    flash.alpha = .9;
    [self.view insertSubview:flash belowSubview:self.view];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self.view  center].x - 4.0f, [self.view  center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.view  center].x + 4.0f, [self.view  center].y)]];
    [[self.view layer] addAnimation:animation forKey:@"position"];
    
    
    [UIView animateWithDuration:.6 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        // Display game over
        flash.alpha = 0;
        //  self.gameOverView.alpha = 1;
        //    self.gameOverView.transform = CGAffineTransformMakeScale(1, 1);
        //
        /* // Set medal
         if(scene.score >= 40){
         self.medalImageView.image = [UIImage imageNamed:@"medal_platinum"];
         }else if (scene.score >= 30){
         self.medalImageView.image = [UIImage imageNamed:@"medal_gold"];
         }else if (scene.score >= 20){
         self.medalImageView.image = [UIImage imageNamed:@"medal_silver"];
         }else if (scene.score >= 10){
         self.medalImageView.image = [UIImage imageNamed:@"medal_bronze"];
         }else{
         self.medalImageView.image = nil;
         }
         
         // Set scores
         self.currentScore.text = F(@"%li",(long)scene.score);
         self.bestScoreLabel.text = F(@"%li",(long)[Score bestScore]);
         */
    } completion:^(BOOL finished) {
        [self addChild:_scoresBack];
        [self addChild:_gameOver];
        [self addChild:_mainMenuButton];
        [self addChild:_scoreButton];
        [self addChild:_latestScore];
        [self addChild:_bestScore];
        [self addChild:_shareLabel];
        
    }];
    
    
}
CGFloat clamp(CGFloat min, CGFloat max, CGFloat value) {
    if( value > max ) {
        return max;
    } else if( value < min ) {
        return min;
    } else {
        return value;
    }
}
- (void) reportHighScore:(NSInteger) highScore {
    NSLog(@"reported");
    if (_survival) {
        if ([GKLocalPlayer localPlayer].isAuthenticated) {
            GKScore* Rscore = [[GKScore alloc] initWithLeaderboardIdentifier:@"grp.survival2"];
            Rscore.value = highScore;
            [GKScore reportScores:@[Rscore] withCompletionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",[error localizedDescription]);
                }
            }];
        }

    } else {
        if ([GKLocalPlayer localPlayer].isAuthenticated) {
            GKScore* Rscore = [[GKScore alloc] initWithLeaderboardIdentifier:@"grp.hiScores"];
            Rscore.value = highScore;
            [GKScore reportScores:@[Rscore] withCompletionHandler:^(NSError *error) {
                if (error) {
                    NSLog(@"%@",[error localizedDescription]);
                }
            }];
        }

    }
   }
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController {
    
    UIViewController *vc = self.view.window.rootViewController;
    [vc dismissViewControllerAnimated:YES completion:nil];
}

-(void)update:(CFTimeInterval)currentTime {
    
if (!_survival) {

    if (_score == 5) {
        [self addChild:_ballon2];
        _score++;
    } else if (_score == 10) {
        [self addChild:_ballon3];
        _score++;
    } else if (_score == 30) {
        [self addChild:_ballon4];
        _score++;
    } else if (_score == 60) {
        [self addChild:_ballon5];
        _score++;
    } else if (_score == 100) {
        [self addChild:_ballon6];
        _score++;
    } else if (_score == 150) {
        [self addChild:_ballon7];
        _score++;
    } else if (_score == 200) {
        [self addChild:_ballon8];
        _score++;
    }
} else {
    int ran = arc4random() % 4;
    if (_score == 2) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon2];
                  self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .1);
            }
        }];
        _score++;
    } else if (_score == 5) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon3];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .15);
            }
        }];
        _score++;
    } else if (_score == 10) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon4];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .2);
            }
        }];
        _score++;
    } else if (_score == 20) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon5];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .22);
            }
        }];
        _score++;
    } else if (_score == 30) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon6];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .25);
            }
        }];
        _score++;
    } else if (_score == 50) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon7];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .27);
            }
        }];
        _score++;
    } else if (_score == 80) {
        SKAction *waitRandom = [SKAction waitForDuration:ran];
        [self runAction:waitRandom completion:^{
            if (!_GameOver) {
                [self addChild:_ballon8];
                 self.physicsWorld.gravity = CGVectorMake( 0.0, gravitySurvival - .3);
            }
        }];
        _score++;
    }

    
}
    /* Called before each frame is rendered */
        _ballon.zRotation = clamp( -1 , 3, _ballon.physicsBody.velocity.dy * ( _ballon.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _menuBallon.zRotation = clamp( -1 , 3, _ballon.physicsBody.velocity.dy * ( _ballon.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon2.zRotation = clamp( -1 , 3, _ballon2.physicsBody.velocity.dy * ( _ballon2.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon3.zRotation = clamp( -1 , 3, _ballon3.physicsBody.velocity.dy * ( _ballon3.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon4.zRotation = clamp( -1 , 3, _ballon4.physicsBody.velocity.dy * ( _ballon4.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon5.zRotation = clamp( -1 , 3, _ballon5.physicsBody.velocity.dy * ( _ballon5.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon6.zRotation = clamp( -1 , 3, _ballon6.physicsBody.velocity.dy * ( _ballon6.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon7.zRotation = clamp( -1 , 3, _ballon7.physicsBody.velocity.dy * ( _ballon7.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
        _ballon8.zRotation = clamp( -1 , 3, _ballon8.physicsBody.velocity.dy * ( _ballon8.physicsBody.velocity.dy < 0 ? 0.003 : 0.001 ) );
   }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:touchLocation];
  //  NSLog(@"node %@ was touched", node.name);
    
    if([node.name hasPrefix:@"ballon"] & !_GameOver) {
        
        if (_survival) {
            //TODO white pop anima
            [node removeFromParent];
            node.position =  CGPointMake(0 + (arc4random() % 300), CGRectGetMaxY(self.frame));
            int ran = arc4random() % 2;
            SKAction *waitRandom = [SKAction waitForDuration:ran];
            [self runAction:waitRandom completion:^{
                if (!_GameOver) {
                    node.alpha = 0;
                     [self addChild:node];
                    SKAction *fadein = [SKAction fadeInWithDuration:0.3];
                    [node runAction:fadein];
                }
            }];
           // node.physicsBody.velocity = CGVectorMake(0, 0);
            _score++;
            _scoreNode.text = [NSString stringWithFormat:@"%ld", (long) _score];
        } else {
            //node.physicsBody.velocity = CGVectorMake(0, 0);
            int rand;
            if (IS_WIDESCREEN) {
                rand = (arc4random() % 60) - 30;
            } else {
                rand = (arc4random() % 40) - 20;
            }
            [node.physicsBody applyImpulse:CGVectorMake(rand, yImpulse)];//6 before
            
            // NSLog(@"Random X impulse is %ld", (long)rand);
            _score++;
            _scoreNode.text = [NSString stringWithFormat:@"%ld", (long) _score];

        }
    }
    
    if([node.name hasPrefix:@"BalMenu"]) {
        //node.physicsBody.velocity = CGVectorMake(0, 0);
        int rand;
        if (IS_WIDESCREEN) {
            rand = (arc4random() % 60) - 30;
        } else {
            rand = (arc4random() % 40) - 20;
        }
        [node.physicsBody applyImpulse:CGVectorMake(rand, yImpulse)];//6 before
    }
    if ([node.name hasPrefix:@"mainmenu"]) {
        self.physicsWorld.gravity = CGVectorMake( 0.0, -0.03 );
        [self addChild:_menuBallon];
        [self addChild:_ballonDrop];
        [self addChild:_classicButton];
        [self addChild:_survivalButton];
        [_shareLabel removeFromParent];
        [_mainMenuButton removeFromParent];
        [_gameOver removeFromParent];
        [_scoresBack removeFromParent];
        [_scoreNode removeFromParent];
        [_bestScore removeFromParent];
        [_latestScore removeFromParent];
        _scoreButton.position = CGPointMake(CGRectGetMidX(self.frame) + 80, CGRectGetMaxY(self.frame) -300);
    }
    if ([node.name hasPrefix:@"classic"] & _GameOver) {
        [self startClassicGame];
    }
    if ([node.name hasPrefix:@"survival"] & _GameOver) {
        [self startSurvivalGame];
    }
    if ([node.name hasPrefix:@"scores"]) {
        GKGameCenterViewController* gameCenterController = [[GKGameCenterViewController alloc] init];
        gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gameCenterController.gameCenterDelegate = (id)self;
        UIViewController *vc = self.view.window.rootViewController;
        [vc presentViewController: gameCenterController animated: YES completion:nil];
    }
    
    if ([node.name hasPrefix:@"share"]) {
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            NSString *tweetText;
            if (_survival) {
            tweetText =[NSString stringWithFormat:@"I just scored %@ on BALLOON DROP SURVIVAL MODE \n Bet you can't beat it!", _latestScore.text];
                [tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/balloon-drop/id851862077?mt=8"]];    //ADD PRO
            } else {
            tweetText =[NSString stringWithFormat:@"I just scored %@ on BALLOON DROP! \n Bet you can't beat it!", _latestScore.text];
            [tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/balloon-drop/id851862077?mt=8"]];
            }
            [tweetSheet setInitialText:tweetText];
            UIViewController *vc = self.view.window.rootViewController;
            [vc presentViewController:tweetSheet animated:YES completion:nil];
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Sorry"
                                      message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
        }

    }
}
-(void)didBeginContact:(SKPhysicsContact *)contact {
    
    if ((contact.bodyA.collisionBitMask & groundCategory) == groundCategory || (contact.bodyB.collisionBitMask & groundCategory) == groundCategory) {
        if (_GameOver == NO) {
            [self endGame];
        }
       
    }
}

@end
