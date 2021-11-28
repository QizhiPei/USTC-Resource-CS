import sklearn
from sklearn.naive_bayes import MultinomialNB
from sklearn.feature_extraction.text import TfidfVectorizer

train_txt_path = "train.txt"
test_txt_path = "test.txt"
result_txt_path = "result.txt"

relations = ["Cause-Effect", "Component-Whole", "Entity-Destination", "Product-Producer", "Entity-Origin",
             "Member-Collection", "Message-Topic", "Content-Container", "Instrument-Agency", "Other"]

file_train = open(train_txt_path)
train_sentences = []
train_relations = []
for i in range(6400):
    train_sentences.append(file_train.readline().split('"')[1].strip('"').strip('.'))
    train_relations.append(relations.index(file_train.readline().split('(')[0]))

#print(train_sentences)
#print(train_relations)
file_test = open(test_txt_path)
test_sentences = []
for i in range(1600):
    test_sentences.append(file_test.readline().split('"')[1].strip('"').strip('.'))

tf_idf_vec = TfidfVectorizer()
train_vec = tf_idf_vec.fit_transform(train_sentences)
test_vec = tf_idf_vec.transform(test_sentences)

classifier = MultinomialNB(alpha = 0.7)
classifier.fit(train_vec, train_relations)
test_result = classifier.predict(test_vec)

file_result = open(result_txt_path, 'w+')
for i in range(1600):
    file_result.write(relations[test_result[i]]+'\n')

file_train.close()
file_test.close()
file_result.close()


