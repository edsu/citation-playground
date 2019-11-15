require 'json'
require 'anystyle'

pdf_files = Dir.glob('./docs/*.pdf')

pdf_files.each do |f| 
  AnyStyle.find(f.untaint).each do |s|
    citations = AnyStyle.parse(s) 
    citations_json = JSON.pretty_generate(citations)
    citations_file = f.sub('.pdf', '.json')
    open(citations_file, 'w') do |fh| 
      fh.write(citations_json)
    end
  end
end
