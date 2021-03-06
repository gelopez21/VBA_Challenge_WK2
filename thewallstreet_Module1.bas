Attribute VB_Name = "Module1"
Sub thewallstreet_loops()

Dim ws As Worksheet
For Each ws In ActiveWorkbook.Worksheets
ws.Activate
    
Dim ticker_name As String
Dim total_stock_volume As Double
Dim percent_change As Double
Dim open_date_price As Double
Dim close_date_price As Double
Dim price_change As Double
Dim row_count As Double
Dim i As Long
row_count = 2
total_stock_volume = 0
lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row

Cells(1, "I").Value = "Ticker"
Cells(1, "J").Value = "Yearly Change"
Cells(1, "K").Value = "Percent Change"
Cells(1, "L").Value = "Total Stock Volume"

open_date_price = Cells(2, 3).Value
    
    For i = 2 To lastrow
        If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
            ticker_name = Cells(i, 1).Value
                Cells(row_count, 9).Value = ticker_name
            close_date_price = Cells(i, 6).Value
            price_change = close_date_price - open_date_price
                Cells(row_count, 10).Value = price_change
            total_stock_volume = total_stock_volume + Cells(i, 7).Value
                Cells(row_count, 12).Value = total_stock_volume
                                
            If (open_date_price = 0 And Close_price = 0) Then
                    percent_change = 0
                ElseIf (open_date_price = 0 And close_date_price <> 0) Then
                    percent_change = 1
                Else
                    percent_change = price_change / open_date_price
                    Cells(row_count, 11).Value = percent_change
                    Cells(row_count, 11).NumberFormat = "0.00%"
            End If
            
            row_count = row_count + 1
            open_date_price = Cells(i + 1, 3).Value
            total_stock_volume = 0
        Else
            total_stock_volume = total_stock_volume + Cells(i, 7).Value
        End If
    Next i

'MODERATE

ts_lastrow = ws.Cells(Rows.Count, 9).End(xlUp).Row
    For j = 2 To ts_lastrow
        If Cells(j, 10).Value > 0 Or Cells(j, 10).Value = 0 Then
            Cells(j, 10).Interior.ColorIndex = 22
        ElseIf Cells(j, 10).Value < 0 Then
            Cells(j, 10).Interior.ColorIndex = 43
        End If
    Next j

    
'High
Cells(2, 14).Value = "Greatest Percent Increase"
Cells(3, 14).Value = "Greatest Percent Decrease"
Cells(4, 14).Value = "Greatest Total  Stock Volume"
Cells(1, 15).Value = "Ticker"
Cells(1, 16).Value = "Total"
            
    For m = 2 To ts_lastrow
        If Cells(m, 11).Value = Application.WorksheetFunction.Max(ws.Range("K2:K" & ts_lastrow)) Then
            Cells(2, 15).Value = Cells(m, 9).Value
            Cells(2, 16).Value = Cells(m, 11).Value
            Cells(2, 16).NumberFormat = "0.00%"
        ElseIf Cells(m, 11).Value = Application.WorksheetFunction.Min(ws.Range("K2:K" & ts_lastrow)) Then
            Cells(3, 15).Value = Cells(m, 9).Value
            Cells(3, 16).Value = Cells(m, 11).Value
            Cells(3, 16).NumberFormat = "0.00%"
        ElseIf Cells(m, 12).Value = Application.WorksheetFunction.Max(ws.Range("L2:L" & ts_lastrow)) Then
                Cells(4, 15).Value = Cells(m, 9).Value
                Cells(4, 16).Value = Cells(m, 12).Value
        End If
    
    Next m

Next ws


End Sub
        

