import numpy as np
import pandas as pd
from os import path

def complete(directory, idx=range(1, 333)):
    """
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    """
    if type(idx) == int:
        idx = np.array([idx])
    ret = pd.DataFrame(data = None, index=None ,columns=['idx', 'nobs'])
    pos = 1
    for monitor in idx:
        if monitor < 10:
            location = path.join(directory, "00"+str(monitor)+".csv")
        elif monitor < 100:
            location = path.join(directory, "0"+str(monitor)+".csv")
        else:
            location = path.join(directory, str(monitor)+".csv")

        data = pd.read_csv(location)
        ret = ret.append(pd.DataFrame({'idx':monitor, 'nobs':data.dropna().shape[0]}, \
                                      index = np.array([pos]), columns=['idx', 'nobs']))
        pos += 1

    return ret
