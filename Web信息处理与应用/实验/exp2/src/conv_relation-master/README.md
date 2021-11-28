## Dependency

- tensorflow 1.4.0
- python 3.5
- linux,macOs or windows

## Run

在主目录下依次执行

```sh
#原始的6400个测试集位于train.cln
python src/gen_test_cln.py	#根据关系抽取得到的test.txt生成test.cln（将对应的关系标签均设置为0）和result_entity_pair.txt（实体识别到的实体对）
python src/train.py	#训练模型
python src/train.py --num_epochs=200 --word_dim=50 --test	#生成关系
python src/gen_final_res.py	#根据关系和实体对生成最终的结果文件
```

`cln`文件格式

```
[标签] [entity1_begin] [entity1_end] [entity2_begin] [entity2_end] [text]
```

