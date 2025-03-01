import json
from argparse import ArgumentParser


def fileRead(fname, flag):
    lines = []

    if (flag == 0):
        with open(fname, "r") as f:
            data = json.load(f)

        for line in data:
            line = line.rstrip('\r\n')
            lines.append(line)
    else:
        print("Reading file: " + fname)
        with open(fname) as f:
            for line in f:
                line = line.rstrip('\r\n')
                lines.append(line)

    f.close()
    return lines


def store_labels(lines):
    labels = []
    for line in lines:
        explanation_label = line.split(" ")[0]
        labels.append(explanation_label)
    return labels



# read the json file [text.in.tok.sent_len_min_0_max_1000000_del_1000000-dataset.json] (token & token representation)
def read_dataset_file(filename):
    sentence_idx = []
    word_idx = []
    
    with open(filename, 'r') as f:
        for line in f:
            # Format: token|||token_info|||sentence_id|||token_id|||cluster_id
            parts = line.strip().split('|||')
            if len(parts) == 5:
                sentence_idx.append(int(parts[2]))
                word_idx.append(int(parts[3]))
    
    return sentence_idx, word_idx


def generate_word_explanation(sentence_idx, word_idx, labels):
    """
    Generate word explanations by combining labels with sentence and word indices.
    
    Parameters:
    -----------
    sentence_idx : list of int
        List of sentence indices
    word_idx : list of int
        List of word indices
    labels : list of str
        List of labels/predictions
        
    Returns:
    --------
    list of str
        Combined explanations in format: "label word_idx sentence_idx"
    """
    word_explanations = []
    for i in range(len(sentence_idx)):
        # Convert all components to strings before concatenation
        word_explanation = str(labels[int(sentence_idx[i])]) + " " + str(word_idx[i]) + " " + str(sentence_idx[i])
        word_explanations.append(word_explanation)
    return word_explanations


def write_word_explanation(fname, word_explanations):
    with open(fname, 'w') as outfile:
        for word_explanation in word_explanations:
            outfile.write(word_explanation + '\n')


def main():
    parser = ArgumentParser()
    parser.add_argument("-i", "--datasetFile", dest="c",
                      help="Cluster File", metavar="FILE")
    parser.add_argument("-e", "--explanationFile", dest="e",
                      help="Explanation File", metavar="FILE")
    parser.add_argument("-s", "--saveFile", dest="s",
                      help="New Explanation File save path", metavar="FILE")

    args = parser.parse_args()

    explanationFile = fileRead(args.e, 1)
    labels = store_labels(explanationFile)
    sentence_idx, word_idx = read_dataset_file(args.c)
    word_explanations = generate_word_explanation(sentence_idx, word_idx, labels)
    write_word_explanation(args.s, word_explanations)


if __name__ == "__main__":
    main()


