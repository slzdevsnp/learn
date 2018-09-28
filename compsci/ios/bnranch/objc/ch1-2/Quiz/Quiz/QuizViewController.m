//
//  QuizViewController.m
//  Quiz
//
//  Created by Sviatoslav Zimine on 5/16/17.
//  Copyright © 2017 szimine. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions; 
@property (nonatomic, copy) NSArray *answers;

@end

@implementation QuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     
    //code below in viewDidLoad also works
     
    // Do any additional setup after loading the view from its nib.
    
    self.questions = @[@"From what is cognac made?",
                       @"What is 7+7 ?",
                       @"What is the capital of Vermont?",
                       @"What is a Pi constant"];
    
    self.answers = @[@"Grapes",
                     @"14",
                     @"Montpelier",
                     @"3.14"];
    */
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil
   								bundle:(NSBundle *)nibBundleOrNil
{
    //call a method from a superClass
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
    	//create two arrays with questions and answers

    	self.questions = @[@"From what is cognac made?",
    						@"What is 7+7 ?",
    						@"What is the capital of Vermont?",
    						@"What is a Pi constant"];

    	self.answers = @[@"Grapes",
    						@"14",
    						@"Montpelier",
    						@"3.14"];

    }
    return self;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showQuestion:(id)sender {
	//move to next question
    self.currentQuestionIndex++;
	//did we reach the end ? rewind
	if (self.currentQuestionIndex == [self.questions count]){
		self.currentQuestionIndex = 0;
	}
	NSString *currentQuestion = self.questions[self.currentQuestionIndex];
	//display it in th elabel
	self.questionLabel.text = currentQuestion;
	//reset the answer label 
	self.answerLabel.text = @"???";

}

- (IBAction)showAnswer:(id)sender {
	//the the answer to the current question
	NSString *answer = self.answers[self.currentQuestionIndex];

	//display it
	self.answerLabel.text = answer;
}


@end
