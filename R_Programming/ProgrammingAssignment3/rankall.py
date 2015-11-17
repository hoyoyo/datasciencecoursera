import pandas as pd
import numpy as np
from os import path, listdir

def rankall(outcome, num='best'):
    """
    rank hospital for each state based on the mortality of the outcome
    """
    outcome_file = 'outcome-of-care-measures.csv'
    if not path.exists(outcome_file):
        outcome_file = path.join('Hospital', outcome_file)

    stats = pd.read_csv(outcome_file)
    columns = stats.columns.values
    loc_name = 1
    loc_state = 6

    dict_outcome = {'heart attack': 10, 'heart failure': 16, 'pneumonia': 22}
    try:
        loc_outcome = dict_outcome[outcome]
    except KeyError:
        raise Exception('invalid outcome')

    # convert the column to numerics
    stats.iloc[:, loc_outcome] = stats.iloc[:, loc_outcome].convert_objects(convert_numeric=True)
    # drop the NAs
    sub_stats = stats.dropna(axis=0, subset=[columns[loc_outcome]]).iloc[:, [loc_name,loc_state,loc_outcome]]

    # handler for ranking the hospitals
    def ranker(df, num):
        if not isinstance(num, int):
            dict_num = {'best':0, 'worst':len(df) - 1}
            num = dict_num[num]
        else:
            num -= 1
        # if num exceeds the number of entries for the state
        # return None    
        if num > len(df) - 1:
            ret = pd.DataFrame({'Hospital.Name':None, \
                                'State':df.State.unique()[0]}, \
                               index=np.arange(1))
        else:
            df.set_index(np.arange(len(df)), inplace=True)
            ret = pd.DataFrame({'Hospital.Name':df.ix[num][0], \
                                'State':df.ix[num][1]}, \
                               index=np.arange(1))
        return ret
        
    sub_stats.sort([columns[loc_outcome], columns[loc_name]], ascending=True, inplace=True)

    # wrap up the ranker with a lambda function
    by_state = sub_stats.groupby('State').apply(lambda x:ranker(x, num))

    # clean the multi-index of by_state
    return by_state.set_index(by_state.index.get_level_values('State'))
    
    

