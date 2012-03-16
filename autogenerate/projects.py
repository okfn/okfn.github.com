import urllib2
import csv
import flickr
import os
import os.path
import sys
import datetime
from string import Template

# From Flickr
# ===========
# Done! Here's the API key and secret for your new app:
# okfn-labs
# Key:
# c83c80058a6621f21f3401c2d0ef8830
# Secret:
# dab312bffbb29032

flickr.API_KEY = 'c83c80058a6621f21f3401c2d0ef8830'
FLICKR_PHOTOSET = '72157627951139765'

SPREADSHEET_URL = 'https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Al6mO9_3Hr2PdGhHVDBCYmQ5QWN5ZDROLU9yMUswQVE&single=true&gid=0&output=csv'
OUTPUT_FOLDER = '_posts'

if os.path.exists(OUTPUT_FOLDER): 
    raise ValueError(OUTPUT_FOLDER+' already exists.')

os.mkdir(OUTPUT_FOLDER)

# Download photoset from Flickr
flickr_url = {}

if False:
    # Code to pull Flickr URLs from the API
    print '  Getting photoset id=%s from flickr...' % FLICKR_PHOTOSET
    photoset = flickr.Photoset(FLICKR_PHOTOSET, None, None)
    print '  Extracting photos...'
    photos = photoset.getPhotos()

    # Map photo titles to URLs
    n = 0
    length = len(photos)
    for photo in photos:
        n += 1
        print '  Mapping flickr URLs... ' + str(n) + '/' + str(length) + '\r',
        sys.stdout.flush()
        flickr_url[photo.title] = photo.getThumbnail()

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
        print '  Handling %s' % row['Project_Title']
        print '    File = %s' % filename
        row['Project_Title'] = row['Project_Title'].replace(':',' -')
        if (row['Strapline']):
            row['Strapline'] = row['Strapline'].replace(':',' -')

        outfile = open(filename, 'w')
        row['categoryclass'] = row['Category'].strip().replace(' ','-').lower() 
        row['thumbnail_url'] = flickr_url.get(row['Flickr_Image_Name']) or ''
        row['wikipage'] = row['Wiki page']
        print >>outfile, TEMPLATE.substitute(row)

        datestamp -= day
    else:
        print '  Skipping %s' % row['Project_Title']

