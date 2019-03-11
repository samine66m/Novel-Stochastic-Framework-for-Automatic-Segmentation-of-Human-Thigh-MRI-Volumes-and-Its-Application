function Parameters = getParameters(handles)

Parameters.windowSize = eval(get(handles.InitialWindowSize_Input,'String'));
Parameters.maxWindowSize = eval(get(handles.MaxWindowSize_Input,'String'));
Parameters.tolerance = eval(get(handles.Tolerance_Input,'String'));
Parameters.tlrIncreStep = eval(get(handles.ToleranceIncrement_Input,'String'));
Parameters.Thr = eval(get(handles.LocalWeightThr_input,'String'));

Parameters.KeepLabel= eval(get(handles.KeepLabel_Input,'String'));


end