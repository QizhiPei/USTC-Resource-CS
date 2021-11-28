from surprise import BaselineOnly
from surprise import Dataset
from surprise import Reader
from surprise.model_selection import cross_validate
import os

# Load the movielens-100k dataset (download it if needed).
#data = Dataset.load_builtin('ml-100k')
file_path = os.path.expanduser("../train1.csv")
#reader = Reader(line_format="user item rating timestamp", sep=',')
reader = Reader(line_format="user item rating timestamp",
                sep=',', rating_scale=(0, 5))

data = Dataset.load_from_file(file_path, reader=reader)

'''
file_path1 = os.path.expanduser("../test1.csv")

reader1 = Reader(line_format="user item rating", sep=',')

data = Dataset.load_from_file(file_path, reader=reader)
data1 = Dataset.load_from_file(file_path1, reader=reader1)
'''
trainset = data.build_full_trainset()
#testset = data1.build_full_trainset()
# Use the famous SVD algorithm.
algo = BaselineOnly()

# Run 5-fold cross-validation and print results.
#cross_validate(algo, data, measures=['RMSE', 'MAE'], cv=5, verbose=True)
algo.fit(trainset)
'''
predictions = algo.test(testset)

print(predictions)
'''
'''
uid = str(0)  # raw user id (as in the ratings file). They are **strings**!
iid = str(35546)  # raw item id (as in the ratings file). They are **strings**!

# get a prediction for specific users and items.
pred = algo.predict(uid, iid, verbose=True)
print(pred[3])
'''

relation_file = open("../relation.txt", "r")
relation_dict = {}
for line in relation_file:
    temp0 = line.split(":")
    relation_dict[temp0[0].strip()] = temp0[1].strip()

#print(relation_dict)
#print(relation_dict[str(2159)])


testset = open("../test1.csv", "r")
result = open("./result/result_BaselineOnly.txt", "w")
full_result = open("./full_result/result_BaselineOnly.txt", "w")

for line in testset:
    temp = line.split(",")
    pred = algo.predict(temp[0], temp[1], verbose=False)
    #score = round(pred[3])
    score = pred[3]
    if str(temp[0]) in relation_dict.keys():
        sum_score = 0
        member_list = relation_dict[str(temp[0])].split(",")
        num = len(member_list)
        for i in range(num):
            sum_score = (algo.predict(member_list[i], temp[1], verbose=False))[3] + sum_score
        #print("calculate")
        final_score = round(0.9 * score + 0.1 * (sum_score / num))
    #result.write(str(score) + "\n")
    result.write(str(final_score) + "\n")
    #full_result.write(str(pred[3]) + "\n")

