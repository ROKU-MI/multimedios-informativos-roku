
sub init()
    m.episodeGrid = m.top.findNode("episodeGrid")
    m.titleLabel  = m.top.findNode("titleLabel")

    m.episodeGrid.observeField("itemSelected", "onEpisodeSelected")
    m.top.observeField("content", "onContentSet")
end sub


sub onContentSet()
    seriesNode = m.top.content
    if seriesNode = invalid return

    m.titleLabel.text = "Episodios de " + seriesNode.title


    episodeList = CreateObject("roSGNode", "ContentNode")

    for each epOrig in seriesNode.getChildren(-1)
        epNode = episodeList.createChild("ContentNode")
        epNode.title       = epOrig.title
        epNode.description = epOrig.description


        img = invalid
        if epOrig.hdPosterUrl <> invalid and epOrig.hdPosterUrl <> "" then
            img = epOrig.hdPosterUrl
        else if epOrig.thumbnail <> invalid and epOrig.thumbnail <> "" then
            img = epOrig.thumbnail
        end if
        if img <> invalid
            epNode.hdPosterUrl = img
            epNode.sdPosterUrl = img
        end if


        epNode.url = epOrig.url
    end for

    m.episodeGrid.content = episodeList
end sub


sub onEpisodeSelected()
    idx = m.episodeGrid.itemSelected
    ep  = m.episodeGrid.content.getChild(idx)

    if ep.url <> invalid and ep.url <> ""
        player = CreateObject("roSGNode", "PlayerScene")
        player.content = ep
        m.top.getScene().callFunc("pushScreen", player)
    end if
end sub
