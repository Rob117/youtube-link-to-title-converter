require 'google_drive'
require 'mechanize'
require 'pry'

# This file takes a spreadsheet where the video links are written, and a sheet title
# the links MUST be in the format:
# http://www.site.com/someparams&lastparam=videoKey
# It then converts them all into
# column one: original link. column two: title, column three: embed link

# most sites obey the following two rules:
# 1) going to a link gives you the video title in the page
# 2) The video embed url is originalsiteurl.com/embed/key

start_time = Time.now
AGENT = Mechanize.new
AGENT.user_agent_alias = 'Mac Safari'

def generate_title_and_embed_link(base_url)
  page = AGENT.get(base_url)
  # grab the title to put in cell two
  title = page.title

  uri = page.uri
  hosting_site = uri.host
  # split the query string(key=value) off of the base uri, then grab the value after the ('=')
  video_id = uri.query.split('=')[1]
  embed_link = "https://#{hosting_site}/embed/#{video_id}"
  # update cells requires array of arrays
  return [[base_url, title, embed_link]]
end

session = GoogleDrive::Session.from_config('config.json')
ws = session.spreadsheet_by_key(ARGV[0]).worksheet_by_title(ARGV[1])

ws.num_rows.times do |row_num|
  row_num += 1 # This is because worksheet is 1 based, times is 0 based
  # if the title isn't empty, move on
  base_url = ws[row_num, 1]
  next unless ws[row_num, 2] == "" || base_url == ""
  ws.update_cells(row_num, 1, generate_title_and_embed_link(base_url))
end

ws.save

p "Duration = #{Time.now - start_time} seconds"
