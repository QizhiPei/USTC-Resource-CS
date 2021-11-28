# 标签类型 B-1  I-1 O

test_num = 1600
test_txt_path = "./data/test.txt"
test_cln_path = "./data/test.cln"
result_entity_pair = "./data/result_eneity_pair.txt"

file_test_txt = open(test_txt_path, 'r')
file_test_cln = open(test_cln_path, 'w')
file_test_entity_pair = open(result_entity_pair, 'w')

for i in range(test_num):
    index = -1
    entity1 = 0
    entity2 = 0
    flag1 = False
    flag2 = False
    entity1_temp = 'None'
    entity2_temp = 'None'
    line_temp = ''
    while 1:
        read_temp = file_test_txt.readline().split(' ')
        index += 1
        #print(read_temp)
        if read_temp[0] == '\n':
            break
        elif read_temp[1].strip() == 'B-1' and flag1 == False:
            entity1 = index
            flag1 = True
            entity1_temp = read_temp[0]
        elif read_temp[1].strip() == 'B-1' and flag2 == False:
            entity2 = index
            flag2 = True
            entity2_temp = read_temp[0]
        line_temp += read_temp[0] + ' '
    file_test_cln.write(str(0) + ' ' + str(entity1) + ' ' + str(entity1) + ' '
                        + str(entity2) + ' ' + str(entity2) + ' ' + line_temp + '\n')
    file_test_entity_pair.write(entity1_temp + ',' + entity2_temp + '\n')
    #print(i)

file_test_txt.close()
file_test_cln.close()
file_test_entity_pair.close()