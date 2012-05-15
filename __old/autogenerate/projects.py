import urllib2
import csv
import os
import os.path
import sys
import datetime
from string import Template

SPREADSHEET_URL = 'https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Al6mO9_3Hr2PdGhHVDBCYmQ5QWN5ZDROLU9yMUswQVE&single=true&gid=0&output=csv'
OUTPUT_FOLDER = '_posts'

if os.path.exists(OUTPUT_FOLDER): 
    raise ValueError(OUTPUT_FOLDER+' already exists.')
else:
    os.mkdir(OUTPUT_FOLDER)

TEMPLATE = Template('''---
layout: project
name: ${name}
status: ${status}
categoryFullName: ${categoryFullName}
category: ${category}
strapline: "${strapline}"
image: ${image}
homepage: ${homepage}
wikipage: ${wikipage}
---
${description}
''')


# Download project list from Google
print '  Requesting Google Spreadsheet %s...' % SPREADSHEET_URL
request = urllib2.urlopen(SPREADSHEET_URL)
print '  Parsing CSV...'
reader = csv.DictReader(request, delimiter=',', quotechar='"')

datestamp = datetime.date.today()
day = datetime.timedelta(days=1)
for row in reader: 
    get = lambda some_dict,some_key: some_dict.get(some_key,'') or ''

    if row['OKFNLabs.org_Project']=='Yes': 
        filename = os.path.join(OUTPUT_FOLDER,str(datestamp)+'-'+row['ID']+'.html')
        print '  OK:  %s' % row['Project_Title']
        data = {}
        data['name']   = get(row,'Project_Title').replace(':',' -')
        data['status'] = get(row,'Status')
        data['categoryFullName'] = get(row,'Category')
        if data['categoryFullName']=='Resources' or data['categoryFullName']=='Standards': 
            data['categoryFullName'] = 'Open Knowledge Production'
        data['category'] = data['categoryFullName'].strip().replace(' ','-').lower() 
        data['strapline'] = get(row,'Strapline').replace(':',' -')
        data['description'] = get(row,'Description').replace(':',' -')
        data['image'] = get(row,'Flickr_Image')
        data['homepage'] = get(row,'Website')
        data['wikipage'] = get(row,'Wiki page')
          
        outfile = open(filename, 'w')
        print >>outfile, TEMPLATE.substitute(data)

        datestamp -= day

