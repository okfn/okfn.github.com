---
 layout: post
 author: Anastasios Ventouris
 username: ventouris
 title: A Python guide for open data file formats
---

If you are an open data researcher you will need to handle a lot of different file formats from datasets. Sadly, most of the time,  you don’t have the opportunity to choose which file format is the best for your project, but you have to comport with all of them to be sure that you won’t find a dead end. There’s always someone who knows the solution to your problem, but that doesn’t mean that answers come easy. Here is a guide for each file formats from the [open data handbook](http://opendatahandbook.org/) and a suggestion with a python library to use.

**JSON** is a simple file format that is very easy for any programming language to read. Its simplicity means that it is generally easier for computers to process than others, such as XML. Working with JSON in Python is almost the same such as working with a python dictionary. You will need the json library, but it is preinstalled to every python 2.6 and after.

<pre>import json
json_data = open("file root")
data = json.load(json_data)</pre>

Then data["key"] prints the data for the json

**XML** is a widely used format for data exchange because it gives good opportunities to keep the structure in the data and the way files are built on, and allows developers to write parts of the documentation in with the data without interfering with the reading of them. This is pretty easy in python as well. You will need minidom library. It is also preinstalled.

<pre>from xml.dom import minidom
xmldoc = minidom.parse("file root")
itemlist = xmldoc.getElementsByTagName("name")</pre>

This prints the data for the "name" tag.

**RDF** is a W3C-recommended format and makes it possible to represent data in a form that makes it easier to combine data from multiple sources. RDF data can be stored in XML and JSON, among other serializations. RDF encourages the use of URLs as identifiers, which provides a convenient way to directly interconnect existing open data initiatives on the Web. RDF is still not widespread, but it has been a trend among Open Government initiatives, including the British and Spanish Government Linked Open Data projects. The inventor of the Web, Tim Berners-Lee, has recently proposed a five-star scheme that includes linked RDF data as a goal to be sought for open data initiatives I use rdflib for this file format. Here is an example.

<pre>from rdflib.graph import Graph
g = Graph()
g.parse("file root", format="format")
for stmt in g:
   print(stmt)</pre>

In rdf you can run queries too and return only the data you want. But this isn't easy as parsing it. You can find a tutorial [here](http://code.alcidesfonseca.com/docs/rdflib/gettingstarted.html#run-a-query)

**Spreadsheets**. Many authorities have information left in the spreadsheet, for example Microsoft Excel. This data can often be used immediately with the correct descriptions of what the different columns mean. However, in some cases there can be macros and formulas in spreadsheets, which may be somewhat more cumbersome to handle. It is therefore advisable to document such calculations next to the spreadsheet, since it is generally more accessible for users to read. I prefer to use a tool like xls2csv and then use the output file as a csv. But if you want for any reason to work with an xls, here is the best source I had [www.python-excel.org](www.python-excel.org/). The most popular is the first one, xlrd. There is also another library [openpyxl](http://pythonhosted.org/openpyxl/), where you can work with xlsx files.

**Comma Separated Files (CSV)** files can be a very useful format because it is compact and thus suitable to transfer large sets of data with the same structure. However, the format is so spartan that data are often useless without documentation since it can be almost impossible to guess the significance of the different columns. It is therefore particularly important for the comma-separated formats that documentation of the individual fields are accurate. Furthermore it is essential that the structure of the file is respected, as a single omission of a field may disturb the reading of all remaining data in the file without any real opportunity to rectify it, because it cannot be determined how the remaining data should be interpreted. You can use the CSV python library. Here is an example.

<pre>import csv
with open('eggs.csv', 'rb') as csvfile:
   file = csv.reader("file root", delimiter=' ', quotechar='|')
   for row in file:
      print ', '.join(row)</pre>

**Plain Text (txt)** are very easy for computers to read. They generally exclude structural metadata from inside the document however, meaning that developers will need to create a parser that can interpret each document as it appears. Some problems can be caused by switching plain text files between operating systems. MS Windows, Mac OS X and other Unix variants have their own way of telling the computer that they have reached the end of the line. You can load the txt file but how you will use it after that, it depends on the data format.

<pre>text_file = open("file root", "r")
lines = text_file.read()</pre>

This example will return the whole txt.

**PDF** Here is the biggest problem in open data file formats. Many datasets have their data in pdf and unfortunately it isn't easy to read and then edit them. PDF is really presentation oriented and not content oriented. But you can use [PDFMiner](https://pypi.python.org/pypi/pdfminer/) to work with it. I won't include any example here since it isn't a trivial one, but you can find anything you want in their documentation.

**HTML**. Nowadays much data is available in HTML format on various sites. This may well be sufficient if the data is very stable and limited in scope. In some cases, it could be preferable to have data in a form easier to download and manipulate, but as it is cheap and easy to refer to a page on a website, it might be a good starting point in the display of data. Typically, it would be most appropriate to use tables in HTML documents to hold data, and then it is important that the various data fields are displayed and are given IDs which make it easy to find and manipulate data. Yahoo has developed a tool [yql](http://developer.yahoo.com/yql/) that can extract structured information from a website, and such tools can do much more with the data if it is carefully tagged. I have used many times a python library called Beautiful Soup for my projects.

<pre>from bs4 import BeautifulSoup
soup = BeautifulSoup(html_file)
soup.title
soup.title.name
soup.title.string
soup.title.parent.name
soup.p
soup.p['class']
soup.a
soup.find_all('a')
soup.find(id="link3")</pre>

Those are only a few of what you can do with this library. By calling the tag, will return the content. You can find more on their [documentation](http://www.crummy.com/software/BeautifulSoup/bs4/doc/)

**Scanned image**. Yes. It is true. Probably the least suitable form for most data, but both TIFF and JPEG-2000 can at least mark them with documentation of what is in the picture - right up to mark up an image of a document with full text content of the document. If images are clean, containing only text and without any noise, you can use a library called pytesser. You will need the PIL library to use it. Here is an example.

<pre>from pytesser import *
image = Image.open('fnord.tif')  # Open image object using PIL
print image_to_string(image)</pre>

**Proprietary formats**. Last but not least, some dedicated systems, etc. have their own data formats that they can save or export data in. It can sometimes be enough to expose data in such a format - especially if it is expected that further use would be in a similar system as that which they come from. Where further information on these proprietary formats can be found should always be indicated, for example by providing a link to the supplier’s website. Generally it is recommended to display data in non-proprietary formats where feasible.. I suggest to google if there is any library specific for this dataset.

**Additional Info**. Maybe you will find useful the [Panda](http://pandas.pydata.org/pandas-docs/stable/io.html) library, whose I/O capabilities integrate and unify access from/to most of the formats: CSV, Excel, HDF, SQL, JSON, HTML, Pickle.
