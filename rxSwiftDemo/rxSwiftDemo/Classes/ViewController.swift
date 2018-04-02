//
//  ViewController.swift
//  rxSwiftDemo
//
//  Created by apple on 2018/3/28.
//  Copyright © 2018年 zzw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit
import NSObject_Rx
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "RxSwiftDemo"
        
        createUI()
        /*
         Observable : 可被观察的，事件源
         Observer : 观察者，观察者需要订阅Observable，才能受到其发出的事件
         DisposeBag : 相当于iOS中的ARC，会在适当的时候销毁观察者，自动去释放资源
         */
        //        rxObservable()
        
        
        /*
         Subjects
         Subjet是observable和Observer之间的桥梁，一个Subject既可以充当Obserable也可以充当Observer，即它可以发出事件，也可以监听事件
         */
        //        rxSubjects()
        /*
         事件流联合操作
         startWith merge zip combineLatest switchLatest
         */
        //        rxUniteOperation()
        /*
         
         */
//            rxOperators()
        
       
        
        
    }
    
    func createUI()  {
        
        let lab = UILabel().then {
            $0.text = "这是一个RxSwiftDemo"
            $0.textColor = UIColor.blue
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.backgroundColor = UIColor.gray
            $0.textAlignment = NSTextAlignment.center
            view.addSubview($0)
            $0.snp.makeConstraints({ (maker) in
                maker.top.equalTo(view).offset(84)
                maker.left.equalTo(view).offset(20)
                maker.right.equalTo(view).offset(-20)
                maker.height.equalTo(50)
            })
        }
        
        let firstTextField = UITextField().then {
            $0.placeholder = "first"
            $0.backgroundColor = UIColor.orange
            view.addSubview($0)
            
            $0.snp.makeConstraints({ (make) in
                
                make.left.right.equalTo(lab)
                make.top.equalTo(lab.snp.bottom).offset(5)
                make.height.equalTo(30)
            })
        }
        
        let secondTextField = UITextField().then {
            $0.placeholder = "second"
            $0.backgroundColor = UIColor.orange
            view.addSubview($0)
            
            $0.snp.makeConstraints({ (make) in
                
                make.left.right.equalTo(firstTextField)
                make.top.equalTo(firstTextField.snp.bottom).offset(5)
                make.height.equalTo(30)
            })
        }
        
        let btn = UIButton().then {
            $0.backgroundColor = UIColor.red
            view.addSubview($0)
            $0.snp.makeConstraints({
                
                $0.top.equalTo(secondTextField.snp.bottom).offset(5)
                $0.left.right.equalTo(secondTextField)
                $0.height.equalTo(40)
            })
        }
        
        let firstObservable = firstTextField.rx.text.map { (text) -> String in
            text! + "first"
        }
        //加一个orEmpty 就可以不用强行解包
        let secondObservable = secondTextField.rx.text.orEmpty.filter {
            
            $0.count >= 5
        }
        
        
        Observable.combineLatest(firstObservable, secondObservable) {
            "\($0)+\( $1) ,\($0.count)+\($1.count)"
            }.subscribe { (event) in
                print(event)
            }.disposed(by: rx.disposeBag)
        
        
        //kvo
        lab.rx.observeWeakly(String.self, "text").subscribe(onNext: { (text) in
            print("kvo+\(String(describing: text))")
        }).disposed(by: rx.disposeBag)
        
        
        //Rxcocoa Driver
        firstTextField.rx.text.orEmpty.asDriver().drive(lab.rx.text).disposed(by: rx.disposeBag)
        
        firstTextField.rx.text.orEmpty.asDriver().drive(btn.rx.title()).disposed(by: rx.disposeBag)
        
        //点击事件
        
        btn.rx.tap.subscribe(onNext: {  x in
           
            print(x)
            
        }).disposed(by: rx.disposeBag)
        

        
        
    }
    
    func rxObservable()  {
        //Sequence把一系列元素转换为事件序列
        let sequenceOfElements = Observable.of(1,2,3,4,5)
        
        _ = sequenceOfElements.subscribe { (event) in
            
            print(event)
        }
        //onNext 可以直接取值
        Observable.of("1","2","3").subscribe(onNext: { (str) in
            print("of2:",str)
        }).disposed(by: rx.disposeBag)
        
        // generate是创建一个可观察sequence，当初始化的条件为true的时候，他就会发出所对应的事件
        let generated = Observable.generate(
            initialState: 0, condition: {$0<20}, iterate: {$0+4}
        )
        
        _ = generated.subscribe{
            
            print($0)
        }
        
        //deferred会等到有订阅者的时候再通过工厂方法创建Observable对象，deferred会为每一为订阅者observer创建一个新的可观察序列
        var index = 1
        let deferred = Observable<String>.deferred{
            
            print("index:",index)
            index += 1
            
            return Observable.create{ observer in
                observer.onNext("1")
                observer.onNext("2")
                observer.onCompleted()
                return Disposables.create()
            }
        }
        
        deferred.subscribe { print("调用1:",$0)}.disposed(by: rx.disposeBag)
        deferred.subscribe { print("调用2:",$0)}.disposed(by: rx.disposeBag)
        
        
        //empty  创建一个空的sequence 只能发出一个completed事件
        Observable.empty().subscribe { (str :Event<String>) in
            print("empty:",str)
            }.disposed(by: rx.disposeBag)
        
        //just创建一个sequence,但只能发出一种特定的事件，能正常结束
        Observable.just("just").subscribe { (str :Event<String>) in
            print("just:",str)
            }.disposed(by: rx.disposeBag)
        
        //from从集合中创建sequence，例如数组，字典或者Set
        Observable.from([100,1000,1000]).subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: rx.disposeBag)
        
        //create 自定义可观察的sequence
        
        let createObservable = Observable.create { (observer:AnyObserver<Any>) -> Disposable in
            
            observer.onNext(1)
            observer.onNext(15)
            observer.onCompleted()
            return Disposables.create()
        }
        createObservable.subscribe {
            print($0)
            }.disposed(by: rx.disposeBag)
        
        
        //range 创建一个sequence，会发出这个范围中所有事件
        Observable.range(start: 1, count: 5).subscribe(onNext: { (num) in
            print("range:",num)
        }).disposed(by: rx.disposeBag)
        
        //创建一个sequence，发出特定的事件n次
        
        Observable.repeatElement("LouKit").take(3).subscribe { print($0)}.disposed(by: rx.disposeBag)
        
        //主要用于在subscribe中onNext，onError，onCompleted前调用
        Observable.just("00").do(onNext: {print("doOnNext:",$0)},onError: {print("doOnError:",$0)},onCompleted: {print("doOnCompleted:")})
            .subscribe(onNext: { (str) in
                print("onNext:",str)
            }, onError: { (error) in
                print("onError")
            }, onCompleted: {
                print("onCompleted")
            }).disposed(by: rx.disposeBag)
    }
    
    func rxSubjects() {
        
        
        //采用PublishSubject订阅事件的时候，只能接收到订阅他之后发生的事件
        let publicSubject = PublishSubject<String>()
        publicSubject.onNext("A")
        publicSubject.onNext("B")
        publicSubject.subscribe(onNext: {print("publicSubject:",$0)}).disposed(by: rx.disposeBag)
        publicSubject.onNext("C")
        publicSubject.onNext("D")
        
        
        //ReplaySubject
        //可以接收到订阅他之后以及之前发生的事件,对于要接受几个以前的事件取决于bufferSize设置的大小
        
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.onNext("A")
        replaySubject.onNext("B")
        replaySubject.onNext("C")
        replaySubject.onNext("D")
        replaySubject.subscribe(onNext: {print("replaySubject:",$0)}) .disposed(by: rx.disposeBag)
        replaySubject.onNext("E")
        replaySubject.onNext("F")
        replaySubject.onNext("G")
        
        //接受全部的事件
        let replaySubject2 = ReplaySubject<String>.createUnbounded()
        replaySubject2.onNext("A")
        replaySubject2.onNext("B")
        replaySubject2.subscribe(onNext: {print("replaySubject2:",$0)}) .disposed(by: rx.disposeBag)
        replaySubject2.onNext("E")
        replaySubject2.onNext("F")
        //BehaviorSubject
        
        //采用BehaviorSubject订阅事件，会接收到订阅之前的最后一个事件以及订阅之后所有事件。
        
        let behavior = BehaviorSubject(value: "behavior")
        behavior.onNext("A")
        behavior.onNext("B")
        behavior.subscribe(onNext: {print("behavior:",$0)}).disposed(by: rx.disposeBag)
        behavior.onNext("C")
        behavior.onNext("D")
        
        /*
         Variable是对BehaviorSubject一个包装；
         
         Variable当成Obserable, 让订阅者进行订阅时, 需要asObserable转成Obserable；
         
         Variable发出事件, 直接修改对象的value即可;
         
         当事件结束时,Variable会自动发出completed事件
         */
        
        let variable = Variable("variable")
        
        variable.value = "A"
        variable.value = "B"
        variable.asObservable().subscribe { (event:Event<String>) in
            print("variable:",event)
            }.disposed(by: rx.disposeBag)
        variable.value = "C"
        variable.value = "D"
        
        
        
    }
    
    func rxUniteOperation()  {
        
        //startWith   在发出事件消息之前，先发出某个特定的事件消息。
        Observable.of(1,2).startWith(3).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //merge  将多个Observable流合成单个Observable流，然后任何一个Observable发出事件都能被接收到
        
        let sub1 = PublishSubject<String>()
        let sub2 = PublishSubject<String>()
        
        Observable.of(sub1,sub2).merge().subscribe(onNext: { print($0) }).disposed(by: rx.disposeBag)
        sub1.onNext("sub1-1")
        sub1.onNext("sub1-2")
        
        sub2.onNext("sub2-1")
        sub1.onNext("sub1-2")
        sub2.onNext("sub2-2")
        
        //zip   将多个Observable流合成单个Observable流，只有当多个Observable流同时发出事件时，并且把多个Observable流的内容合并成一个元组，才会触发压缩流的事件。
        let zip1 = PublishSubject<String>()
        let zip2 = PublishSubject<String>()
        
        Observable.zip(zip1,zip2){ zip1,zip2 in
            "\(zip1) \(zip2)"
            }.subscribe(onNext: { print($0) })
            .disposed(by: rx.disposeBag)
        
        zip1.onNext("zip1-1")
        zip1.onNext("zip1-2")
        zip2.onNext("zip2-1")
        zip2.onNext("zip2-2")
        
        /*
         combineLatest
         将多个Observable流合并起来 并拿到其各个流的最新值,即每个合并的signal至少都有过一次onNext，才会触发合并的流
         */
        
        let ps1 = PublishSubject<String>()
        let ps2 = PublishSubject<String>()
        
        Observable.combineLatest(ps1, ps2) {
            "\($0) \($1)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: rx.disposeBag)
        
        ps1.onNext("ps1-01")
        ps1.onNext("ps1-02")
        ps2.onNext("ps2-01")
        
        
        /*
         switchLatest
         
         获取信号中信号最近发出信号，订阅最近发出的信号。
         eg：value 必须是信号
         触发的  bs1.onNext
         */
        
        let bs1 = BehaviorSubject(value: "1")
        let bs2 = BehaviorSubject(value: "A")
        
        let v = Variable(bs1)
        
        v.asObservable().switchLatest().subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        bs1.onNext("2")
        v.value = bs2
        bs1.onNext("3")
        bs2.onNext("B")
        
    }
    
    func rxOperators() {
        /*
         map flatMap
         map、flatMap用于把流内容映射成新的内容，但flatMap用于其内容还是流事件
         */
        Observable.of(1,2,3).map { (num) -> Int in
            num + 10
            }.subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        
        let bs1 = BehaviorSubject(value: "A")
        let bs2 = BehaviorSubject(value: "B")
        let variable = Variable(bs1)
        variable.asObservable().flatMap({$0}).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        variable.value = bs2
        
        /*
         variable.asObservable().map({$0}).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
         variable.value = bs2
         */
        
        //scan就是给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
        
        Observable.of(10, 100, 1000)
            .scan(10) { aggregateValue, newValue in
                
                aggregateValue + newValue
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: rx.disposeBag)
        
        //过滤和约束  filter  根据自身需求过滤掉一些不用的值
        Observable.of(10,20,5,9,12,8,6,28).filter { (num) -> Bool in
            
            num >= 10
            }.subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //distinctUntilChanged   监听的值发生改变时调用
        Observable.of(10,20,20,9,9,9,6,7).distinctUntilChanged().subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //处理在指定位置的事件 索引从0开始
        Observable.of(1,2,3,4,5).elementAt(2).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //只处理前几个信号
        Observable.of(10,20,30,40,50).take(2).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        //只处理后几个信号
        Observable.of(10,20,30,40,50).takeLast(2).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        //满足条件才处理 一旦不满足即使后面出现满足的条件也不会发出事件了
        Observable.of(50,30,20,40,60).takeWhile({ (num) -> Bool in
            num > 20
        }).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //接收事件消息，直到另一个sequence发出事件消息的时候才终止
        let sequence1 = PublishSubject<Int>()
        let sequence2 = PublishSubject<Int>()
        sequence1.takeUntil(sequence2).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        sequence1.onNext(10)
        sequence1.onNext(15)
        sequence2.onNext(100)
        sequence1.onNext(5)
        sequence1.onNext(20)
        
        //忽略前面几次事件
        Observable.of("A","B","C","D","E").skip(2).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        //忽略满足条件的
        Observable.of(20,29,3,8,17,15).skipWhile({$0 > 10}).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        //满足条件的都被取消，传入的闭包同skipWhile有点区别而已  根据判断信号顺序index
        Observable.of(10,11,12,13,14,15).skipWhileWithIndex { (element, index) -> Bool in
            index < 3
            }.subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //直到某个sequence发出了事件消息，才开始接收当前sequence发出的事件消息 与takeUntil相反
        let s1 = PublishSubject<String>()
        let s2 = PublishSubject<String>()
        s1.skipUntil(s2).subscribe(onNext: { print($0) }).disposed(by: rx.disposeBag)
        s1.onNext("1")
        s1.onNext("2")
        s2.onNext("A")
        s1.onNext("3")
        s1.onNext("4")
        s2.onNext("B")
        s1.onNext("5")
        
        //toArray  将sequence转换成一个array，并转换成单一事件信号，然后结束
        Observable.range(start: 1, count: 5).toArray().subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //用一个初始值，对事件数据进行累计操作。reduce接受一个初始值，和一个操作符号
        Observable.of(1,10,20).reduce(5, accumulator: +).subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        //concat会把多个sequence和并为一个sequence,只有前一个sequence发出了completed事件，才会开始下一个sequence的事件，否则下一个发出的事件将全被忽略，但最后发出的那个事件不会被忽略，该事件会在前一个sequence发出completed事件后被接收。
        
        let subject1 = BehaviorSubject(value: 10)
        let subject2 = BehaviorSubject(value: 20)
        
        let va = Variable(subject1)
        va.asObservable().concat().subscribe(onNext: {print($0)}).disposed(by: rx.disposeBag)
        
        subject1.onNext(11)
        subject1.onNext(12)
        
        va.value = subject2
        
        subject2.onNext(21) //1完成前，会被忽略
        subject2.onNext(22) //会被接收
        subject1.onCompleted()
        subject2.onNext(13)
        
        _ =  Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe(onNext: {
            
            print($0)
            
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

