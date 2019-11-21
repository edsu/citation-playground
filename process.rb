require 'json'
require 'anystyle'

# a function that parses citations from a string and writes them out as json

def parse(s, json_file)
  citations = AnyStyle.parse(s) 
  puts "#{json_file} [#{citations.length}]"
  citations_json = JSON.pretty_generate(citations)
  open(json_file, 'w') do |fh| 
    fh.write(citations_json)
  end
end

# process pdfs of articles

Dir.glob('./docs/*.pdf').each do |f|
  json_file = f.sub('.pdf', '.json')
  if File.file? json_file
    puts "#{json_file} already exists, skipping."
  else
    AnyStyle.find(f.untaint).each do |s|
      parse(s, json_file)
    end
  end
end

# process text files (containing only citations)

Dir.glob('./docs/*.txt').each do |f|
  json_file = f.sub('.txt', '.json')
  if File.file? json_file
    puts "#{json_file} already exists, skipping."
  else
    s = File.read(f)
    parse(s, json_file)
  end
end
