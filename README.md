# Convert Youtube Links to Usable Embed links

This was a small script I wrote in the space of about 30 minutes as part of a larger project. It works on a surprisingly large array of sites, so I thought I would just upload it.

The script takes a spreadsheet with video titles (tested on youtube) like:

https://www.youtube.com/watch?v=KEY

It turns each row into:

https://www.youtube.com/watch?v=KEY |   The Title of the video  |  https://sitename.com/embed/KEY

## To Run

ruby convert_sheet_to_embeddable.rb 'SPREADSHEET ID KEY OF GOOGLE SPREADSHEET' 'WORKSHEET NAME IN SPREADSHEET'

To find the spreadsheet ID of your sheet, simply look in the url, it will look like:

docs.google.com/spreadsheets/d/THISISYOURKEYRIGHTHERECOPYPASTETHIS/edit#gid=numbders

The first time this is run the command line will ask you to copy-paste a url and verify who you are, so please pay attention.

That's about it! Enjoy!
