result_entity_pair = "./data/result_eneity_pair.txt"
result = "./data/results.txt"
final_result = "./data/final_result.txt"

test_num = 1600
file_result_entity_pair = open(result_entity_pair, 'r')
file_result = open(result, 'r')
file_final_result = open(final_result, 'w')
for i in range(test_num):
    file_final_result.write(file_result.readline().strip() + '&' + file_result_entity_pair.readline().strip() + '\n')

file_result_entity_pair.close()
file_result.close()
file_final_result.close()