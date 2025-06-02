
sub init()
    m.video = m.top.findNode("introVid")
    m.video.observeField("state", "onVideoStateChange")


    n          = CreateObject("roSGNode", "ContentNode")
    n.url      = "pkg:/multimedia/videos/Recursos/MISplashIntro.mp4"
    n.streamFormat = "mp4"

    m.video.content = n    
    m.video.control = "play"
end sub

sub onVideoStateChange()
    if m.video.state = "finished"
        m.top.splashDone = true
    end if
end sub
