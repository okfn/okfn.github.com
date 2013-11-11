---
layout: post
author: Tarek Amr
username: tamr
title: Natural Language Processing using Python
---
 
This weekend the [Google Developer Group in Cairo](http://www.gdgcairo.org/ "GDG Cairo") arranged 2-days workshops followed by a hackathon. During this event, I organized a workshop about [NLTK](http://nltk.org/ “Natural Language Toolkit”) and the use of Python in Natural Language Processing (NLP). The session's slides can be found [here](http://tarekamr.appspot.com/slides/pynlp "Python NLP Slides"). The beauty of NLP is that it enables computers to extract knowledge from unstructured data inside textual documents. Websites like Zite use NLP to deliver custom news to readers based on their taste. NLP enables Google to extract times and dates from email messages so that Gmail users can automatically add events mentioned in their emails into their calendars. The same technology enables us to translate text and predict the language of a tweet. Data journalists can also use NLP to analyse transcripts of the speeches of politicians and MPs to find newsworthy information that is not feasible to be found without such technology. 

## Normalization and Tokenization.

Two initial steps should take place before dealing with text. Words can take various forms according to their context. For example, the same word is capitalized when it is placed in the beginning of the sentence, and it starts with small letters elsewhere. Plural words have different endings from their singular counterparts, while conjugation changes the ending of verbs. 

The word “free” appears twice in the following sentence, “Free hosting and free domain”, but for a computer to know that it is the same word regardless of its case, we may need to convert the whole sentence into lower cases. This is simple done in Python as follows:

    “Free hosting and free domain”.lower()

Nevertheless, in some cases we might need to take the case the words into our considerations, especially when it carries some information about the meaning of those words. Consider the following example, “The CEO of Apple gave me an apple”.

Additionally, stemming is used to make sure that plural and singular words become the same. It also normalizes adjectives, adverbs and verbs given their various conjugations:

    import nltk
    stemmer = nltk.PorterStemmer()
    stemmer.stem('running') # => run
    stemmer.stem('shoes') # => shoe
    stemmer.stem('expensive') # => expens
    
Another useful command in NLTK is clean_html(), which is capable of removing all HTML tags from a given text. 

After normalizing our text, we usually need to divide it into sentences and words. The split() method is capable of converiting the following string, "We sell you finger-licking fires.", into that list of words: 

    "We sell you finger-licking fries.".split()
    ['We', 'sell', 'you', 'finger-licking', 'fries.']
    
        
One problem with the previous command that it did not deal well with the hyphen and the fullstop. Anther alternative method is the wordpunct_tokenize() provided by NLTK:

    from nltk.tokenize import wordpunct_tokenize 
    wordpunct_tokenize('We sell you finger-licking fries.')
    ['We', 'sell', 'you', 'finger', '-', 'licking', 'fries', '.']


## Text Analysis

NLTK allows us to find out the frequencies of each word in our textual data. In the demo ['gnugpl.py'](https://github.com/gr33ndata/NLP_GDGCairo2013 "GNU GPL Demo"), you can see how to use nltk.Text() to list the top n words in the GPL3 license. Similarly, we can get the frequency distribution of characters in text, rather than words. We will show later on how we cam detect the language of some text using the  frequency distribution of characters there.


![Frequency distribution of characters](http://i.imgur.com/DxbwkGrl.png)

*Frequency distribution of characters in both English and Arabizi*

One problem with word frequencies is that big percentage of the top n words are stop-words. Stop-words are common words in a certain language that are not related to the topic of the document, such as "the", "of", "and", etc. In the demo, [wikianalysis.py](https://github.com/gr33ndata/NLP_GDGCairo2013 "Wikipedia pages for Egypt, Tunisia and Lebanon"), we grabbed the text of the Wikipedia pages of Egypt, Tunisia and Lebanon. The top n words from each page were put in a table [here](https://docs.google.com/spreadsheet/ccc?key=0AmbldjoHWBdZdGpvWDFBcjBneDBlY05ScHZ2dU8yU3c "Wikipedia Analysis"). One way to deal with stop-words is to re-weight terms. Words that appear in one page but not in the other should be given higher weight compared to words that are common in the three pages, even if they have higher frequencies. Thus, we divided the counts of each word in an page by the total count of it across the 3 pages. The results were put in the next tab, where we can see that the words marked in green are the ones related to each country. Additionally, you can use the collocations() method in NLTK to find out word pairs that frequently appear together.


## Text Classification

People sometimes find it easier to write Arabic words in Latin letters on the social media websites. This way of writing is commonly known as Arabizi or Francoarab. We needed to find a way to be able to tell if a text is written in English or in Francoarab.  Initially, we noticed that the letter distribution varies between the two. The distribution of consecutive letter pairs also varies. Thus, in the demo, [franco.py](https://github.com/gr33ndata/NLP_GDGCairo2013 "Text Language Classification"), we used Naive Bayes Classifier to predict the language of a given text. We trained the classifier using the distribution of character pairs (bigrams) in our training set, "corpus/franco.txt".

In addition to classifying a whole document, one might also need to predict the category of each word in the document. The categories are better known as Part of Speech (PoS) tags. For example, the word “book” is considered as a noun in “I am reading a book”, while in the phrase “I am going to book my train ticket”, it happens to be a verb. PoS tagging is thus used to whether a word is a noun, adjective, verb, etc. There are built in PoS taggers in NLTK, however in our demo, [cairotraffic.py](https://github.com/gr33ndata/NLP_GDGCairo2013 "#CairoTraffic Analysis"), we wanted to have our own set of PoS tags.

People normally use the hashtag #CairoTraffic on twitter to update their friends about the status of the traffic in the different streets of Cairo. Although, such tweets easily understood by humans, it is hard for a computer to extract structured data from them. For example, the following two phrases carry the same meaning despite their different wording:

    The road to Zamalek from Tahrir is blocked.
    Traffic was totally blocked from Tahrir in the direction of Zamalek.

Thus, in  “cairotraffic.py” we needed create PoS tags for the “FROM” and “TO” locations in each tweet. We used NLTK's UnigramTagger() and BigramTagger() in addition to Naive Bayes classifier to extract the words reflecting the “FROM” and “TO” locations from each tweet. It was clear from our demo that the Naive Bayes classifier outperformed the unigram and bigram taggers for unseen words and the variations in sentence structures. 

In addition to PoS tagging, we also applied a simple Naive Bayes classifier to tell whether a road is blocked (za7ma) or alright (7alawa) given the words used in a tweet.

## Conclusion

Python and NLTK makes it easy to carry on complex natural language processing tasks using few lines of code. We have seen here that the toolkit provide all suitable methods for doing text tokenization, analysis and classification. You can also read more about the concepts discussed here and the other capabilities of NLTK in this [free book](http://nltk.org/book/ "Natural Language Processing with Python") by Steven Bird, Ewan Klein, and Edward Loper.

If any of the topics discussed here is not clear, please feel free to ask me about it. Also feel free to [contact me](http://tarekamr.appspot.com/ "Tarek Amr Homepage") if you have any comments about the code or you would like me to help you using it in any of your projects.