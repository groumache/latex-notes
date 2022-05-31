# Why delete the first page of a pdf ?
#   Because I want to see pages side by side as if it were printed document
#   instead of having the cover ruin the pages order.

from PyPDF2 import PdfFileWriter, PdfFileReader
infile = PdfFileReader('tfe.pdf', 'rb')
output = PdfFileWriter()

for i in range(1, infile.numPages):
    page = infile.getPage(i)
    output.addPage(page)

with open('tfe1.pdf', 'wb') as f:
    output.write(f)