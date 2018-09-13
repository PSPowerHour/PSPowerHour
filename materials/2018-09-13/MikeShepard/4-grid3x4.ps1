# Simple example showing how to put items in a grid.  Note that the number of rows is determined by the number of controls and the column count.
#There is no output from Dialog in this case because Labels don't have output.
# For output, change Label to Textbox.

Window {
      Grid -columnCount 3   {
        1..12 | ForEach-Object { label -name "Blah$_" -Text "Blah$_"}
      }
   } -ShowForValue

