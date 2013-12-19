---
layout: post
title: How I parse PDF files
author: Thomas Levine
username: tlevine
---
Much of the world's data are stored in portable document format (PDF) files.
This is not my preferred storage or presentation format, so I often convert
such files into databases, graphs, or [spreadsheets](http://csvsoundsystem.com).
I sort of follow this decision process.

1. Do we need to read the file contents at all?
2. Do we only need to extract the text and/or images?
3. Do we care about the layout of the file?

## Example PDFs
I'll show a few different approaches to parsing and analyzing
[these](https://github.com/tlevine/scott-documents) PDF files.
Different approaches make sense depending on the question you ask.

These files are public notices of applications for permits to dredge or fill
wetlands. The Army Corps of Engineers posts these notices so that the public
may comment on the notices before the Corps approves them; people are thus
able to voice concerns about whether these permits would fall within the rules
about what sorts of construction is permissible.

Theses files are
[downloaded daily](https://github.com/tlevine/scott/tree/master/reader)
from the [New Orleans Army Corps of Engineers website](http://www2.mvn.usace.army.mil/ops/regulatory/publicnotices.asp?ShowLocationOrder=False)
and renamed according to the permit application and the date of download.
They once fed into that the Gulf Restoration Network in their efforts to
protect the wetlands from reckless destruction.

## If I don't need the file contents
Basic things like file size, file name and modification date might be useful
in some contexts. In the case of PDFs, file size will give you an idea of how
many/much of the PDFs are text and how many/much are images.

Let's [plot a histogram](https://github.com/dzerbino/ascii_plots/blob/master/hist)
of the file sizes. I'm running this from the root of the documents repository,
and I cleaned up the output a tiny bit.

    $ ls --block-size=K -Hs */public_notice.pdf | sed 's/[^0-9 ].*//' | hist 5
      15 |   2 | **
      20 |  55 | ********************************************************************************
      25 |   4 | *****
      30 |   4 | *****
      35 |  11 | ****************
      40 |   4 | *****
      45 |   2 | **
      50 |   2 | **
      60 |   1 | *
      75 |   1 | *
      80 |   1 | *
      95 |   1 | *
     100 |   2 | **
     120 |   1 | *
     125 |   2 | **
     135 |   1 | *
     145 |   3 | ****
     150 |   6 | ********
     155 |   4 | *****
     160 |   8 | ***********
     165 |   3 | ****
     170 |   6 | ********
     175 |   7 | **********
     180 |  24 | **********************************
     185 |  11 | ****************
     190 |   6 | ********
     195 |   4 | *****
     200 |  23 | *********************************
     205 |   7 | **********
     210 |   7 | **********
     215 |   3 | ****
     220 |   3 | ****
     225 |   1 | *
     230 |   1 | *
     235 |   1 | *
     240 |   2 | **
     245 |   2 | **
     250 |   1 | *
     255 |   3 | ****
     265 |   1 | *
     280 |   1 | *
     460 |   1 | *
     545 |   1 | *
     585 |   1 | *
     740 |   1 | *
     860 |   2 | **
     885 |   1 | *
     915 |   1 | *
     920 |   1 | *
     945 |   1 | *
     950 |   1 | *
     980 |   1 | *
    2000 |   1 | *
    2240 |   1 | *
    2335 |   1 | *
    7420 |   1 | *
    TOTAL| 248 |

The histogram shows us two modes. The smaller mode, around 20 kb, corresponds to
files with no images (PDF export from Microsoft Word), and the larger mode
corresponds to files with images (scans of print-outs of the Microsoft Word
documents). It looks like about 80 are just text and the other 170 are scans.

This isn't a real histogram, but if we'd used a real one with an interval scale,
the outliers would be more obvious. Let's cut off the distribution at 400 kb
and look more closely at the unusually large documents that are above that
cutoff.

What's in that 7 mb file? Well let's find it.

    $ ls --block-size=K -Hs */public_notice.pdf | grep '742.K'
    7424K MVN-2010-1080-WLL_MVN-2010-1032-WLLB/public_notice.pdf

You can see it [here](https://github.com/tlevine/scott-documents/raw/master/MVN-2010-1080-WLL_MVN-2010-1032-WLLB/public_notice-2012-08-09.pdf).
It's not a typical public notice; rather, it is a series of scanned documents
related to a permit transfer request. Interesting.

Next, how are two large files within 5 kb of each other?

    $ ls --block-size=K -Hs */public_notice.pdf | grep 860K
    860K MVN-2012-006152-WII/public_notice.pdf
    860K MVN-2012-1797-CU/public_notice.pdf

Those are here

* [MVN-2012-006152-WII](https://github.com/tlevine/scott-documents/raw/master/MVN-2012-006152-WII/public_notice-2012-11-20.pdf)
* [MVN-2012-1797-CU](https://github.com/tlevine/scott-documents/raw/master/MVN-2012-1797-CU/public_notice-2012-10-02.pdf)

Hmm. Nothing special about those. People see patterns in randomness.

Now let's look at some basic properties of the pdf files. This will give us a
basic overview of one file.

    $ pdfinfo MVN-2013-00026-WKK/public_notice.pdf
    Creator:        FUJITSU fi-4010CU
    Producer:       Adobe Acrobat 9.52 Paper Capture Plug-in
    CreationDate:   Fri Jan 25 09:45:08 2013
    ModDate:        Fri Jan 25 09:46:16 2013
    Tagged:         yes
    Form:           none
    Pages:          3
    Encrypted:      no
    Page size:      606.1 x 792 pts
    Page rot:       0
    File size:      199251 bytes
    Optimized:      yes
    PDF version:    1.6

Let's run it on all of the files.

    $ for file in */public_notice.pdf; do pdfinfo $file && echo; done
    # Lots of output here

What was used to produce these files?

    $ for file in */public_notice.pdf; do pdfinfo $file|sed -n 's/Creator: *//p' ; done|sort|uniq -c
    33 Acrobat PDFMaker 10.1 for Word
    48 Acrobat PDFMaker 9.1 for Word
    10 FUJITSU fi-4010CU
    135 HardCopy
    7 HP Digital Sending Device
    2 Oracle9iAS Reports Services
    6 PScript5.dll Version 5.2.2
    4 Writer

When were they created?

    $ for file in */public_notice.pdf; do pdfinfo $file|grep CreationDate: > /dev/null && date -d "$(pdfinfo $file|sed -n 's/CreationDate: *//p')" --rfc-3339 date ; done
    2012-07-03
    2012-07-06
    2012-07-06
    2012-07-06
    # ...

How many pages do they have?

    $ for file in */public_notice.pdf; do pdfinfo $file|sed -n 's/Pages: *//p' ; done | hist 1
     1    |   1 | 
     2    |  27 | **********
     3    | 198 | ********************************************************************************
     4    |  16 | ******
     5    |   1 | 
     8    |   2 | 
    10    |   1 | 
    31    |   1 | 
    40    |   1 | 
    TOTAL | 248 |

It might actually be fun to see relate these variables to each other. For
example, when did the Corps upgrade from PDFMaker 9.1 to PDFMaker 10.1?

Anyway, we got somewhere interesting without looking at the files. Now let's
look at them.

## If messy, raw file contents are fine
The main automatic processing that I run on the PDFs is a search for a few
identification numbers. The Army Corps of Engineers uses a number that starts
with "MVN", but other agencies use different numbers. I also search for two
key paragraphs

[My approach](https://github.com/tlevine/scott/blob/master/reader/bin/translate)
is pretty crude. For the PDFs that aren't scans, I just use `pdftotext`.

    # translate
    pdftotext "$FILE" "$FILE"

Then I just use regular expressions to search the resulting text file.

`pdftotext` normally screws up the layout of PDF files, especially when they
have multiple columns, but it's fine for what I'm doing because I only need to
find small chunks of text rather than a whole table or a specific line on
multiple pages.

As we saw earlier, most of the files contain images, so I need to run OCR.
Like `pdftotext`, OCR programs often mess up the page layout, but I don't
care because I'm using regular expressions to look for small chunks.

I don't even care whether the images are in order; I just use `pdfimages`
to pull out the images and then `tesseract` to OCR each image and add that
to the text file. (This is all in the
[`translate`](https://github.com/tlevine/scott/blob/master/reader/bin/translate)
script that I linked above.)

## If I care about the layout of the page
If I care about the layout of the page, `pdftotext` probably won't work.
Instead, I use `pdftohtml` or `inkscape`. I've never needed to go deeper,
but if I did, I'd use something like
[PDFMiner](http://www.unixuser.org/~euske/python/pdfminer/).

### pdftohtml
`pdftohtml` is useful because of its `-xml` flag.

    $ pdftohtml -xml MVN-2013-00180-ETT/public_notice.pdf
    Page-1
    Page-2
    Page-3
    $ head MVN-2013-00180-ETT/public_notice.xml 
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE pdf2xml SYSTEM "pdf2xml.dtd">

    <pdf2xml producer="poppler" version="0.22.0">
    <page number="1" position="absolute" top="0" left="0" height="1188" width="918">
            <fontspec id="0" size="37" family="Times" color="#000000"/>
            <fontspec id="1" size="21" family="Times" color="#000000"/>
            <fontspec id="2" size="16" family="Times" color="#000000"/>
            <fontspec id="3" size="13" family="Times" color="#000000"/>
            <fontspec id="4" size="16" family="Times" color="#000000"/>

Open that with an XML parser like lxml

    # This is python
    import lxml.etree
    pdf2xml = lxml.etree.parse('MVN-2013-00180-ETT/public_notice.xml')

One of the things that I try to extract is the "CHARACTER OF WORK" section.
I do this with regular expressions, but we could also do this with the XML.
Here are some XPath selectors that get us somewhere.

    # This is python
    print pdf2xml.xpath('//text/b[text()="CHARACTER OF WORK"]/../text()')
    print pdf2xml.xpath('//text/b[text()="CHARACTER OF WORK"]/../following-sibling::text/text()')      

### Inkscape
Inkscape can convert a PDF page to an SVG file. I have a
[little script](https://github.com/scraperwiki/pdf2svg) that runs this across
all pages within a PDF file.

Once you've converted the PDF file to a bunch of SVG files, you can open it
with an XML parser just like you could with the `pdftohtml` output, except
this time much more of the layout is preserved, including the groupings of
elements on the page.

Here's a snippet from one project where I used Inkscape to parse PDF files.
I created a crazy system for receiving a very messy PDF table over email and
converting it into a spreadsheet that is hosted on a website.

This function is contains all of the parsing functions for a specific page of
the pdf file once it has been converted to SVG. It takes an
`lxml.etree._ElementTree` object like the one we get from `lxml.etree.parse`,
along with some metadata. It runs a crazy XPath selector (determined only after
much test-driven development) to pick out the table rows, and then runs a bunch
of functions (not included) to pick out the cells within the rows.

    def page(svg, file_name, page_number):
        'I turn a svg tree into a list of dictionaries.'
        # County name
        county = unicode(svg.xpath(
            '//svg:g/svg:path[position()=1]/following-sibling::svg:text/svg:tspan/text()',
            namespaces = { 'svg': 'http://www.w3.org/2000/svg' }
        )[0])
        rows = _page_tspans(svg)

        def skip(reason):
            print 'Skipped a row on %s page %d because %s.' % (file_name, page_number, reason)

        data = []
        for _row in rows:
            row_text = [text.xpath('string()') for text in _row]
            try:
                if row_text == []:
                    skip('the row is empty')
                    print row_text
                elif _is_header(row_text):
                    skip('it appears to be a header.')
                    print row_text
        # ...

I'd like to point out the `string()` xpath command. That converts the current
node and its decendents into plain text; it's particularly nice for
inconsistently structured files like this one.

## Optical character recognition
People often think that optical character recognition (OCR) is going to be
a hard part. It might be, but it doesn't really change this decision process.
If I care about where the images are positioned on the page, I'd probably
use Inkscape. If I don't, I'd probably use `pdfimages`, as I did here.

## Review
When I'm parsing PDFs, I use some combination of these tools.

1. Basic file analysis tools (`ls` or another language's equivalent)
2. PDF metadata tools (`pdfinfo` or an equivalent)
3. `pdftotext`
4. `pdftohtml -xml`
5. Inkscape via [`pdf2svg`](https://github.com/scraperwiki/pdf2svg)
6. [PDFMiner](http://www.unixuser.org/~euske/python/pdfminer/)

I prefer the
ones earlier in the list when the parsing is less involved because the tools
do more of the work for me. I prefer the ones towards the end as the job gets
more complex because these tools give me more control.

If I need OCR, I use `pdfimages` to remove the images and `tesseract` to run
OCR. If I needed to run OCR and know more about the layout, I might convert the
PDFs to SVG with Inkscape and, and then take the images out of the SVG in order
to know more precisely where they are in the page's structure.

*This article was originally posted [on Thomas Levine's site](http://thomaslevine.com/!/parsing-pdfs).*
