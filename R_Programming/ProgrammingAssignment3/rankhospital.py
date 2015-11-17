import pandas as pd
import numpy as np
from os import path, listdir


def rankhospital(state, outcome, num='best'):
    """
    """

    # heart failure - column 17
    # heart attack  - column 11
    # pneumonia     - column 23
    
    outcome_file = "Hospital/outcome-of-care-measures.csv"
    if not path.exists(outcome_file):
        raise IOError
    stats = pd.read_csv(outcome_file)
    dict_outcome = {'heart failure': 16, 'heart attack': 10, 'pneumonia': 22}
    dict_rank = {'best' : 1}
    columns = stats.columns.values

    allStates = stats.State.unique().astype(str).tolist()
    if not state in allStates:
        raise Exception('invalid state')
    if not outcome in dict_outcome.keys():
        raise Exception('invalid outcome')

    loc_outcome = dict_outcome[outcome]
    stats.iloc[:, loc_outcome] = stats.iloc[:, loc_outcome].convert_objects(convert_numeric=True)

    stats1 = stats.dropna(axis=0, subset=[ columns[loc_outcome] ]).sort([columns[loc_outcome], columns[1]], ascending=True)

    def ranker(df):
        df['state_rank'] = np.arange(len(df)) + 1
        return df

    stats2 = stats1.groupby('State').apply(ranker)
    stats3 = stats2[stats2.State == state]

    dict_rank.update({'worst' : len(stats3)})
    if isinstance(num, str):
        rank_out = dict_rank[num]
    else:
        rank_out = num
    if rank_out > len(stats3):
        print "NA"
        return

    ret = stats3[stats3.state_rank==rank_out].iloc[:, 1]
    print ret

    
    
    
        
    
