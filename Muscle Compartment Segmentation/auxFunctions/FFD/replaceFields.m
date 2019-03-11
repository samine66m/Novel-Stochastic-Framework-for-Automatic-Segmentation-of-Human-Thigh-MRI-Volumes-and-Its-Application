%> A = replaceFields(ElementSize,ElementSpacing,DimSize,DataType,elementDataFile)
%> @file replaceFields.m
%> @author Ahmed Soliman
%> @date   January, 2014
%> @version 2.0
% ======================================================================
%> @brief replaceFields function
%>
%> This function updates the fields of MHD header file with new values.
% ======================================================================

function A = replaceFields(ElementSize,ElementSpacing,DimSize,DataType,elementDataFile)

    elementDataFileRAW = [elementDataFile '.raw'];
    fid = fopen('empHeader.mhd','r+');

    %fline=fgetl(fid)

    lineNo=1;

    while ~feof(fid)

        fline=fgetl(fid);

        if strfind(fline,'ElementSize')
            line1=fline;
            lineNo1=lineNo;
        elseif strfind(fline,'ElementSpacing')
            line2=fline;
            lineNo2=lineNo;
        elseif strfind(fline,'DimSize')
            line3=fline;
            lineNo3=lineNo;
        elseif strfind(fline,'ElementDataFile')
            line4=fline;
            lineNo4=lineNo;
        elseif strfind(fline,'ElementType')
            line5=fline;
            lineNo5=lineNo;
            mdataType = getMDataType(DataType);
        end

        lineNo = lineNo+1;

    end

    A = regexp( fileread('empHeader.mhd'), '\n', 'split');
    A{lineNo1} = ['ElementSize = ' num2str(ElementSize(1)) ' ' num2str(ElementSize(2)) ' ' num2str(ElementSize(3)) A{1}(end)];
    A{lineNo2} = ['ElementSpacing = ' num2str(ElementSpacing(1)) ' ' num2str(ElementSpacing(2)) ' ' num2str(ElementSpacing(3)) A{1}(end)];
    A{lineNo3} = ['DimSize = ' num2str(DimSize(2)) ' ' num2str(DimSize(1)) ' ' num2str(DimSize(3)) A{1}(end)];
    A{lineNo4} = ['ElementDataFile = ' elementDataFileRAW A{1}(end)];
    A{lineNo5} = ['ElementType = ' mdataType A{1}(end)];


    eval(sprintf('fid = fopen(''%s.mhd'', ''w'');',elementDataFile));
    fprintf(fid, '%s\n', A{1:end-1});
    fprintf(fid, '%s', A{end});
    fclose(fid);
end


function mdataType = getMDataType(dataType)
    switch dataType
        case 'int8'
            mdataType = 'MET_CHAR';
        case 'uint8'
            mdataType = 'MET_UCHAR';
        case 'int16'
            mdataType = 'MET_SHORT';
        case 'uint16'
            mdataType = 'MET_USHORT';
        case 'int32'
            mdataType = 'MET_INT';
        case 'uint32'
            mdataType = 'MET_UINT';
        case 'single'
            mdataType = 'MET_FLOAT';
        case 'double'
            mdataType = 'MET_DOUBLE';
        otherwise
            mdataType = 'MET_SHORT';           
    end     
end

