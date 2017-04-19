![image](https://github.com/ZHShare/XFetchCodeButton/blob/master/fetchCode.gif)

有OC版本和swift版本：

For OC:
...
    XFetchCodeButton * button = [[XFetchCodeButton alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    
    [button doneSend:^{
        NSLog(@"button click");
    }];
    
    button2.backgroundColor = [UIColor purpleColor];
    button2.disabledColor = [UIColor whiteColor];
    button2.normalTitle = @"Fetch Code";
    button2.normalTintColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(send) forEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    ...
    - (void)send {
      NSLog(@"button2 click");
    }
    
For Swift:
...
        let codeButton = XFetchCodeButton(frame: CGRect(x: 20, y: 100, width: 100, height: 50))
        codeButton.backgroundColor = .black
        codeButton.normalTitle = "Fetch Code"
        codeButton.normalTintColor = UIColor.white
        self.view.addSubview(codeButton)
        
        codeButton.doneSend {
            print("codeButton 已发送")
        }
        
        let codeButton2 = XFetchCodeButton(frame: CGRect(x: 20, y: 200, width: 100, height: 50))
        codeButton2.backgroundColor = .purple
        codeButton2.disabledColor = .black
        codeButton2.normalTintColor = .white
        self.view.addSubview(codeButton2)
        codeButton2.addTarget(target: self, action: #selector(code), forEvents: .touchUpInside)
        ...
    
    @objc func code() {
        print("codeButton2 已发送")
    }
