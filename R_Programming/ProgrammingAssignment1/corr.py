import pandas as pd
import numpy as np
from os import path, listdir

def cor(directory, threshold=0):
    """
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0

    ## Return a numeric vector of correlations
    ## NOTE: Do not round the result!
    """
    files = listdir(directory)
    files.sort()
    ret = pd.Series(None, dtype=np.float32)
    for ipf in files:
        ipfName = path.join(directory, ipf)
        if path.isfile(ipfName):
            data = pd.read_csv(ipfName)
            data = data.dropna()
            if len(data) >= threshold:
                nitrate = data['nitrate']
                sulfate = data['sulfate']
                ret.set_value(files.index(ipf)+1, nitrate.corr(sulfate))

    return ret
    

    
