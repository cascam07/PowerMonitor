# -*- coding: utf-8 -*-
"""
Created on Thu Jun 28 10:35:04 2018

@author: camer
"""
import sys
import os
import os.path as op
import warnings
import inspect
import numpy as np
from numpy.testing import assert_array_equal, assert_allclose
from scipy import io as sio
from mne import find_events, pick_types
from mne.io import read_raw_egi
from mne.io.tests.test_raw import _test_raw_reader
from mne.io.egi.egi import _combine_triggers
from mne.utils import run_tests_if_main
from mne.datasets.testing import data_path, requires_testing_data
from mne.realtime import RtEpochs, MockRtClient
import mne
import datetime as dt

def GetMffData(mff_file, seglen):
    sys.stdout = open(os.devnull,'w') #suppress text output
    seglen = int(seglen)

    startload = dt.datetime.now()    
    #Read mff and get last seglen of data
    raw = read_raw_egi(mff_file, include=None, preload=False)
    sfreq = raw.info['sfreq']
    newdat = raw[:,raw.n_times-(seglen*int(sfreq)):raw.n_times-1]
    data = newdat[0]
    times = newdat[1]
    raw.close()

    #Save raw data and sample times to csv files
    np.savetxt('Power.csv', data, delimiter=',')
    np.savetxt('Times.csv', times, delimiter=',')

    #return the amount of time it took to complete task
    endload = dt.datetime.now()
    loadtime = endload.timestamp() - startload.timestamp()
    sys.stdout = sys.__stdout__ #re-enable text output
    return loadtime  

print(GetMffData(sys.argv[1], sys.argv[2]))


