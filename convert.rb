require 'csv'
require 'json'

json_files = Dir.glob('./docs/*.json')
csv = CSV.open('citations.csv', 'wb')

# output column headers 

csv << [
  'type',
  'date',
  'title',
  'container-title',
  'volume',
  'issue',
  'authors',
  'publisher',
  'location',
  'file'
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

# a function for unpacking the author hash into "last, first"

def name(n)
  if ! n
    return ''
  elsif n['family'] and n['given']
    return n['family'] + ', ' + n['given']
  elsif n['family']
    return n['family']
  else
    return n['given']
  end
end

# read citations from each csl-json file and write to the csv

json_files.each do |json_file| 
  citations = JSON.parse(File.read(json_file))
  citations.each do |c|
  
    # unpack the authors into a semicolon delimted list
    authors = ''
    if c['author'] and c['author'].length > 0
      authors = c['author'].map {|a| name(a)}.join(' ; ')
    end

    csv << [
      first(c['type']),
      first(c['date']),
      first(c['title']),
      first(c['container-title']),
      first(c['volume']),
      first(c['issue']),
      authors,
      first(c['publisher']),
      first(c['location']),
      json_file
    ]
  end
end
