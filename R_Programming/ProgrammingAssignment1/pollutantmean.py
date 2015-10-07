import pandas as pd
import numpy as np
from os import path

def pollutantmean(directory, pollutant, idx=range(1,333)):
    """
    directory: the location of the CSV files
    pollutant: the name of the pollutant for which we will calculate the mean;
               either "sulfate" or "nitrate"
    idx:       the integer vector indicating the monitor ID numbers to be used

    Return the mean of the pollutant across all monitors list in the 'id' vector
    NA values will be dropped
    """
    if type(idx) == int:
        idx = np.array([idx])

    retMean = 0.0
    col = None    
    for monitor in idx:
        if monitor < 10:
            location = path.join(directory, "00"+str(monitor)+".csv")
        elif monitor < 100:
            location = path.join(directory, "0"+str(monitor)+".csv")
        else:
            location = path.join(directory, str(monitor)+".csv")

        data = pd.read_csv(location)
        if col is None:
            col = data.loc[:, [pollutant]].dropna()
        else:
            col.append(data.loc[:, [pollutant]].dropna(), ignore_index=True)

    return col.mean()    
            
