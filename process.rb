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

Dir.glob('./docs/*.pdf').each do |f|
  AnyStyle.find(f.untaint).each do |s|
    parse(s, f.sub('.pdf', '.json'))
  end
end

Dir.glob('./docs/*.txt').each do |f|
  s = File.read(f)
  parse(s, f.sub('.txt', '.json'))
end
