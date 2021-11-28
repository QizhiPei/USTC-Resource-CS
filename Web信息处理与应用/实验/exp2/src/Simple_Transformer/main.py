from simpletransformers.classification import ClassificationModel, ClassificationArgs
import pandas as pd
import logging

def main():
    logging.basicConfig(level=logging.INFO)
    transformers_logger = logging.getLogger("transformers")
    transformers_logger.setLevel(logging.WARNING)

    train_txt_path = "train.txt"
    test_txt_path = "test.txt"
    result_txt_path = "result.txt"

    relations = ["Cause-Effect", "Component-Whole", "Entity-Destination", "Product-Producer", "Entity-Origin",
                 "Member-Collection", "Message-Topic", "Content-Container", "Instrument-Agency", "Other"]

    file_train = open(train_txt_path)
    train_data = []
    for i in range(6400):
        temp = []
        temp.append(file_train.readline().split('"')[1].strip('"').strip('.'))
        temp.append(relations.index(file_train.readline().split('(')[0]))
        train_data.append(temp)
    #print(train_data)

    train_df = pd.DataFrame(train_data)
    train_df.columns = ["text", "labels"]

    '''
    model_args = ClassificationArgs(num_train_epochs=1)
    model = ClassificationModel(
        'bert',
        'bert-base-cased',
        num_labels=10,
        args=model_args,
        use_cuda=False
    )

    # Train the model
    model.train_model(train_df, output_dir='./model')
    '''
    model = ClassificationModel(
        "bert",
        "model/checkpoint-800-epoch-1",
        use_cuda=False
        )

    file_test = open(test_txt_path)
    test_sentences = []
    for i in range(1600):
        test_sentences.append(file_test.readline().split('"')[1].strip('"').strip('.'))

    test_result, raw_result = model.predict(test_sentences)
    print(test_result)
    file_result = open(result_txt_path, 'w+')
    for i in range(1600):
        file_result.write(relations[test_result[i]] + '\n')
    file_train.close()
    file_test.close()
    file_result.close()

if __name__ == "__main__":
    main()