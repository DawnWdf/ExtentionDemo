//
//  ViewController.m
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/5/27.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "ViewController.h"
#import <Log/Log.h>
#import "Person.h"
#import "GoodPerson.h"

#import "NSObject+Exchange.h"

#import "HHNotifier.h"

#import <objc/runtime.h>

@interface ViewController ()<NSURLSessionDelegate>
{
    NSString *_path;
    NSString *_eTag;
    
    Person *_localPerson;
}

@property (nonatomic, weak) NSArray *weakArray;

@property (nonatomic, assign) NSInteger weakInt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _eTag = @"";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 100, 200, 100);
    [button setTitle:@"request" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(request) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSArray *array = @[@"a",@"b"];
    NSInteger number = 2;
    self.weakArray = array;
    self.weakInt = number;
//    [self printData];
    
    UIButton *printButtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    printButtn.frame = CGRectMake(20, 140, 200, 100);
    [printButtn setTitle:@"print" forState:UIControlStateNormal];
    [printButtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [printButtn addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:printButtn];
    
    Person *object = [[Person alloc] init];
    object.name1 = @"vname1";
    object.name2 = @"vname2";
    object.name3 = @"vname3";
    object.name4 = @"vname4";
    _localPerson = object;
    
    BOOL isConformsCopy = class_conformsToProtocol(_localPerson.class, NSProtocolFromString(@"NSCopying"));

    NSLog(@"%@",isConformsCopy?@"yes":@"no");
    
    if (isConformsCopy) {
        NSDictionary *dic = @{object:@"value for person"};
        NSLog(@"%@",dic);
    }

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self printData];
}

- (void)printData{
    NSLog(@"%@",self.weakArray);
    NSLog(@"%ld",self.weakInt);
}
- (void)request{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ac-g3rossf7.clouddn.com/xc8hxXBbXexA8LpZEHbPQVB.jpg"]];
    [request setAllHTTPHeaderFields:@{@"Etag":_eTag}];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration  delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionDataTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields] ;
        NSLog(@"%@",headers[@"Cache-Control"]);
        NSString *cacheControl = headers[@"Cache-Control"];
        if ([cacheControl rangeOfString:@"public"].location != NSNotFound) {
            if ([cacheControl rangeOfString:@"max-age="].location != NSNotFound) {
                
            }
        }
        
        if ([(NSHTTPURLResponse *)response statusCode] == 200) {
            
            NSCachedURLResponse *neweResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            [[NSURLCache sharedURLCache] storeCachedResponse:neweResponse forRequest:request];
            
            _eTag = headers[@"Etag"];
        }else{
            
            NSCachedURLResponse *resultResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
            NSLog(@"%@",resultResponse);
        }
        
        
        
    
    }];
    [sessionTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    
}

- (void)print{
    NSLog(@"===========================");
    GoodPerson *object = [[GoodPerson alloc] init];
    object.name1 = @"vname1";
    object.name2 = @"vname2";
    object.name3 = @"vname3";
    object.name4 = @"vname4";
    
    
    NSLog(@"%@",@[@"1",@"2",@{@"keyxx":@"value",@"key2":@"value2",@"key3":@{@"1":@"xxxx",@"dic":@{@"你好啊1":@"林某某！",@"你好啊2":@"林某某！",@"你好啊3":@"林某某！",@"你好啊4":@"林某某！",@"你好啊5":@"林某某！",@"你好啊6":@"林某某！",@"你好啊7":@"林某某！"},@"axaasx":@"3"},@"key4":@"value4"},@"3",object]);
    
    //////////////////////////////////////////////
  
    /*
    NSDictionary *subDic = @{@"name1":@"subvalue1",@"name2":@"subvalue2"};
    
    NSDictionary *dicToExchange = @{@"name1":@"value1",@"name2":@"value2",@"name3":@"value3",@"name4":@"value4",@"son":subDic,@"flowers":@[subDic]};
    
    [object setValuesForKeysWithDictionary:dicToExchange];
    NSLog(@"%@",object);
    
    id model = [Person modelWithDic:dicToExchange];
    NSLog(@"%@",model);
    
    
    
    NSArray *testKeys = @[@"key1",@"key2"];
    NSDictionary *testDic = @{testKeys:@"value"};
    NSLog(@"%@",testDic);
     
     */
    
    ////////////
    [self write:object];
    [self read];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)write:(GoodPerson *)per{
    
    per.goodThings = @[@"a",@"b"];
    per.goodPersonSon = [GoodPerson new];
    per.goodFlowers = @[[GoodPerson new]];
    //准备路径:
    NSString *path = NSHomeDirectory();
    NSLog(@"%@",path);
    
    path = [path stringByAppendingPathComponent:@"singeGirl"];
    _path = path;
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3:开始归档
    [archiver encodeObject:per forKey:@"person"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        NSLog(@"归档成功:%@",path);
    }else
    {
        NSLog(@"归档不成功!!!");
    }
}

- (void)read{
    //准备解档路径
    NSData *myData = [NSData dataWithContentsOfFile:_path];
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    //反归档
    GoodPerson *aper = [GoodPerson new];
    aper = [unarchiver decodeObjectForKey:@"person"];
    //完成反归档
    [unarchiver finishDecoding];
    //测试
    NSLog(@"%@",aper.goodPersonSon);
}



/*
 //传递的参数是信号量最初值,下面例子的信号量最初值是1
 dispatch_semaphore_t signal = dispatch_semaphore_create(1);
 
 dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC);
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 
 // 当信号量是0的时候,dispatch_semaphore_wait(signal, overTime);这句代码会一直等待直到overTime超时.
 //这里信号量是1 所以不会在这里发生等待.
 dispatch_semaphore_wait(signal, overTime);
 NSLog(@"需要线程同步的操作1 开始");
 sleep(2);
 NSLog(@"需要线程同步的操作1 结束");
 long signalValue = dispatch_semaphore_signal(signal);//这句代码会使信号值 增加1
 //并且会唤醒一个线程去开始继续工作,如果唤醒成功,那么返回一个非零的数,如果没有唤醒,那么返回 0
 
 NSLog(@"%ld",signalValue);
 });
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 sleep(1);
 dispatch_semaphore_wait(signal, overTime);
 NSLog(@"需要线程同步的操作2");
 dispatch_semaphore_signal(signal);
 long signalValue = dispatch_semaphore_signal(signal);
 
 NSLog(@"%ld",signalValue);
 });
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 sleep(1);
 dispatch_semaphore_wait(signal, overTime);
 NSLog(@"需要线程同步的操作3");
 dispatch_semaphore_signal(signal);
 long signalValue = dispatch_semaphore_signal(signal);
 
 NSLog(@"%ld",signalValue);
 });
 
 /////////////////////////////////////////
 
 dispatch_group_t group = dispatch_group_create();
 dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 for (int i = 0; i < 100; i++)
 {
 dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
 //注意这里信号量从10开始递减,并不会阻塞循环.循环10次,递减到0的时候,开始阻塞.
 NSLog(@"-------");
 dispatch_group_async(group, queue, ^{
 NSLog(@"%i",i);
 sleep(1);
 dispatch_semaphore_signal(semaphore);
 });//创建一个新线程,并在线程结束后,发送信号量,通知阻塞的循环继续创建新线程.
 }
 dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
 
 ////////////////////////////////////////
 
 __block int product = 0;
 dispatch_semaphore_t sem = dispatch_semaphore_create(0);
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //消费者队列
 
 while (1) {
 if(!dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, DISPATCH_TIME_FOREVER))){
 ////非 0的时候,就是成功的timeout了,这里判断就是没有timeout   成功的时候是 0
 
 NSLog(@"消费%d产品",product);
 product--;
 };
 }
 });
 
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //生产者队列
 while (1) {
 
 sleep(1); //wait for a while
 product++;
 NSLog(@"生产%d产品",product);
 dispatch_semaphore_signal(sem);
 }
 
 });
 
 */

@end
