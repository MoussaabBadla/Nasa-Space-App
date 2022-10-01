
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import spacy
import string
import gensim
import json
import re
import pickle
from gensim import corpora
from os.path import exists
from gensim.similarities import MatrixSimilarity
from flask import Flask
from flask_restful import Resource, Api, reqparse
from operator import itemgetter


df = pd.read_csv('data.csv')

spacy_nlp = spacy.load('en_core_web_sm')

#create list of punctuations and stopwords
punctuations = string.punctuation
stop_words = spacy.lang.en.stop_words.STOP_WORDS

#function for data cleaning and processing
#This can be further enhanced by adding / removing reg-exps as desired.

def spacy_tokenizer(sentence):
 
    #remove distracting single quotes
    sentence = re.sub('\'','',sentence)

    #remove digits adnd words containing digits
    sentence = re.sub('\w*\d\w*','',sentence)

    #replace extra spaces with single space
    sentence = re.sub(' +',' ',sentence)

    #remove unwanted lines starting from special charcters
    sentence = re.sub(r'\n: \'\'.*','',sentence)
    sentence = re.sub(r'\n!.*','',sentence)
    sentence = re.sub(r'^:\'\'.*','',sentence)
    
    #remove non-breaking new line characters
    sentence = re.sub(r'\n',' ',sentence)
    
    #remove punctunations
    sentence = re.sub(r'[^\w\s]',' ',sentence)
    
    #creating token object
    tokens = spacy_nlp(sentence)
    
    #lower, strip and lemmatize
    tokens = [word.lemma_.lower().strip() if word.lemma_ != "-PRON-" else word.lower_ for word in tokens]
    
    #remove stopwords, and exclude words less than 2 characters
    tokens = [word for word in tokens if word not in stop_words and word not in punctuations and len(word) > 2]
    
    #return tokens
    return tokens
print ('Cleaning and Tokenizing...')
df['description_tokenized'] = df['description'].map(lambda x: spacy_tokenizer(x))
description_tokenized = df['description_tokenized']





#creating term dictionary
dictionary = corpora.Dictionary(description_tokenized)

#list of few which which can be further removed
stoplist = set('hello and if this can would should could tell ask stop come go')
stop_ids = [dictionary.token2id[stopword] for stopword in stoplist if stopword in dictionary.token2id]
dictionary.filter_tokens(stop_ids)


corpus = [dictionary.doc2bow(desc) for desc in description_tokenized]


tfidf_model = gensim.models.TfidfModel(corpus, id2word=dictionary)
lsi_model = gensim.models.LsiModel(tfidf_model[corpus], id2word=dictionary, num_topics=300)



if(exists("tfidf_model_mm") == False):
  gensim.corpora.MmCorpus.serialize('tfidf_model_mm', tfidf_model[corpus])
  
if(exists("lsi_model_mm") == False):
  gensim.corpora.MmCorpus.serialize('lsi_model_mm',lsi_model[tfidf_model[corpus]])





#Load the indexed corpus
tfidf_corpus = gensim.corpora.MmCorpus('tfidf_model_mm')
lsi_corpus = gensim.corpora.MmCorpus('lsi_model_mm')


movie_index = MatrixSimilarity(lsi_corpus, num_features = lsi_corpus.num_terms)



def search(search_term):
    query_bow = dictionary.doc2bow(spacy_tokenizer(search_term))
    query_tfidf = tfidf_model[query_bow]
    query_lsi = lsi_model[query_tfidf]
    movie_index.num_best = 100

    lst = movie_index[query_lsi]

    lst.sort(key=itemgetter(1), reverse=True)
    movie_names = []

    for j, img in enumerate(lst):
        movie_names.append (
            {
                'Relevance': round((img[1] * 100),2),
                'nasa_id':df['nasa_id'][img[0]],
                'title': df['title'][img[0]],
                'date_created':df['date_created'][img[0]],
                'description': df['description'][img[0]],
                'keywords': df['keywords'][img[0]],
                'secondary_creator':df['secondary_creator'][img[0]],
                'href': df['href'][img[0]]
               
            }
        
        )
        if j == (movie_index.num_best-1) and int(round((img[1] * 100),2)) <= 0:
            break
    pd.set_option('display.max_rows', None),
    result= pd.DataFrame(movie_names, columns=['nasa_id','title','date_created','description','keywords','secondary_creator','href']).to_json(orient="index")
    parsed = json.loads(result)
    return json.dumps(parsed, indent=4)  


app = Flask(__name__)
api = Api(app)

class Users(Resource):
    def get(self):
        
        if (exists("model") == False):
          with open('model', 'wb') as files:
            pickle.dump(search, files)

        parser = reqparse.RequestParser()

        parser.add_argument('query', required=True)
        args = parser.parse_args()
        loaded_model = pickle.load(open('model', 'rb'))
        input_data = args['query']
        # http://127.0.0.1:5000/users?query=the Sample Analysis at Mars instrument, or SAM
        data = loaded_model(input_data) # convert dataframe to dictionary
        return {'data': data}, 200  # return data and 200 OK code


api.add_resource(Users, '/users') 

if __name__ == '__main__':

    app.run()  # run our Flask app


