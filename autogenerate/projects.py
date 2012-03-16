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
layout: default
name: ${Project_Title}
status: ${Status}
category-name: ${Category}
category: ${categoryclass}
strapline: "${Strapline}"
image: ${thumbnail_url}
homepage: ${Website}
wikipage: ${wikipage}
---

<h1>${Project_Title}</h1>

<h4>Strapline:</h4>

${Strapline}

<h4>Description:</h4>

${Description}
''')


# Download project list from Google
print '  Requesting Google Spreadsheet %s...' % SPREADSHEET_URL
request = urllib2.urlopen(SPREADSHEET_URL)
print '  Parsing CSV...'
reader = csv.DictReader(request, delimiter=',', quotechar='"')

datestamp = datetime.date.today()
day = datetime.timedelta(days=1)
for row in reader: 
    if row['OKFNLabs.org_Project']=='Yes': 
        filename = os.path.join(OUTPUT_FOLDER,str(datestamp)+'-'+row['ID']+'.html')
        print '  OK:  %s' % row['Project_Title']
        # Modify row content
        row['Project_Title'] = row['Project_Title'].replace(':',' -')
        if (row['Strapline']):
            row['Strapline'] = row['Strapline'].replace(':',' -')
        # Try to minimise the number of categories
        if row['Category']=='Resources' or row['Category']=='Standards': 
            row['Category'] = 'Open Knowledge Production'
        row['categoryclass'] = row['Category'].strip().replace(' ','-').lower() 
        row['thumbnail_url'] = row['Flickr_Image'] or ''
        row['wikipage'] = row['Wiki page']
          
        outfile = open(filename, 'w')
        print >>outfile, TEMPLATE.substitute(row)

        datestamp -= day

