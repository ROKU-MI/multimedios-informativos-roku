
sub Main()
    screen = CreateObject("roSGScreen")
    port   = CreateObject("roMessagePort")
    screen.SetMessagePort(port)


    screen.CreateScene("SplashScene")
    screen.Show()


    while true
        msg = wait(0, port)


        if type(msg) = "roSGScreenEvent" and msg.isScreenClosed() then
            return
        end if


        if type(msg) = "roSGNodeEvent" and msg.getField() = "splashDone" and msg.getData() = true then
            screen.CreateScene("HomeScene")
        end if
    end while
end sub
