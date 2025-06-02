sub init()
    m.heroImage  = m.top.findNode("heroImage")
    m.titleLabel = m.top.findNode("titleLabel")
    m.descLabel  = m.top.findNode("descLabel")

    content = m.top.content


    poster = invalid
    if content.heroImage <> invalid and content.heroImage <> "" then
        poster = content.heroImage
    else if content.hdPosterUrl <> invalid and content.hdPosterUrl <> "" then
        poster = content.hdPosterUrl
    else if content.thumbnail <> invalid and content.thumbnail <> "" then
        poster = content.thumbnail
    end if

    if poster <> invalid
        m.heroImage.uri = poster
    end if


    m.titleLabel.text = content.title
    m.descLabel.text  = content.description
end sub
