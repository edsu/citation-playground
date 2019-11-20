require 'csv'
require 'json'

json_files = Dir.glob('./docs/*.json')
csv = CSV.open('citations.csv', 'wb')

csv << [
  'type',
  'date',
  'title',
  'journal',
  'volume',
  'issue'
]

# a function for returning either the first element of a list or a string

def first(c)
  if c and c.class == String
    return c
  elsif c and c.length > 0 
    return c[0]
  else
    return nil
  end
end

json_files.each do |f| 
  citations = JSON.parse(File.read(f))
  citations.each do |c|
    puts c
    csv << [
      first(c['type']),
      first(c['date']),
      first(c['title']),
      first(c['journal']),
      first(c['volume']),
      first(c['issue'])
    ]
  end
end
