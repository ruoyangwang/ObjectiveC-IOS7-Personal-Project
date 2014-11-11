//
//  LYQTodaySpendingViewController.m
//  test
//
//  Created by Emily Liu on 2014-05-25.
//  Copyright (c) 2014 Emily Liu. All rights reserved.
//

#import "LYQTodaySpendingViewController.h"
#import "LYQGlobalVariable.h"
#import "LYQAddSpending.h"


@interface LYQTodaySpendingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *foodPropertyButton;
@property (weak, nonatomic) IBOutlet UIButton *transportationPropertyButton;

@property (weak, nonatomic) IBOutlet UIButton *billsPropertyButton;

@property (weak, nonatomic) IBOutlet UIButton *travelPropertyButton;
@property (weak, nonatomic) IBOutlet UIButton *shoppingPropertyButton;
@property (weak, nonatomic) IBOutlet UIButton *otherPropertyButton;
- (IBAction)BackButton:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)foodButton:(id)sender;
- (IBAction)transportationButton:(id)sender;
- (IBAction)travelButton:(id)sender;
- (IBAction)shoppingButton:(id)sender;
- (IBAction)otherButton:(id)sender;
- (IBAction)billsButton:(id)sender;
//- (IBAction)FoodSubButton:(id)sender;



@property (nonatomic)LYQGlobalVariable * GlobalObj; //declare Global singleton class obj

@property (nonatomic)LYQAddSpending * AddSpendingObj ;

@property (weak, nonatomic) IBOutlet UITextField *priceText;

@property (nonatomic) int CateIndicator;

@property (strong, nonatomic) IBOutlet UIPickerView *SubCatPicker;

@property (strong,nonatomic) NSArray *FoodSubCatArray;
@property (strong,nonatomic) NSArray *TransportationSubCatArray;
@property (strong,nonatomic) NSArray *BillsSubCatArray;
@property (strong,nonatomic) NSArray *TravelSubCatArray;
@property (strong,nonatomic) NSArray *ShoppingSubCatArray;
@property (strong,nonatomic) NSArray *OtherSubCatArray;
@property (strong,nonatomic) NSArray *PickerPointer;

@end

@implementation LYQTodaySpendingViewController

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_PickerPointer count];
}

//delegate definition
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_PickerPointer objectAtIndex:row];
}

//setting content and category to global
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _GlobalObj.instantCate+= row;
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
    
    //Create AddSpending Instance for taking user input
    
    _GlobalObj = [LYQGlobalVariable sharedGlobal];
    _GlobalObj.todaySpending = 0;
    _GlobalObj.instantCate = 10; //first initialze this indicator as 10, means empty
    _AddSpendingObj = [[LYQAddSpending alloc] init];
    
    //NSArray *foodSubData = [[NSArray alloc] initWithObjects:@"Coffee",@"Meals",@"Snacks", nil];
    _FoodSubCatArray =[[NSArray alloc] initWithObjects:@"Meals",@"Snacks",@"Grocery", nil];
    _TransportationSubCatArray = [[NSArray alloc] initWithObjects:@"Gasoline",@"Public Transit",@"Parking",@"Taxi", nil];
    _BillsSubCatArray = [[NSArray alloc] initWithObjects:@"Mobile",@"Electricity/Hydro",@"Insurance",@"Tuition",@"Rental",@"Loans",@"Mortgage",@"Other Fees", nil];
    _TravelSubCatArray = [[NSArray alloc] initWithObjects:@"Flight",@"Hotel",@"Rental",@"Cottage", nil];
    _ShoppingSubCatArray = [[NSArray alloc] initWithObjects:@"clothing", nil];
    _OtherSubCatArray = [[NSArray alloc] initWithObjects:@"Health Care",@"Pet Expenses", nil];
    _PickerPointer = _FoodSubCatArray;
    //[_SubCatPicker reloadAllComponents];
    [_SubCatPicker selectedRowInComponent:0];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)BackButton:(id)sender {
    [self.delegate todaySpendingViewControllerDidFinish:self];
    
}

- (IBAction)submit:(id)sender
{
    
    if(_GlobalObj.instantCate==10 || [self.priceText.text isEqualToString:@""])
    {
        UIAlertView* alert = [[UIAlertView alloc]
                              initWithTitle:@"Warning!"
                              message:@"Please enter price and select a category!"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles: nil];
        [alert show];
        //show warning message
        
    }
    else{
        //initialize dateformatter for AddDate in AddSpendingObj
        
        NSDateFormatter *dateFormat;
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE"];
        
        _AddSpendingObj.add = [self.priceText.text floatValue];
        _GlobalObj.addSpending = _AddSpendingObj.add;
        _AddSpendingObj.SetCategory = _GlobalObj.instantCate;
        
        //store date timestamp into this global
        _AddSpendingObj.AddDate = [NSDate date];
    
      
        //pass data to Global singleton class
        
        //select subcategory from picker view
        //NSString *select = [_FoodSubCatArray objectAtIndex:[_SubCatPicker selectedRowInComponent:0]];
        
        
        // _GlobalObj.Category = _AddSpendingObj.SetCategory;
        //dynamic allocate memory for temp
        LYQAddSpending * temp = [[LYQAddSpending alloc] init];
        temp.add = _AddSpendingObj.add;
        temp.SetCategory = _AddSpendingObj.SetCategory;
        temp.AddDate = _AddSpendingObj.AddDate;
        _GlobalObj.SpendingDate = _AddSpendingObj.AddDate;
        
        //now store temp into Global array for future use
        [_GlobalObj.item addObject:temp ]; //add one item to "item" array
        _AddSpendingObj.SetCategory = 10; //reset back to 10;
        
        //prepare for delegate to get back to UserMainUI
        [self.delegate todaySpendingViewControllerDidFinish:self];
        
        
        /*
        //get current day component
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
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
        }
         */
        
        [_GlobalObj calculateTodaySpending];
        
        [_GlobalObj SaveDate];
    }
    
}


//button action for categories
- (IBAction)foodButton:(id)sender {
    _PickerPointer = _FoodSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=100;
    _foodPropertyButton.selected = YES;
    _transportationPropertyButton.selected = NO;
    _billsPropertyButton.selected = NO;
    _travelPropertyButton.selected = NO;
    _shoppingPropertyButton.selected = NO;
    _otherPropertyButton.selected = NO;
    
    
    
    
}

- (IBAction)transportationButton:(id)sender {
    _PickerPointer = _TransportationSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=200;
    _foodPropertyButton.selected = NO;
    _transportationPropertyButton.selected = YES;
    _billsPropertyButton.selected = NO;
    _travelPropertyButton.selected = NO;
    _shoppingPropertyButton.selected = NO;
    _otherPropertyButton.selected = NO;
}



- (IBAction)travelButton:(id)sender {
    _PickerPointer = _TravelSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=400;
    _foodPropertyButton.selected = NO;
    _transportationPropertyButton.selected = NO;
    _billsPropertyButton.selected = NO;
    _travelPropertyButton.selected = YES;
    _shoppingPropertyButton.selected = NO;
    _otherPropertyButton.selected = NO;
}

- (IBAction)shoppingButton:(id)sender {
    _PickerPointer = _ShoppingSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=500;
    _foodPropertyButton.selected = NO;
    _transportationPropertyButton.selected = NO;
    _billsPropertyButton.selected = NO;
    _travelPropertyButton.selected = NO;
    _shoppingPropertyButton.selected = YES;
    _otherPropertyButton.selected = NO;
}

- (IBAction)otherButton:(id)sender {
    _PickerPointer = _OtherSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=600;
    _foodPropertyButton.selected = NO;
    _transportationPropertyButton.selected = NO;
    _billsPropertyButton.selected = NO;
    _travelPropertyButton.selected = NO;
    _shoppingPropertyButton.selected = NO;
    _otherPropertyButton.selected =YES;
}

- (IBAction)billsButton:(id)sender {
    _PickerPointer = _BillsSubCatArray;
    [_SubCatPicker reloadAllComponents];
    [_SubCatPicker setHidden:NO];
    _GlobalObj.instantCate=300;
    _foodPropertyButton.selected = NO;
    _transportationPropertyButton.selected = NO;
    _billsPropertyButton.selected = YES;
    _travelPropertyButton.selected = NO;
    _shoppingPropertyButton.selected = NO;
    _otherPropertyButton.selected = NO;
}




//touch anywhere to hide number pad
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *txt in self.view.subviews )
    {
        if(([txt isKindOfClass: [UITextField class]] && [txt isFirstResponder]))
        {
            [txt resignFirstResponder];
        }
    }
}



@end
