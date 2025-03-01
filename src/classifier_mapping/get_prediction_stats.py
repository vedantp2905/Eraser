""" Get the prediction stats for the classification result

This script is used to get the prediction stats for the classification result.

"""

import pandas as pd
import argparse
import os


# read the file 'predictions_layer_0.csv'
def read_csv(file_path, layer):
    """
    Read the Classification result (csv file)

    Parameters:
    ----------
    file_path: str
        The path of the csv file

    layer: str
        The layer of the csv file

    Returns:
    -------
    df: pandas.DataFrame
        The dataframe of the csv file
    """
    csv_file_path = f"{file_path}/predictions_layer_{layer}.csv"
    df = pd.read_csv(csv_file_path, sep='\t')
    return df


def check_predictions(df, save_path=None):
    """
    Check the predictions with top 5 prediction results and the accuracy of each top 1, top 2, top 5

    Parameters:
    ----------
    df: pandas.DataFrame
        The dataframe of the csv file
    save_path: str, optional
        Path to save the statistics
    """

    top1 = 0
    top2 = 0
    top5 = 0
    no_match = 0

    for i in range(len(df)):
        if str(df['Actual'][i]) == str(df['Top 1'][i]):
            top1 += 1

        if str(df['Actual'][i]) in df['Top 2'][i]:
            top2 += 1

        if str(df['Actual'][i]) in df['Top 5'][i]:
            top5 += 1
        else:
            no_match += 1

    stats = [
        f"Layer: {args.layer}",
        f"Total Tokens: {len(df)}",
        f"Match with Top 1: {top1}, Percentage: {top1/len(df)*100}%",
        f"Match with Top 2: {top2}, Percentage: {top2/len(df)*100}%",
        f"Match with Top 5: {top5}, Percentage: {top5/len(df)*100}%",
        f"No Match: {no_match}, Percentage: {no_match/len(df)*100}%",
        "---------------------------------------------------"
    ]

    # Print to console
    for stat in stats:
        print(stat)

    # Save to file if path provided
    if save_path:
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        with open(save_path, 'w') as f:
            for stat in stats:
                f.write(stat + '\n')


def get_all_layer_stats():
    """
    Get the prediction stats for all layers
    """
    for i in range(13):
        args.layer = str(i)
        df = read_csv(args.file_path, args.layer)
        check_predictions(df)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    parser.add_argument('--layer', type=str, default=12, help='layer number (can have multiple layers separated by comma)')
    parser.add_argument('--all_layer_stats', action='store_true', help='get all layer stats')
    parser.add_argument('--file_path', type=str, default='./LR_classification/', help='file path')
    parser.add_argument('--save_path', type=str, help='path to save the statistics')

    args = parser.parse_args()

    if args.all_layer_stats:
        get_all_layer_stats()
    else:
        choose_layer = args.layer.split(',')
        for layer in choose_layer:
            args.layer = layer
            df = read_csv(args.file_path, args.layer)
            check_predictions(df, args.save_path)
