sub init()
    m.video = m.top.findNode("videoPlayer")

    m.top.observeField("content", "onContentSet")
    m.video.observeField("state",   "onVideoStateChanged")
end sub


sub onContentSet()
    content = m.top.content
    if content = invalid return

    if content.url <> invalid and content.url <> "" then

        m.video.content = content
        m.video.control = "play"
    else
        print "PlayerScene: contenido sin URL"
    end if
end sub


sub onVideoStateChanged()
    if m.video.state = "finished"
        m.top.getScene().callFunc("popScreen")
    end if
end sub
