from sklearn.datasets import fetch_20newsgroups
import pandas as pd
import numpy as np
from nltk.tokenize import word_tokenize # used to extract words from documents

data = fetch_20newsgroups(subset = 'all', shuffle = False, 
                          remove = ('headers', 'footers', 'quotes'))


# create dataframe with docs
df = pd.DataFrame(data.data, columns = ['text'])
df['label_key'] = data.target

# create dataframe with labels
df_key = pd.DataFrame(data.target_names, columns= ['label'])
df_key['label_key'] = np.unique(data.target)

# add labels to dataframe
df = df.merge(df_key, on = 'label_key')

# save result as a csv
df.to_csv('data/20newsgroups.csv', sep = ',', index = False)

