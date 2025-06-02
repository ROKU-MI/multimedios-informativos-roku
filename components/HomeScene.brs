sub init()
    m.rowList = m.top.findNode("rowList")
    m.rowList.observeField("rowItemSelected", "onRowItemSelected")

    loadFeed()
end sub


sub loadFeed()

    feedUrl = m.top.feedUrl
    if feedUrl = invalid or feedUrl = "" then
        feedUrl = "pkg:/json/feed.json"
    end if

    feedStr = ReadAsciiFile(feedUrl)
    if feedStr = invalid
        print "ERROR: no se pudo leer " + feedUrl
        return
    end if

    data = ParseJSON(feedStr)
    if type(data) <> "roAssociativeArray"
        print "ERROR: JSON mal formado"
        return
    end if

    rootNode = CreateObject("roSGNode", "ContentNode")


    for each category in data.categories
        rowNode = rootNode.createChild("ContentNode")
        rowNode.title = category.name


        for each item in category.items
            itemNode = rowNode.createChild("ContentNode")
            itemNode.title                 = item.title
            itemNode.shortDescriptionLine1 = item.title
            itemNode.description           = item.description


            poster = invalid
            if item.thumbnail <> invalid then
                poster = item.thumbnail
            else if item.image <> invalid
                poster = item.image
            else if item.hdPosterUrl <> invalid
                poster = item.hdPosterUrl
            end if
            if poster <> invalid
                itemNode.hdPosterUrl = poster
                itemNode.sdPosterUrl = poster
            end if


            if item.url <> invalid and item.url <> ""
                itemNode.url = item.url
            end if


            if item.episodes <> invalid
                for each ep in item.episodes
                    epNode = itemNode.createChild("ContentNode")
                    epNode.title                 = ep.title
                    epNode.shortDescriptionLine1 = ep.title
                    epNode.description           = ep.description

                    if ep.thumbnail <> invalid
                        epNode.hdPosterUrl = ep.thumbnail
                        epNode.sdPosterUrl = ep.thumbnail
                    end if
                    epNode.url = ep.video        
                end for
            end if
        end for
    end for

    m.rowList.content = rootNode
end sub


sub onRowItemSelected()

    rowIndex  = m.rowList.rowItemSelected[0]
    itemIndex = m.rowList.rowItemSelected[1]
    item      = m.rowList.content.getChild(rowIndex).getChild(itemIndex)


    if item.getChildCount() > 0
        showEpisodePicker(item)
    else if item.url <> invalid and item.url <> ""
        playVideo(item)
    else
        showDetails(item)
    end if
end sub


sub playVideo(item as Object)
    player = CreateObject("roSGNode", "PlayerScene")
    player.content = item
    m.top.getScene().callFunc("pushScreen", player)
end sub


sub showDetails(item as Object)
    details = CreateObject("roSGNode", "DetailsScene")
    details.content = item
    m.top.getScene().callFunc("pushScreen", details)
end sub


sub showEpisodePicker(seriesNode as Object)
    picker = CreateObject("roSGNode", "EpisodePickerScene")
    picker.content = seriesNode
    m.top.getScene().callFunc("pushScreen", picker)
end sub
