//
//  LYQUserMainViewController.m
//  test
//
//  Created by Emily Liu on 2014-05-24.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQUserMainViewController.h"
#import "LYQGlobalVariable.h"
#import "LYQAddSpending.h"
#import "LYQArrayClassObject.h"
@interface LYQUserMainViewController ()
@property (nonatomic) IBOutlet UITextField *TodaySpendingField;
@property (nonatomic, retain) IBOutlet UIDatePicker *DateViewer;
@property(nonatomic,retain) IBOutlet UILabel *datelabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@property (nonatomic)LYQGlobalVariable * GlobalObj; //declare Global singleton class obj
@property (weak, nonatomic) IBOutlet UITableView *TransactionTable;

@property (nonatomic) LYQArrayClassObject* transactionObject;
@end

@implementation LYQUserMainViewController

//method for makeing progress bar moving
- (void)makeMyProgressBarMoving {
    
    float actual = [self.progressBar progress];
    if (actual < 1) {
        self.progressBar.progress =  ((float)_GlobalObj.todaySpending/(float)_GlobalObj.todaySpendingLimit);
        [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(makeMyProgressBarMoving) userInfo:nil repeats:NO];
        if((float)actual<0.7)
        {
            [self.progressBar setProgressTintColor:[UIColor blueColor]];
        }
        else
        {
            [self.progressBar setProgressTintColor:[UIColor orangeColor]];
        }
    }
    else if(actual == 1)
    {
        if((float)_GlobalObj.todaySpending>(float)_GlobalObj.todaySpendingLimit)
        {
            [self.progressBar setProgressTintColor:[UIColor redColor]];
        }
        else
        {
            [self.progressBar setProgressTintColor:[UIColor orangeColor]];
        }
    }
    
    else if(actual >1){
        
        [self.progressBar setProgressTintColor:[UIColor redColor]];
        
    }
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _GlobalObj= [LYQGlobalVariable sharedGlobal];
    _transactionObject = [[LYQArrayClassObject alloc] init];
    //initialize the load from file, to show todayspending number
    //--------------------calculation for the first time load from file to display on main user viewer------------------------
    NSString * path = [_GlobalObj GetFilePath];
    bool FileExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if(FileExist){
       /* NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger month = [components month];
        NSInteger year = [components year];
        //calculate spending for UserMainUI use
        for(LYQAddSpending * temp in _GlobalObj.item)
        {
            //get the global array object day component and do comparison
            NSDateComponents *tempcomponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:temp.AddDate];
            NSInteger tempday = [tempcomponents day];
            NSInteger tempmonth = [tempcomponents month];
            NSInteger tempyear = [tempcomponents year];
            
            //
            //if(tempday != day || tempmonth!= month || tempyear!= year)
            if(tempday==day&& tempmonth==month && tempyear==year)
            {
                _GlobalObj.todaySpending += temp.add;
            }
        }*/
        
        [_GlobalObj calculateTodaySpending];
        [_transactionObject PrepareForMonthTransectionArray];   //for testing purpose only
        [_transactionObject PrepareForDailyTransectionArray];
        [_transactionObject PrepareForYearTransectionArray];
    }
    //----------------------------------------------------------------------------------------------------------------------------
    
  //  NSString * temp =[NSString stringWithFormat:@"%1.2f", _GlobalObj.todaySpending];
   // _TodaySpendingField.text = temp;
    self.DateViewer.frame = CGRectMake(0, 0, 320, 80);
    self.DateViewer.transform = CGAffineTransformMakeScale(.6, 0.6);
    [self.view addSubview:_DateViewer];
    
     _progressBar.progress = 0.0;
  /*  CGRect temp;
    temp.origin.x = 150;
    temp.origin.y = 200;
    temp.size.height =0.8;
    temp.size.width =0.8;
    
   //[_TransactionTable initWithFrame:temp style:UITableViewStylePlain];
    _TransactionTable.hidden = NO;*/  //does not control the UI
}

- (void)viewDidAppear:(BOOL)animated
{
   
    NSString * temp =[NSString stringWithFormat:@"%1.2f", _GlobalObj.todaySpending];
    _TodaySpendingField.text = temp;
    [_DateViewer setDate:_GlobalObj.SpendingDate animated:YES];
    if(_GlobalObj.todaySpendingLimit >= _GlobalObj.todaySpending)
    {
        if(((float)_GlobalObj.todaySpendingLimit - (float)_GlobalObj.todaySpending)/((float)_GlobalObj.todaySpendingLimit )> 0.3 )
        {
            self.progressLabel.text = @"On track";
            self.progressLabel.textColor = [UIColor greenColor];
        }
        else
        {
            self.progressLabel.text = @"At risk";
            self.progressLabel.textColor = [UIColor orangeColor];
        }
    }
    //make risk option for user, need to implement further
    else if(_GlobalObj.todaySpendingLimit < _GlobalObj.todaySpending)
    {
        self.progressLabel.text = @"Exceeded";
        self.progressLabel.textColor = [UIColor redColor];
    }
    [self performSelectorOnMainThread:@selector(makeMyProgressBarMoving) withObject:nil waitUntilDone:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"showTodaySpending"])
    {
        [[segue destinationViewController]setDelegate:self];
        
    }
    
}

//setting table view rows and section
/*
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//setting section of the table
- (NSInteger)numberOfSections
{
    return 1;
}
 */


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) todaySpendingViewControllerDidFinish:(LYQTodaySpendingViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
